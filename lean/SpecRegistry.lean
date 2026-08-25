/-
  Numbered spec registry: number, file name, product name.

  This module is not a specification. Numbered markdown at the repository
  root is the contract people read. spec_check uses the scan functions
  here so wrong numbers, file name mismatches, and wrong capitalization
  of beastdb fail the form checker (and therefore nix flake check).

  Planned entries (fargo) may be named in prose. Their files MUST NOT
  exist until a numbered specification is published. Carbonado is not assigned
  a number; discussion of 0006 is not an assignment.
-/

namespace SpecRegistry

/-- One registry row. `published` means the file MUST exist at repo root. -/
structure RegistryEntry where
  number : Nat
  fileName : String
  productName : String
  published : Bool
  deriving Repr, DecidableEq, BEq

def specSpecNumber : Nat := 0
def dogeSpecNumber : Nat := 1
def systemsLeanSpecNumber : Nat := 2
def beastdbSpecNumber : Nat := 3
def ssssSpecNumber : Nat := 4
def fargoPlannedSpecNumber : Nat := 5

def publishedEntries : List RegistryEntry :=
  [ { number := 0
      fileName := "0000_spec.md"
      productName := "spec spec"
      published := true }
    , { number := 1
        fileName := "0001_DOGE.md"
        productName := "DOGE"
        published := true }
    , { number := 2
        fileName := "0002_Systems_Lean.md"
        productName := "Systems Lean"
        published := true }
    , { number := 3
        fileName := "0003_beastdb.md"
        productName := "beastdb"
        published := true }
    , { number := 4
        fileName := "0004_SSSSS.md"
        productName := "SSSSS"
        published := true } ]

def plannedEntries : List RegistryEntry :=
  [ { number := 5
      fileName := "0005_fargo.md"
      productName := "fargo"
      published := false } ]

def allEntries : List RegistryEntry :=
  publishedEntries ++ plannedEntries

/-- Carbonado Network Protocol is not in the registry. -/
def carbonadoAssigned : Bool := false

def carbonadoAssignedNumber : Option Nat := none

theorem spec_spec_is_0000 : specSpecNumber = 0 := rfl

theorem doge_is_0001 : dogeSpecNumber = 1 := rfl

theorem systems_lean_is_0002 : systemsLeanSpecNumber = 2 := rfl

theorem beastdb_is_0003 : beastdbSpecNumber = 3 := rfl

theorem ssss_is_0004 : ssssSpecNumber = 4 := rfl

theorem fargo_planned_is_0005 : fargoPlannedSpecNumber = 5 := rfl

theorem ssss_is_not_spec_0002 : ssssSpecNumber ≠ 2 := by decide

theorem ssss_is_not_spec_0003 : ssssSpecNumber ≠ 3 := by decide

theorem systems_lean_is_not_0003 : systemsLeanSpecNumber ≠ 3 := by decide

theorem beastdb_is_not_0002 : beastdbSpecNumber ≠ 2 := by decide

theorem beastdb_is_not_0004 : beastdbSpecNumber ≠ 4 := by decide

theorem beastdb_is_not_0001 : beastdbSpecNumber ≠ 1 := by decide

theorem carbonado_not_assigned : carbonadoAssigned = false := rfl

theorem carbonado_number_none : carbonadoAssignedNumber = none := rfl

theorem published_count_five : publishedEntries.length = 5 := rfl

theorem planned_count_one : plannedEntries.length = 1 := rfl

theorem all_entry_numbers :
    allEntries.map (fun e => e.number) = [0, 1, 2, 3, 4, 5] := rfl

theorem published_filenames :
    publishedEntries.map (fun e => e.fileName) =
      ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md",
        "0003_beastdb.md", "0004_SSSSS.md"] :=
  rfl

theorem planned_filenames :
    plannedEntries.map (fun e => e.fileName) =
      ["0005_fargo.md"] :=
  rfl

