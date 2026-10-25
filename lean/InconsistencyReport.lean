/-
  Proven logical inconsistency table for README.md.

  The catalog is every theorem, in a module this package elaborates,
  whose type is False, a chain of assumptions ending in False, or an
  alias whose name ends in IsFalse or IsInconsistent. A Bool flag equal
  to false is not an inconsistency. A proof whose body is only
  Bool.noConfusion, or only nomatch, on a hypothesis that a boolean
  defined as false equals true, is not a checker row. A proof that
  reads specification text, decides meetsPdoss, or otherwise derives
  False from something other than that flag, stays. Reasoning lives
  in RESIDUAL.md.

  Numbered markdown remains the contract humans read. This module
  is a checker. It is not a second markdown form suite.
-/

import Lean
import SessionBusProofs
import Surmount

open Lean Elab Command Parser

namespace InconsistencyReport

/-- Marker that opens the generated table in README.md. -/
def beginMarker : String := "<!-- inconsistency-report -->"

/-- Marker that closes the generated table in README.md. -/
def endMarker : String := "<!-- /inconsistency-report -->"

def readmeFileName : String := "README.md"

def residualFileName : String := "RESIDUAL.md"

/-- Kind of a listed claim. Intentional nonconformance is not a stack bug. -/
inductive ClaimKind where
  | intentionalNonconformance
  deriving DecidableEq, Repr, BEq

def ClaimKind.label : ClaimKind → String
  | .intentionalNonconformance => "intentional nonconformance theorem"

structure ProvenClaim where
  file : String
  claim : String
  kind : ClaimKind
  deriving DecidableEq, Repr, BEq

def strEnds (s suf : String) : Bool :=
  let sc := s.toList
  let pc := suf.toList
  sc.length >= pc.length && sc.drop (sc.length - pc.length) == pc

def lastNameStr : Name → String
  | .str _ s => s
  | .num p _ => lastNameStr p
  | .anonymous => ""

def isFalseAlias (n : Name) : Bool :=
  let s := lastNameStr n
  strEnds s "IsFalse" || strEnds s "IsInconsistent"

/-- A conclusion of False, or an IsFalse or IsInconsistent alias. Not `= false`. -/
def isInconsistencyExpr : Expr → Bool
  | .forallE _ _ b _ => isInconsistencyExpr b
  | .mdata _ b => isInconsistencyExpr b
  | .letE _ _ _ b _ => isInconsistencyExpr b
  | .const n _ => n == ``False || isFalseAlias n
  | _ => false

def infoIsTheorem : ConstantInfo → Bool
  | .thmInfo _ => true
  | _ => false

def isProjectModule (m : Name) : Bool :=
  let s := m.toString
  !(s == "Init" || strEnds s ".Init" || s.startsWith "Init."
    || s == "Lean" || s.startsWith "Lean."
    || s == "Std" || s.startsWith "Std."
    || s == "Lake" || s.startsWith "Lake.")

def moduleToFile (m : Name) : String :=
  "lean/" ++ m.toString ++ ".lean"

def insertPair (p : String × String) : List (String × String) → List (String × String)
  | [] => [p]
  | h :: t =>
    if p.1 < h.1 || (p.1 == h.1 && p.2 < h.2) then
      p :: h :: t
    else if p.1 == h.1 && p.2 == h.2 then
      h :: t
    else
      h :: insertPair p t

def emitClaim (file claim : String) : String :=
  "  { file := \"" ++ file ++ "\", claim := \"" ++ claim ++
    "\", kind := ClaimKind.intentionalNonconformance }"

/-- Elaborator auxiliaries such as `_proof_2` are not catalog rows. -/
def isAuxiliaryName (n : Name) : Bool :=
  let s := lastNameStr n
  s == "" || s.startsWith "_"

/-- A definition fact used to see a boolean defined as false. -/
inductive FlagDef where
  | boolFalse
  | boolAlias (target : String)
  | eqTrue (lhs : String)
  | impliesFalse (hyp : String)
  deriving BEq

def collapseWs (s : String) : String :=
  let chars := s.toList.map fun c =>
    if c == '\n' || c == '\t' || c == '\r' || c == ';' then ' ' else c
  let rec squeeze : List Char → List Char → Bool → List Char
    | [], acc, _ => acc
    | ' ' :: rest, acc, true => squeeze rest acc true
    | ' ' :: rest, acc, false => squeeze rest (' ' :: acc) true
    | c :: rest, acc, _ => squeeze rest (c :: acc) false
  let rev := (squeeze chars [] true).dropWhile (· == ' ')
  String.ofList rev.reverse

def stripLineComment (line : String) : String :=
  match line.splitOn "--" with
  | head :: _ => head
  | [] => line

def stripComments (s : String) : String :=
  String.intercalate "\n" ((s.splitOn "\n").map stripLineComment)

