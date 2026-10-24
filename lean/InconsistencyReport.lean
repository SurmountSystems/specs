/-
  Proven logical inconsistency table for README.md.

  The catalog is every theorem, in a module this package elaborates,
  whose type is False, a chain of assumptions ending in False, or an
  alias whose name ends in IsFalse or IsInconsistent. A Bool flag equal
  to false is not an inconsistency. Reasoning lives in RESIDUAL.md.

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
  let rows := collectBuilt env
  if rows.length != 168 then
    let listing := String.intercalate "\n" (rows.map fun (f, c) => s!"{f} {c}")
    throwError s!"built inconsistency scan found {rows.length}, want 168\n{listing}"
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

theorem catalog_count : catalog.length = 168 := by
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

def dropChars (s : String) (n : Nat) : String :=
  String.ofList (s.toList.drop n)

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

partial def walkMods (repo : System.FilePath) (queue : List String) (seen : List String)
    (acc : List ProvenClaim) : IO (List ProvenClaim) := do
  match queue with
  | [] => return acc
  | m :: qs =>
    if seen.contains m then
      walkMods repo qs seen acc
    else
      match ← resolveMod repo m with
      | none => walkMods repo qs (m :: seen) acc
      | some (rel, path) =>
        let text ← IO.FS.readFile path
        let claims := parseInconClaims text
        let rows := claims.map fun c =>
          { file := rel, claim := c, kind := ClaimKind.intentionalNonconformance }
        let acc := rows.foldl (fun a c => insertClaim c a) acc
        walkMods repo (qs ++ parseImports text) (m :: seen) acc

/-- Source scan of modules reachable from Lake roots. Not `include_str`. -/
def scanBuiltInconsistencies (repo : System.FilePath) : IO (List ProvenClaim) := do
  let lake := repo / "lean" / "lakefile.toml"
  if !(← lake.pathExists) then
    throw (IO.userError s!"inconsistency_report: missing {lake}")
  let text ← IO.FS.readFile lake
  walkMods repo (lakeModules text) [] []

def formatAudit (a : CatalogAudit) : String :=
  let rowsFor (tag : String) (cs : List ProvenClaim) : List String :=
    cs.map fun c => s!"{tag}: {c.file} {c.claim}"
  String.intercalate "\n"
    (rowsFor "missing from catalog" a.missing ++ rowsFor "catalog name is not a built inconsistency" a.spurious)

def catalogMatchesSources (built : List ProvenClaim) : Bool :=
  let a := auditCatalog built catalog
  a.missing.isEmpty && a.spurious.isEmpty

end InconsistencyReport