theorem beastdb_product_name :
    (publishedEntries.filter (fun e => e.number == 3)).map
        (fun e => e.productName) =
      ["beastdb"] :=
  rfl

theorem ssss_product_name :
    (publishedEntries.filter (fun e => e.number == 4)).map
        (fun e => e.productName) =
      ["SSSSS"] :=
  rfl

def hasDupNumbers : Bool :=
  let ns := allEntries.map (fun e => e.number)
  ns.any (fun n => (ns.count n) > 1)

def hasDupFilenames : Bool :=
  let fs := allEntries.map (fun e => e.fileName)
  fs.any (fun f => (fs.count f) > 1)

theorem unique_numbers : hasDupNumbers = false := rfl

theorem unique_filenames : hasDupFilenames = false := rfl

theorem beastdb_entry_filename :
    (allEntries.filter (fun e => e.number == 3)).map (fun e => e.fileName) =
      ["0003_beastdb.md"] :=
  rfl

theorem systems_lean_entry_filename :
    (allEntries.filter (fun e => e.number == 2)).map (fun e => e.fileName) =
      ["0002_Systems_Lean.md"] :=
  rfl

theorem ssss_entry_published :
    (allEntries.filter (fun e => e.number == 4)).map (fun e => e.published) =
      [true] :=
  rfl

theorem ssss_entry_filename :
    (allEntries.filter (fun e => e.number == 4)).map (fun e => e.fileName) =
      ["0004_SSSSS.md"] :=
  rfl

theorem fargo_entry_unpublished :
    (allEntries.filter (fun e => e.number == 5)).map (fun e => e.published) =
      [false] :=
  rfl

/-!
  Scan helpers (pure). IO lives in `checkRepo`.
-/

structure Finding where
  file : String
  line : Option Nat
  message : String
  deriving Repr, Inhabited

def Finding.format (d : Finding) : String :=
  match d.line with
  | some n => s!"{d.file}:{n}: {d.message}"
  | none => s!"{d.file}: {d.message}"

def pad4 (n : Nat) : String :=
  let s := toString n
  match s.length with
  | 1 => "000" ++ s
  | 2 => "00" ++ s
  | 3 => "0" ++ s
  | _ => s

def isIdentChar (c : Char) : Bool :=
  c.isAlphanum || c == '_'

def parseNat4 (cs : List Char) : Option Nat :=
  match cs with
  | c0 :: c1 :: c2 :: c3 :: _ =>
    if c0.isDigit && c1.isDigit && c2.isDigit && c3.isDigit then
      some (
        (c0.toNat - '0'.toNat) * 1000 +
          (c1.toNat - '0'.toNat) * 100 +
          (c2.toNat - '0'.toNat) * 10 +
          (c3.toNat - '0'.toNat))
    else
      none
  | _ => none

def isNumberedSpecName (basename : String) : Bool :=
  if !(basename.endsWith ".md") then
    false
  else
    let cs := basename.toList
    if cs.length < 9 then
      false
    else
      let stemCs := cs.take (cs.length - 3)
      match stemCs with
      | c0 :: c1 :: c2 :: c3 :: '_' :: rest =>
        c0.isDigit && c1.isDigit && c2.isDigit && c3.isDigit &&
          !rest.isEmpty && rest.all isIdentChar
      | _ => false

def fileNumberOfName (basename : String) : Option Nat :=
  if isNumberedSpecName basename then
    parseNat4 basename.toList
  else
    none

def entryByNumber (n : Nat) : Option RegistryEntry :=
  allEntries.find? (fun e => e.number == n)

def publishedByNumber (n : Nat) : Option RegistryEntry :=
  publishedEntries.find? (fun e => e.number == n)

/-- True when `prev` cannot start a `NNNN_` token (digit would extend the run). -/
def canStartNumberToken (prev : Option Char) : Bool :=
  match prev with
  | none => true
  | some c => !c.isDigit