def wordsOf (s : String) : List String :=
  (collapseWs (stripComments s)).splitOn " " |>.filter (· != "")

def isBareIdent (w : String) : Bool :=
  w != "" && w.all fun c => c.isAlphanum || c == '_' || c == '\''

def withoutSuffix (s suf : String) : String :=
  let sc := s.toList
  let pc := suf.toList
  if sc.length >= pc.length && sc.drop (sc.length - pc.length) == pc then
    String.ofList (sc.take (sc.length - pc.length))
  else
    s

/-- Body is only `intro` plus `exact Bool.noConfusion`, or only that exact. -/
def isOnlyNoConfusionBody (body : String) : Bool :=
  match wordsOf body with
  | ["by", "intro", x, "exact", "Bool.noConfusion", y] => isBareIdent x && isBareIdent y
  | ["by", "exact", "Bool.noConfusion", y] => isBareIdent y
  | ["exact", "Bool.noConfusion", y] => isBareIdent y
  | _ => false

/-- Body is only `nomatch`, with an optional intro. -/
def isOnlyNomatchBody (body : String) : Bool :=
  match wordsOf body with
  | ["nomatch", y] => isBareIdent y
  | ["by", "nomatch", y] => isBareIdent y
  | ["by", "intro", x, "nomatch", y] => isBareIdent x && isBareIdent y
  | _ => false

def lhsOfEqTrue (t : String) : Option String :=
  match (collapseWs t).splitOn " = " with
  | [lhs, "true"] => some lhs
  | _ => none

def hypOfImpliesFalse (t : String) : Option String :=
  let t := collapseWs t
  let cut (suf : String) : Option String :=
    let core := withoutSuffix t suf
    if core == t then none else some (collapseWs core)
  match cut " → False" with
  | some h => some h
  | none => cut " -> False"

def lookupFlag (facts : List (String × FlagDef)) (n : String) : Option FlagDef :=
  facts.findSome? fun p => if p.1 == n then some p.2 else none

/-- Structural fuel. Well founded `fuel - 1` made the checker time out at whnf. -/
def fuelList (fuel : Nat) : List Unit :=
  List.replicate fuel ()

def isBoolFalseNameGo (facts : List (String × FlagDef)) (n : String) : List Unit → Bool
  | [] => false
  | _ :: fuel =>
    match lookupFlag facts n with
    | some .boolFalse => true
    | some (.boolAlias t) => isBoolFalseNameGo facts t fuel
    | _ => false

def isBoolFalseName (facts : List (String × FlagDef)) (n : String) (fuel : Nat) : Bool :=
  isBoolFalseNameGo facts n (fuelList fuel)

/-- First module that defines `n` wins, so the theorem file and its imports outrank later files. -/
def lookupFlagMod (mods : List (List (String × FlagDef))) (n : String) : Option FlagDef :=
  mods.findSome? fun facts => lookupFlag facts n

def isBoolFalseNameModGo (mods : List (List (String × FlagDef))) (n : String) : List Unit → Bool
  | [] => false
  | _ :: fuel =>
    match lookupFlagMod mods n with
    | some .boolFalse => true
    | some (.boolAlias t) => isBoolFalseNameModGo mods t fuel
    | _ => false

def isBoolFalseNameMod (mods : List (List (String × FlagDef))) (n : String) (fuel : Nat) : Bool :=
  isBoolFalseNameModGo mods n (fuelList fuel)

def resolvesFalseBoolEqTrueModGo (mods : List (List (String × FlagDef))) (t : String) :
    List Unit → Bool
  | [] => false
  | _ :: fuel =>
    let t := collapseWs t
    match hypOfImpliesFalse t with
    | some h => resolvesFalseBoolEqTrueModGo mods h fuel
    | none =>
      match lhsOfEqTrue t with
      | some lhs => isBareIdent lhs && isBoolFalseNameMod mods lhs 8
      | none =>
        match lookupFlagMod mods t with
        | some (.eqTrue lhs) => resolvesFalseBoolEqTrueModGo mods (lhs ++ " = true") fuel
        | some (.impliesFalse hyp) => resolvesFalseBoolEqTrueModGo mods hyp fuel
        | _ => false

/-- True when `t` unfolds to `flag = true` and `flag` is defined as false. -/
def resolvesFalseBoolEqTrueMod (mods : List (List (String × FlagDef))) (t : String) (fuel : Nat) : Bool :=
  resolvesFalseBoolEqTrueModGo mods t (fuelList fuel)

/-- True when `t` unfolds to `flag = true` and `flag` is defined as false. -/
def resolvesFalseBoolEqTrue (facts : List (String × FlagDef)) (t : String) (fuel : Nat) : Bool :=
  resolvesFalseBoolEqTrueMod [facts] t fuel

/-- Last binder type in a signature, for `(h : T) : False`. -/
def binderType (sig : String) : Option String :=
  let s := withoutSuffix (collapseWs (stripComments sig)) " : False"
  let s := withoutSuffix s ")"
  let parts := s.splitOn "("
  let last := parts.reverse.headD ""
  match last.splitOn " : " with
  | _ :: ty :: rest =>
    some (collapseWs (String.intercalate " : " (ty :: rest)))
  | _ => none

def columnZeroDecl (line : String) : Bool :=
  if line.startsWith " " || line.startsWith "\t" then false else
  let t := collapseWs line
  t.startsWith "theorem " || t.startsWith "lemma " || t.startsWith "def " ||
    t.startsWith "noncomputable def " || t.startsWith "abbrev " ||
    t.startsWith "inductive " || t.startsWith "structure " || t.startsWith "class " ||
    t.startsWith "instance " || t.startsWith "namespace " || t.startsWith "section " ||
    t.startsWith "end " || t == "end" || t.startsWith "variable " ||
    t.startsWith "open " || t.startsWith "mutual " || t.startsWith "set_option " ||
    t.startsWith "private " || t.startsWith "protected " || t.startsWith "where " ||
    t.startsWith "# " || t.startsWith "#" || t.startsWith "/--" || t.startsWith "/-"

def firstToken (s : String) : String :=
  let rec go : List Char → List Char
    | [] => []
    | c :: rest =>
      if c == ' ' || c == '(' || c == ':' || c == '{' then [] else c :: go rest
  String.ofList (go s.toList)

structure ThmSrc where
  name : String
  sig : String
  body : String

def dropChars (s : String) (n : Nat) : String :=
  String.ofList (s.toList.drop n)

def theoremNameOf (line : String) : Option String :=
  let t := collapseWs line
  let rest? :=
    if t.startsWith "private theorem " then some (dropChars t ("private theorem ".length))
    else if t.startsWith "protected theorem " then some (dropChars t ("protected theorem ".length))
    else if t.startsWith "theorem " then some (dropChars t ("theorem ".length))
    else if t.startsWith "lemma " then some (dropChars t ("lemma ".length))
    else none
  rest?.bind fun rest =>
    let n := firstToken rest
    if n == "" then none else some n

def assignParts (line : String) : Option (String × String) :=
  match line.splitOn ":=" with
  | before :: after :: rest => some (before, String.intercalate ":=" (after :: rest))
  | _ => none

inductive ThmPhase where
  | seek
  | inside (name : String) (sig : String) (body : String) (seenEq : Bool)

def openThm (line : String) : ThmPhase :=
  match theoremNameOf line with
  | none => .seek
  | some name =>
    match assignParts line with
    | some (before, after) => .inside name before after true
    | none => .inside name line "" false

/-- One pass over the lines. The tail is the recursive argument, so this is structural. -/
def theoremsGo : List String → ThmPhase → List ThmSrc → List ThmSrc
  | [], .seek, acc => acc.reverse
  | [], .inside name sig body _, acc => ({ name, sig, body } :: acc).reverse
  | line :: rest, .seek, acc =>
    theoremsGo rest (openThm line) acc
  | line :: rest, .inside name sig body seenEq, acc =>
    if columnZeroDecl line && !(line.startsWith " ") then
      theoremsGo rest (openThm line) ({ name, sig, body } :: acc)
    else if !seenEq then
      let sig := sig ++ "\n" ++ line
      match assignParts line with
      | some (_, after) => theoremsGo rest (.inside name sig after true) acc
      | none => theoremsGo rest (.inside name sig body false) acc
    else
      theoremsGo rest (.inside name sig (body ++ "\n" ++ line) true) acc

def theoremsIn (text : String) : List ThmSrc :=
  theoremsGo (text.splitOn "\n") .seek []

def defNameOf (line : String) : Option String :=
  let t := collapseWs line
  let rest? :=
    if t.startsWith "noncomputable def " then some (dropChars t ("noncomputable def ".length))
    else if t.startsWith "def " then some (dropChars t ("def ".length))
    else none
  rest?.bind fun rest =>
    let n := firstToken rest
    if n == "" || n.contains '.' then none else some n

inductive DefPhase where
  | seek
  | inside (name : String) (sig : String) (body : String) (seenEq : Bool)

def flagFact (name sig body : String) : Option (String × FlagDef) :=
  let b := collapseWs (stripComments body)
  let s := collapseWs (stripComments sig)
  let isBool := (s.splitOn ": Bool").length > 1
  if b == "false" && isBool then some (name, FlagDef.boolFalse)
  else if isBool && isBareIdent b then some (name, FlagDef.boolAlias b)
  else match lhsOfEqTrue b with
    | some lhs => some (name, FlagDef.eqTrue lhs)
    | none =>
      match hypOfImpliesFalse b with
      | some h => if isBareIdent h then some (name, FlagDef.impliesFalse h) else none
      | none => none