structure SpecToken where
  start : Nat
  number : Nat
  fileName : String
  deriving Repr

/--
  Find `NNNN_descriptive` or `NNNN_descriptive.md` tokens.
  A preceding digit is not a start (so `10000_x` is not `0000_x`).
-/
def findSpecTokens (s : String) : List SpecToken :=
  Id.run do
    let cs := s.toList.toArray
    let mut out : List SpecToken := []
    let mut i : Nat := 0
    while i < cs.size do
      let prev : Option Char := if i = 0 then none else some cs[i - 1]!
      if canStartNumberToken prev then
        if i + 5 ≤ cs.size then
          let c0 := cs[i]!
          let c1 := cs[i + 1]!
          let c2 := cs[i + 2]!
          let c3 := cs[i + 3]!
          let c4 := cs[i + 4]!
          if c0.isDigit && c1.isDigit && c2.isDigit && c3.isDigit && c4 == '_' then
            let mut j := i + 5
            while j < cs.size && isIdentChar cs[j]! do
              j := j + 1
            if j > i + 5 then
              let mut endIdx := j
              if j + 2 < cs.size && cs[j]! == '.' && cs[j + 1]! == 'm' &&
                  cs[j + 2]! == 'd' then
                -- require that `.md` is not followed by an ident char
                let after := j + 3
                if after ≥ cs.size || !isIdentChar cs[after]! then
                  endIdx := j + 3
              let slice := Id.run do
                let mut acc : Array Char := #[]
                for k in [i:endIdx] do
                  acc := acc.push cs[k]!
                return String.ofList acc.toList
              let fname :=
                if slice.endsWith ".md" then slice else slice ++ ".md"
              match parseNat4 slice.toList with
              | some n =>
                out := out ++ [{ start := i, number := n, fileName := fname }]
              | none =>
                pure ()
              i := endIdx
              continue
      i := i + 1
    return out

def asciiUpperChar (c : Char) : Char :=
  if 'a' ≤ c && c ≤ 'z' then Char.ofNat (c.toNat - 32) else c

def ciEqChar (a b : Char) : Bool :=
  asciiUpperChar a == asciiUpperChar b

/-- Case insensitive match of `needle` at `i` in `cs`. -/
def ciMatchAt (cs : Array Char) (i : Nat) (needle : List Char) : Bool :=
  Id.run do
    let mut j := 0
    for c in needle do
      let k := i + j
      if k ≥ cs.size then return false
      if !ciEqChar cs[k]! c then return false
      j := j + 1
    return true

def sliceString (cs : Array Char) (start len : Nat) : String :=
  Id.run do
    let mut acc : Array Char := #[]
    let last := min (start + len) cs.size
    for k in [start:last] do
      acc := acc.push cs[k]!
    return String.ofList acc.toList

/-- Case insensitive starts of `needle` in `s`. -/
def findCiStarts (s : String) (needle : String) : List Nat :=
  if needle.isEmpty then
    []
  else
    Id.run do
      let cs := s.toList.toArray
      let n := needle.toList
      let mut out : List Nat := []
      let mut i : Nat := 0
      while i < cs.size do
        if ciMatchAt cs i n then
          out := out ++ [i]
          i := i + needle.length
        else
          i := i + 1
      return out

def containsSub (hay : String) (needle : String) : Bool :=
  if needle.isEmpty then
    true
  else
    Id.run do
      let h := hay.toList.toArray
      let n := needle.toList
      let mut i : Nat := 0
      while i < h.size do
        if ciMatchAt h i n then
          -- this is case insensitive; identity prefix uses exact match below
          let mut j := 0
          let mut ok := true
          for c in n do
            if h[i + j]! != c then
              ok := false
            j := j + 1
          if ok then
            return true
        i := i + 1
      return false