def consFact (name sig body : String) (acc : List (String × FlagDef)) : List (String × FlagDef) :=
  match flagFact name sig body with
  | some f => f :: acc
  | none => acc

def openDef (line : String) : DefPhase :=
  match defNameOf line with
  | none => .seek
  | some name =>
    match assignParts line with
    | some (before, after) => .inside name before after true
    | none => .inside name line "" false

/-- One pass over the lines. The tail is the recursive argument, so this is structural. -/
def flagDefsGo : List String → DefPhase → List (String × FlagDef) → List (String × FlagDef)
  | [], .seek, acc => acc
  | [], .inside name sig body _, acc => consFact name sig body acc
  | line :: rest, .seek, acc =>
    flagDefsGo rest (openDef line) acc
  | line :: rest, .inside name sig body seenEq, acc =>
    if columnZeroDecl line then
      flagDefsGo rest (openDef line) (consFact name sig body acc)
    else if !seenEq then
      let sig := sig ++ "\n" ++ line
      match assignParts line with
      | some (_, after) => flagDefsGo rest (.inside name sig after true) acc
      | none => flagDefsGo rest (.inside name sig body false) acc
    else
      flagDefsGo rest (.inside name sig (body ++ "\n" ++ line) true) acc

def parseFlagDefs (text : String) : List (String × FlagDef) :=
  flagDefsGo (text.splitOn "\n") .seek []

/-- Both shapes drop only when the hypothesis is a boolean defined as false set equal to true. -/
def isFlagOnlyThm (mods : List (List (String × FlagDef))) (sig body : String) : Bool :=
  if isOnlyNoConfusionBody body || isOnlyNomatchBody body then
    match binderType sig with
    | some ty => resolvesFalseBoolEqTrueMod mods ty 12
    | none => false
  else
    false

def fileBase (path : String) : String :=
  match path.splitOn "/" with
  | [] => path
  | parts => parts.reverse.headD path

def findText (texts : List (String × String)) (file : String) : Option String :=
  let base := fileBase file
  texts.findSome? fun (rel, text) =>
    if rel == file || fileBase rel == base then some text else none

def loadLeanDir (dir : System.FilePath) : IO (List (String × String)) := do
  let entries ← dir.readDir
  let mut out : List (String × String) := []
  for ent in entries do
    let p := ent.path
    if p.extension == some "lean" then
      let text ← IO.FS.readFile p
      let base := p.fileName.getD ""
      out := ("lean/" ++ base, text) :: out
  return out

/-- Lake builds with the working directory at `lean/`. A repo-root cwd still works. -/
def loadInconsistencySources : IO (List (String × String)) := do
  let cwd ← IO.currentDir
  let nested := cwd / "lean"
  if ← nested.pathExists then
    loadLeanDir nested
  else
    loadLeanDir cwd

def moduleKeyOf (rel : String) : String :=
  withoutSuffix (fileBase rel) ".lean"

def dropFront (s : String) (n : Nat) : String :=
  String.ofList (s.toList.drop n)

def importNameOfLine (line : String) : Option String :=
  let t := collapseWs line
  let rest? :=
    if t.startsWith "public import " then some (dropFront t ("public import ".length))
    else if t.startsWith "private import " then some (dropFront t ("private import ".length))
    else if t.startsWith "import " then some (dropFront t ("import ".length))
    else none
  rest?.bind fun rest =>
    let n := firstToken rest
    let n :=
      let cs := n.toList
      let cs := match cs with
        | '«' :: tail => tail
        | xs => xs
      let cs := cs.reverse
      let cs := match cs with
        | '»' :: tail => tail
        | xs => xs
      String.ofList cs.reverse
    if n == "" then none else some n

def importNames (text : String) : List String :=
  (text.splitOn "\n").filterMap importNameOfLine

structure ModFlag where
  key : String
  facts : List (String × FlagDef)
  imports : List String

def indexFlags (texts : List (String × String)) : List ModFlag :=
  texts.map fun (rel, text) =>
    { key := moduleKeyOf rel
      facts := parseFlagDefs text
      imports := importNames text }

def findModFlag (idx : List ModFlag) (key : String) : Option ModFlag :=
  idx.find? fun m => m.key == key

/-- Theorem file first, then its imports. The first definition of a name wins.
    `steps` shrinks on every call. `fuel` still stops after 40 new modules. -/
def orderedFactMods (idx : List ModFlag) (queue : List String) (seen : List String)
    (acc : List (List (String × FlagDef))) (fuel : Nat) : List Unit → List (List (String × FlagDef))
  | [] => acc
  | _ :: steps =>
    if fuel = 0 then acc
    else
      match queue with
      | [] => acc
      | k :: qs =>
        if seen.contains k then
          orderedFactMods idx qs seen acc fuel steps
        else
          match findModFlag idx k with
          | none => orderedFactMods idx qs (k :: seen) acc fuel steps
          | some m =>
            orderedFactMods idx (qs ++ m.imports) (k :: seen) (acc ++ [m.facts]) (fuel - 1) steps

def factModsForKey (idx : List ModFlag) (key : String) : List (List (String × FlagDef)) :=
  let bound := (idx.length + 1) * (idx.length + 1) + 8
  orderedFactMods idx [key] [] [] 40 (fuelList bound)

/-- Source body is only `Bool.noConfusion` or only nomatch, on a false bool flag. -/
def claimIsFlagOnly (idx : List ModFlag) (texts : List (String × String)) (file claim : String) : Bool :=
  match findText texts file with
  | none => false
  | some text =>
    let mods := factModsForKey idx (moduleKeyOf file)
    match (theoremsIn text).find? (fun t => t.name == claim) with
    | none => false
    | some thm => isFlagOnlyThm mods thm.sig thm.body

def collectBuilt (env : Environment) : List (String × String) :=
  let step (acc : List (String × String)) (p : Name × ConstantInfo) : List (String × String) :=
    let (n, ci) := p
    if isAuxiliaryName n then
      acc
    else if !infoIsTheorem ci then
      acc
    else if !isInconsistencyExpr ci.type then
      acc
    else
      match env.getModuleIdxFor? n with
      | none => acc
      | some idx =>
        let m := env.allImportedModuleNames[idx]!
        if !isProjectModule m then
          acc
        else
          insertPair (moduleToFile m, lastNameStr n) acc
  (env.constants.map₁.toList ++ env.constants.map₂.toList).foldl step []