def containsExact (hay : String) (needle : String) : Bool :=
  if needle.isEmpty then
    true
  else
    Id.run do
      let h := hay.toList.toArray
      let n := needle.toList
      let mut i : Nat := 0
      while i < h.size do
        let mut ok := true
        let mut j := 0
        for c in n do
          let k := i + j
          if k ≥ h.size || h[k]! != c then
            ok := false
          j := j + 1
        if ok && j == n.length then
          return true
        i := i + 1
      return false

def splitLines (s : String) : List String :=
  s.splitOn "\n"

/-- Preceded immediately by `lib` (any case) so `beastdb` is inside `libbeastdb`. -/
def precededByLib (cs : Array Char) (i : Nat) : Bool :=
  i ≥ 3 && ciMatchAt cs (i - 3) ['l', 'i', 'b']

/--
  Wrong capitalization of the product name: any case insensitive `beastdb`
  that is not exactly `beastdb`, and any case insensitive `libbeastdb` that
  is not exactly `libbeastdb`. Spaced or hyphenated `beast db` / `beast-db`
  is always wrong.
-/
def scanBeastdbCaps (file : String) (lineNo : Nat) (line : String) : List Finding :=
  Id.run do
    let cs := line.toList.toArray
    let mut out : List Finding := []
    -- beast db (space)
    for _ in findCiStarts line "beast db" do
      out := out ++ [{
        file := file
        line := some lineNo
        message :=
          "product name beastdb must be the lowercase closed form; spaced beast db is forbidden"
      }]
    -- beast-db
    for _ in findCiStarts line "beast-db" do
      out := out ++ [{
        file := file
        line := some lineNo
        message :=
          "product name beastdb must be the lowercase closed form; hyphenated beast-db is forbidden"
      }]
    -- libbeastdb (check first so inner beastdb is classified)
    for i in findCiStarts line "libbeastdb" do
      let got := sliceString cs i "libbeastdb".length
      if got != "libbeastdb" then
        out := out ++ [{
          file := file
          line := some lineNo
          message :=
            s!"library name must be exactly libbeastdb (lowercase); found {got}"
        }]
    for i in findCiStarts line "beastdb" do
      if precededByLib cs i then
        pure ()
      else
        let got := sliceString cs i "beastdb".length
        if got != "beastdb" then
          out := out ++ [{
            file := file
            line := some lineNo
            message :=
              s!"product name must be exactly beastdb (lowercase); found {got}"
          }]
    return out

def identityPrefix : String := "This specification is number "

/-- Digits immediately after `This specification is number `, if present. -/
def identityNumber (line : String) : Option Nat :=
  if !containsExact line identityPrefix then
    none
  else
    Id.run do
      let cs := line.toList.toArray
      let p := identityPrefix.toList
      let mut i : Nat := 0
      while i < cs.size do
        let mut ok := true
        let mut j := 0
        for c in p do
          let k := i + j
          if k ≥ cs.size || cs[k]! != c then
            ok := false
          j := j + 1
        if ok then
          let start := i + p.length
          let mut n : Nat := 0
          let mut k := start
          let mut digits : Nat := 0
          while k < cs.size && cs[k]!.isDigit do
            n := n * 10 + (cs[k]!.toNat - '0'.toNat)
            digits := digits + 1
            k := k + 1
          if digits = 0 then
            return none
          else
            return some n
        i := i + 1
      return none

def tokenMismatchMessage (tok : SpecToken) (want : RegistryEntry) : String :=
  s!"numbered specification token {tok.fileName} does not match registry file name {want.fileName} for specification {pad4 tok.number}"

def tokenUnassignedMessage (tok : SpecToken) : String :=
  s!"numbered specification token {tok.fileName} uses specification number {pad4 tok.number}, which is not in the registry (not published and not a planned file name). Carbonado Network Protocol is not assigned a number."

def scanTokensOnLine (file : String) (lineNo : Nat) (line : String) : List Finding :=
  Id.run do
    let mut out : List Finding := []
    for tok in findSpecTokens line do
      match entryByNumber tok.number with
      | none =>
        out := out ++ [{
          file := file
          line := some lineNo
          message := tokenUnassignedMessage tok
        }]
      | some e =>
        if tok.fileName != e.fileName then
          out := out ++ [{
            file := file
            line := some lineNo
            message := tokenMismatchMessage tok e
          }]
    return out

/-- Scan one numbered specification file's text. -/
def scanContent (fileName : String) (content : String) : List Finding :=
  Id.run do
    let mut out : List Finding := []
    let mut ln : Nat := 0
    let fileNum := fileNumberOfName fileName
    for line in splitLines content do
      ln := ln + 1
      out := out ++ scanTokensOnLine fileName ln line
      out := out ++ scanBeastdbCaps fileName ln line
      match identityNumber line, fileNum with
      | some claimed, some n =>
        if claimed != n then
          out := out ++ [{
            file := fileName
            line := some ln
            message :=
              s!"identity sentence claims specification {pad4 claimed}, but this file is specification {pad4 n}"
          }]
      | _, _ =>
        pure ()
    return out

/--
  Presence findings from the set of numbered specification basenames at the root actually
  found. Every published file MUST be present. Every found file MUST be a
  published registry file name. Planned files are reported by `plannedPresent`.
-/
def findingsForBasenames (found : List String) : List Finding :=
  Id.run do
    let mut out : List Finding := []
    for e in publishedEntries do
      if !found.contains e.fileName then
        out := out ++ [{
          file := e.fileName
          line := none
          message :=
            s!"published specification {pad4 e.number} ({e.productName}) is missing; expected file {e.fileName}"
        }]
    for name in found do
      match fileNumberOfName name with
      | none =>
        out := out ++ [{
          file := name
          line := none
          message := s!"root file {name} is not a numbered specification name"
        }]
      | some n =>
        match publishedByNumber n with
        | none =>
          out := out ++ [{
            file := name
            line := none
            message :=
              s!"root file {name} is not a published registry file (planned specifications MUST NOT exist as files until published; Carbonado is not assigned)"
          }]
        | some e =>
          if name != e.fileName then
            out := out ++ [{
              file := name
              line := none
              message :=
                s!"root file {name} does not match registry file name {e.fileName} for specification {pad4 n}"
            }]
    return out

def findingsForPlannedPresent (present : List String) : List Finding :=
  present.map fun name =>
    { file := name
      line := none
      message :=
        s!"planned specification file {name} MUST NOT exist until that specification is published" }

/-- Collect numbered specification paths at the root. -/
def collectRootNumberedSpecs (repoRoot : System.FilePath) : IO (Array System.FilePath) := do
  let mut out : Array System.FilePath := #[]
  let entries ← repoRoot.readDir
  for e in entries do
    let name := e.fileName
    if !name.startsWith "." && isNumberedSpecName name then
      out := out.push (repoRoot / name)
  return out

def baseName (path : String) : String :=
  let norm := path.replace "\\" "/"
  let parts := norm.splitOn "/"
  match parts.reverse with
  | p :: _ => p
  | [] => path

/--
  IO scan: published files present under `repoRoot`, planned files absent,
  found names match the registry, each numbered markdown body is consistent.
-/
def checkRepo (repoRoot : System.FilePath) : IO (List Finding) := do
  let paths ← collectRootNumberedSpecs repoRoot
  let found := paths.toList.map fun p => baseName p.toString
  let mut out : List Finding := findingsForBasenames found
  let mut plannedHit : List String := []
  for e in plannedEntries do
    let p := repoRoot / e.fileName
    if (← p.pathExists) then
      plannedHit := plannedHit ++ [e.fileName]
  out := out ++ findingsForPlannedPresent plannedHit
  for p in paths do
    let name := baseName p.toString
    let content ← IO.FS.readFile p
    out := out ++ scanContent name content
  return out

end SpecRegistry