elab "install_inconsistency_catalog" : command => do
  let env ← getEnv
  let texts ← liftIO loadInconsistencySources
  if texts.isEmpty then
    throwError "inconsistency catalog: no Lean sources loaded"
  let idx := indexFlags texts
  let rows := (collectBuilt env).filter fun p => !claimIsFlagOnly idx texts p.1 p.2
  if rows.length != 225 then
    let listing := String.intercalate "\n" (rows.map fun (f, c) => s!"{f} {c}")
    throwError s!"built inconsistency scan found {rows.length}, want 225, sources {texts.length}\n{listing}"
  let body := String.intercalate ",\n" (rows.map fun (f, c) => emitClaim f c)
  let cmd := "def scannedClaims : List ProvenClaim := [\n" ++ body ++ "\n]\n"
  match runParserCategory env `command cmd "<inconsistency-catalog>" with
  | .ok stx => elabCommand stx
  | .error e => throwError e

install_inconsistency_catalog

/-- The catalog is the scan of inconsistency theorems this package elaborates. -/
def catalog : List ProvenClaim := scannedClaims

/-- Same list. The old hand lock of length 7 is not the bar. -/
def provenClaims : List ProvenClaim := catalog

theorem catalog_count : catalog.length = 225 := by
  native_decide

def hasClaim (file claim : String) : Bool :=
  catalog.any fun c => c.file == file && c.claim == claim

theorem session_bus_spec_and_proof_in_catalog :
    hasClaim "lean/SessionBusProofs.lean" "mash_spec_and_proof_is_false" = true := by
  native_decide

theorem session_bus_program_claimed_in_catalog :
    hasClaim "lean/SessionBusProofs.lean"
      "mash_conforming_session_bus_program_claimed_is_false" = true := by
  native_decide

def claimInCatalog (claim : String) : Bool :=
  catalog.any fun c => c.claim == claim

theorem hides_split_not_in_catalog :
    claimInCatalog "mash_hides_split" = false := by
  native_decide

theorem vga_bool_flag_not_in_catalog :
    claimInCatalog "mash_vga256_as_doge_palette_is_false" = false := by
  native_decide

theorem sssss_delta_loop_byte_identity_in_catalog :
    hasClaim "lean/SssssProofs.lean" "mash_delta_loop_byte_identity_holds_is_false" = true := by
  native_decide

theorem sssss_neural_accepts_rule_without_lean_proof_in_catalog :
    hasClaim "lean/SssssProofs.lean"
      "mash_neural_accepts_rule_without_lean_proof_is_false" = true := by
  native_decide

theorem sssss_security_alone_must_in_catalog :
    hasClaim "lean/SssssProofs.lean" "mash_security_alone_must_is_false" = true := by
  native_decide

theorem sssss_performance_alone_must_in_catalog :
    hasClaim "lean/SssssProofs.lean" "mash_performance_alone_must_is_false" = true := by
  native_decide

theorem sssss_exactly_one_reference_compiler_in_catalog :
    hasClaim "lean/SssssProofs.lean"
      "mash_exactly_one_reference_compiler_is_false" = true := by
  native_decide

theorem sssss_spec_0004_replaces_0002_in_catalog :
    hasClaim "lean/SssssProofs.lean"
      "mash_spec_0004_replaces_spec_0002_is_false" = true := by
  native_decide

theorem sssss_spec_0006_replaces_0004_in_catalog :
    hasClaim "lean/SssssProofs.lean"
      "mash_spec_0006_replaces_spec_0004_is_false" = true := by
  native_decide

theorem systems_lean_reference_target_clause42_in_catalog :
    hasClaim "lean/SystemsLeanProofs.lean"
      "mash_reference_target_satisfies_clause42_item6_is_false" = true := by
  native_decide

theorem rsi_supercompiler_improvement_finished_in_catalog :
    hasClaim "lean/RsiProofs.lean"
      "mash_supercompiler_improvement_finished_is_false" = true := by
  native_decide

structure CatalogAudit where
  missing : List ProvenClaim
  spurious : List ProvenClaim
  deriving Repr

def sameClaim (a b : ProvenClaim) : Bool :=
  a.file == b.file && a.claim == b.claim

/-- `built` is the source scan. `listed` is the catalog. -/
def auditCatalog (built listed : List ProvenClaim) : CatalogAudit where
  missing := built.filter fun c => !listed.any (sameClaim c)
  spurious := listed.filter fun c => !built.any (sameClaim c)

def sampleClaim : ProvenClaim :=
  { file := "lean/Sample.lean"
    claim := "sample_is_false"
    kind := .intentionalNonconformance }

theorem missing_built_claim_fails_audit :
    (auditCatalog [sampleClaim] []).missing.length = 1 := rfl

theorem spurious_catalog_name_fails_audit :
    (auditCatalog [] [sampleClaim]).spurious.length = 1 := rfl

def existsAny : Bool :=
  !provenClaims.isEmpty

def headerRow : String :=
  "| Exists | File | Claim | Kind |"

def separatorRow : String :=
  "| --- | --- | --- | --- |"

def existsCell : String :=
  if existsAny then "yes" else "no"

def renderRow (c : ProvenClaim) : String :=
  s!"| {existsCell} | `{c.file}` | `{c.claim}` | {c.kind.label} |"

def renderTable (claims : List ProvenClaim) : String :=
  let rows :=
    if claims.isEmpty then
      [s!"| no | (none) | (none) | no proven logical inconsistency |"]
    else
      claims.map renderRow
  String.intercalate "\n" (headerRow :: separatorRow :: rows)

def generatedTable : String :=
  renderTable provenClaims

def extractSection (readme : String) : Option String :=
  let parts := readme.splitOn beginMarker
  match parts with
  | _ :: rest :: _ =>
    let inner := rest.splitOn endMarker
    match inner with
    | body :: _ :: _ => some body
    | _ => none
  | _ => none

def stripOuterNewlines (s : String) : String :=
  let cs := s.toList
  let cs := match cs with
    | '\n' :: rest => rest
    | xs => xs
  let cs := cs.reverse
  let cs := match cs with
    | '\n' :: rest => rest
    | xs => xs
  String.ofList cs.reverse

def tableMatches (readme : String) (want : String) : Bool :=
  match extractSection readme with
  | none => false
  | some body => stripOuterNewlines body == want

/-- Missing markers or a stale table fail. -/
def readmeTableCurrent (readme : String) : Bool :=
  tableMatches readme generatedTable

/-- Product check used by tests: same as readmeTableCurrent. -/
def tableSectionOk (readme : String) : Bool :=
  readmeTableCurrent readme

def wrapTable (table : String) : String :=
  beginMarker ++ "\n" ++ table ++ "\n" ++ endMarker

def spliceTable (readme : String) (table : String) : Option String :=
  match extractSection readme with
  | none => none
  | some _ =>
    let before := (readme.splitOn beginMarker).headD ""
    let afterParts := readme.splitOn endMarker
    let after :=
      match afterParts with
      | _ :: tail :: _ => tail
      | _ :: rest => String.intercalate endMarker rest
      | [] => ""
    some (before ++ wrapTable table ++ after)

def insertTableAtEnd (readme : String) (table : String) : String :=
  let body :=
    if readme.endsWith "\n" then readme else readme ++ "\n"
  body ++ "\n" ++ wrapTable table ++ "\n"

def refreshReadme (readme : String) : String :=
  match spliceTable readme generatedTable with
  | some s => s
  | none => insertTableAtEnd readme generatedTable

def firstDiffLine : List String → List String → Nat → Option (Nat × String × String)
  | [], [], _ => none
  | x :: xr, y :: yr, i =>
    if x != y then some (i, x, y) else firstDiffLine xr yr (i + 1)
  | x :: _, [], i => some (i, x, "<end>")
  | [], y :: _, i => some (i, "<end>", y)

def takeWhile (s : String) (p : Char → Bool) : String :=
  String.ofList (s.toList.takeWhile p)

def isIdentChar (c : Char) : Bool :=
  c.isAlphanum || c == '_' || c == '\'' || c == '.'

def theoremRest (line : String) : Option String :=
  let prefs := [
    "private theorem ",
    "protected theorem ",
    "noncomputable theorem ",
    "theorem ",
    "private lemma ",
    "lemma "
  ]
  prefs.findSome? fun p =>
    if line.startsWith p then some (dropChars line p.length) else none

def dropSpace (cs : List Char) : List Char :=
  cs.dropWhile fun c => c == ' ' || c == '\t' || c == '\n' || c == '\r'

def trimEnds (s : String) : String :=
  String.ofList (dropSpace (dropSpace s.toList.reverse).reverse)

def startsWord (word : String) (cs : List Char) : Bool :=
  let w := word.toList
  cs.take w.length == w &&
    match cs.drop w.length with
    | [] => true
    | c :: _ => !c.isAlphanum && c != '_'

def hasMarkerWord (src marker word : String) : Bool :=
  let rec go : List Char → Bool
    | [] => false
    | c :: rest =>
      if String.ofList [c] == marker then
        if startsWord word (dropSpace rest) then true else go rest
      else
        go rest
  go src.toList

def cutAtAssign (s : String) : String :=
  match s.splitOn ":=" with
  | head :: _ => head
  | [] => s

def lastIdent (s : String) : String :=
  let flat := String.ofList (s.toList.map fun c =>
    if c == '\n' || c == '\t' || c == '\r' then ' ' else c)
  let toks := flat.splitOn " "
  let rec go : List String → String
    | [] => ""
    | t :: rest =>
      let cur := takeWhile t isIdentChar
      let later := go rest
      if later != "" then later else cur
  go toks

def textIsInconsistency (sig : String) : Bool :=
  hasMarkerWord sig "→" "False" || hasMarkerWord sig ":" "False" ||
    strEnds (lastIdent sig) "IsFalse" || strEnds (lastIdent sig) "IsInconsistent"

partial def gatherSig (first : String) (rest : List String) (left : Nat) : String × List String :=
  if first.contains '=' && (cutAtAssign first).length < first.length then
    (first, rest)
  else
    match rest with
    | [] => (first, [])
    | line :: more =>
      if left == 0 then
        (first, rest)
      else
        let acc := first ++ "\n" ++ line
        if (line.splitOn ":=").length > 1 then
          (acc, more)
        else
          gatherSig acc more (left - 1)

partial def parseInconClaimsGo (lines acc : List String) : List String :=
  match lines with
  | [] => acc.reverse
  | line :: rest =>
    match theoremRest line with
    | none => parseInconClaimsGo rest acc
    | some after =>
      let name := takeWhile after isIdentChar
      let (sig, rest2) := gatherSig line rest 40
      if textIsInconsistency (cutAtAssign sig) then
        parseInconClaimsGo rest2 (name :: acc)
      else
        parseInconClaimsGo rest2 acc

def parseInconClaims (text : String) : List String :=
  parseInconClaimsGo (text.splitOn "\n") []

def importToken (line : String) : Option String :=
  let t := trimEnds line
  let rest? : Option String :=
    if t.startsWith "public import " then some (dropChars t ("public import ".length))
    else if t.startsWith "private import " then some (dropChars t ("private import ".length))
    else if t.startsWith "import " then some (dropChars t ("import ".length))
    else none
  rest?.bind fun rest =>
    let tok := takeWhile rest fun c => c != ' ' && c != '\t' && c != '\r'
    if tok == "" then none else some tok

def parseImports (text : String) : List String :=
  (text.splitOn "\n").filterMap importToken

def stripGuillemets (s : String) : String :=
  let cs := s.toList
  let cs := match cs with
    | '«' :: rest => rest
    | xs => xs
  let cs := cs.reverse
  let cs := match cs with
    | '»' :: rest => rest
    | xs => xs
  String.ofList cs.reverse

def betweenQuotes (s : String) : String :=
  let rec go : List Char → List Char → Bool → List Char
    | [], acc, _ => acc.reverse
    | '"' :: rest, acc, false => go rest acc true
    | '"' :: _, acc, true => acc.reverse
    | c :: rest, acc, true => go rest (c :: acc) true
    | _ :: rest, acc, false => go rest acc false
  String.ofList (go s.toList [] false)

def bracketInner (s : String) : String :=
  let rec go : List Char → List Char → Bool → List Char
    | [], acc, _ => acc.reverse
    | '[' :: rest, acc, false => go rest acc true
    | ']' :: _, acc, true => acc.reverse
    | c :: rest, acc, true => go rest (c :: acc) true
    | _ :: rest, acc, false => go rest acc false
  String.ofList (go s.toList [] false)

def parseBracketMods (s : String) : List String :=
  let parts := (bracketInner s).splitOn ","
  parts.filterMap fun p =>
    let t := betweenQuotes p
    let t := if t == "" then trimEnds p else t
    let t := trimEnds t
    if t == "" || t == "[" || t == "]" then none else some t

structure LakeSt where
  mods : List String
  kind : String
  name : String
  root : String
  roots : List String
  hasRoots : Bool

def flushLake (st : LakeSt) : LakeSt :=
  let add :=
    if st.hasRoots then st.roots
    else if st.root != "" then [st.root]
    else if st.kind == "lib" && st.name != "" then [st.name]
    else if st.kind == "exe" && st.name != "" then [st.name]
    else []
  { mods := add ++ st.mods
    kind := ""
    name := ""
    root := ""
    roots := []
    hasRoots := false }

def lakeModules (text : String) : List String :=
  let start : LakeSt :=
    { mods := [], kind := "", name := "", root := "", roots := [], hasRoots := false }
  let step (st : LakeSt) (line : String) : LakeSt :=
    let t := trimEnds line
    if t == "[[lean_lib]]" then
      let st := flushLake st
      { st with kind := "lib" }
    else if t == "[[lean_exe]]" then
      let st := flushLake st
      { st with kind := "exe" }
    else if t.startsWith "roots " || t.startsWith "roots=" then
      { st with hasRoots := true, roots := parseBracketMods t }
    else if t.startsWith "root " || t.startsWith "root=" then
      { st with root := betweenQuotes t }
    else if t.startsWith "name " || t.startsWith "name=" then
      { st with name := betweenQuotes t }
    else
      st
  (flushLake (text.splitOn "\n" |>.foldl step start)).mods

def resolveMod (repo : System.FilePath) (mod : String) : IO (Option (String × System.FilePath)) := do
  let base := stripGuillemets mod
  let relLean := "lean/" ++ base ++ ".lean"
  let pathLean := repo / "lean" / (base ++ ".lean")
  if ← pathLean.pathExists then
    return some (relLean, pathLean)
  let relRoot := base ++ ".lean"
  let pathRoot := repo / (base ++ ".lean")
  if ← pathRoot.pathExists then
    return some (relRoot, pathRoot)
  return none

def insertClaim (c : ProvenClaim) : List ProvenClaim → List ProvenClaim
  | [] => [c]
  | h :: t =>
    if c.file < h.file || (c.file == h.file && c.claim < h.claim) then
      c :: h :: t
    else if c.file == h.file && c.claim == h.claim then
      h :: t
    else
      h :: insertClaim c t

partial def walkMods (repo : System.FilePath) (idx : List ModFlag) (texts : List (String × String))
    (queue : List String) (seen : List String)
    (acc : List ProvenClaim) : IO (List ProvenClaim) := do
  match queue with
  | [] => return acc
  | m :: qs =>
    if seen.contains m then
      walkMods repo idx texts qs seen acc
    else
      match ← resolveMod repo m with
      | none => walkMods repo idx texts qs (m :: seen) acc
      | some (rel, path) =>
        let text ← IO.FS.readFile path
        let mods := factModsForKey idx (moduleKeyOf rel)
        let thms := theoremsIn text
        let claims := (parseInconClaims text).filter fun name =>
          match thms.find? (fun t => t.name == name) with
          | none => true
          | some thm => !isFlagOnlyThm mods thm.sig thm.body
        let rows := claims.map fun c =>
          { file := rel, claim := c, kind := ClaimKind.intentionalNonconformance }
        let acc := rows.foldl (fun a c => insertClaim c a) acc
        walkMods repo idx texts (qs ++ parseImports text) (m :: seen) acc

/-- Source scan of modules reachable from Lake roots. Not `include_str`. -/
def scanBuiltInconsistencies (repo : System.FilePath) : IO (List ProvenClaim) := do
  let lake := repo / "lean" / "lakefile.toml"
  if !(← lake.pathExists) then
    throw (IO.userError s!"inconsistency_report: missing {lake}")
  let text ← IO.FS.readFile lake
  let texts ← loadLeanDir (repo / "lean")
  let idx := indexFlags texts
  walkMods repo idx texts (lakeModules text) [] []

def formatAudit (a : CatalogAudit) : String :=
  let rowsFor (tag : String) (cs : List ProvenClaim) : List String :=
    cs.map fun c => s!"{tag}: {c.file} {c.claim}"
  String.intercalate "\n"
    (rowsFor "missing from catalog" a.missing ++ rowsFor "catalog name is not a built inconsistency" a.spurious)

def catalogMatchesSources (built : List ProvenClaim) : Bool :=
  let a := auditCatalog built catalog
  a.missing.isEmpty && a.spurious.isEmpty

end InconsistencyReport
