/-
  Numbered spec registry: number, file name, product name.

  This module is not a specification. Numbered markdown at the repository
  root is the contract people read. spec_check uses the scan functions
  here so wrong numbers, file name mismatches, and wrong capitalization
  of beastdb fail the form checker (and therefore nix flake check).

  Planned entries may be empty. Carbonado is not assigned a number.
  Number 0005 is Concise American Technical English (CATE). Number 0006
  is Recursive Self Improvement (RSI). Discussion of Carbonado as a
  possible 0006 was never an assignment. Number 0007 is Continuous
  Integration (CI). Number 0008 is Formal Vibefication. Number 0009 is
  Public Domain Open Source Software (PDOSS). Unlicense remains the
  license. The word catalog is owned by CATE (specification 0005).
  The file 0009_VOCABULARY.md MUST NOT exist. Number 0010 is Surmount
  Systems. Number 0011 is Surmount Systems Tech Tree. Number 0012 is
  Majestic Memex (`0012_Majestic_Memex.md`). Number 0013 is Lean
  Machine (`0013_Lean_Machine.md`). Number 0014 is Anunnaki
  Encoding (`0014_Anunnaki_Encoding.md`). Number 0015 is the
  session bus (`0015_Session_Bus.md`). It is not Anunnaki Encoding.
  fargo and SSSP have no assigned numbers. Existing
  `ref/` pins remain; new pins are added when present.

  Residual honesty: do not assert that a named product never started.
  Scan numbered specifications plus extraHonestyMarkdownFileNames
  (the scan lives in SpecCheck so this module does not import SpecCheck).
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
def cateSpecNumber : Nat := 5
def rsiSpecNumber : Nat := 6
def ciSpecNumber : Nat := 7
def formalVibeficationSpecNumber : Nat := 8
def formalVibeficationFileName : String := "0008_Formal_Vibefication.md"
def vocabularySpecNumber : Nat := 5
def vocabularyFileName : String := "0005_CATE.md"
def surmountSystemsSpecNumber : Nat := 10
def techTreeSpecNumber : Nat := 11
def techTreeFileName : String := "0011_Surmount_Systems_Tech_Tree.md"
def memexSpecNumber : Nat := 12
def memexFileName : String := "0012_Majestic_Memex.md"
def leanMachineSpecNumber : Nat := 13
def leanMachineFileName : String := "0013_Lean_Machine.md"
def anunnakiSpecNumber : Nat := 14
def anunnakiFileName : String := "0014_Anunnaki_Encoding.md"
def sessionBusSpecNumber : Nat := 15
def sessionBusFileName : String := "0015_Session_Bus.md"
def unlicenseSpecNumber : Nat := 9
def pdossSpecNumber : Nat := 9
def unlicenseFileName : String := "0009_PDOSS.md"
def pdossFileName : String := "0009_PDOSS.md"

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
        published := true }
    , { number := 5
        fileName := "0005_CATE.md"
        productName := "CATE"
        published := true }
    , { number := 6
        fileName := "0006_RSI.md"
        productName := "RSI"
        published := true }
    , { number := 7
        fileName := "0007_CI.md"
        productName := "CI"
        published := true }
    , { number := 8
        fileName := "0008_Formal_Vibefication.md"
        productName := "Formal Vibefication"
        published := true }
    , { number := 9
        fileName := "0009_PDOSS.md"
        productName := "PDOSS"
        published := true }
    , { number := 10
        fileName := "0010_Surmount_Systems.md"
        productName := "Surmount Systems"
        published := true }
    , { number := 11
        fileName := "0011_Surmount_Systems_Tech_Tree.md"
        productName := "Surmount Systems Tech Tree"
        published := true }
    , { number := 12
        fileName := "0012_Majestic_Memex.md"
        productName := "Majestic Memex"
        published := true }
    , { number := 13
        fileName := "0013_Lean_Machine.md"
        productName := "Lean Machine"
        published := true }
    , { number := 14
        fileName := "0014_Anunnaki_Encoding.md"
        productName := "Anunnaki Encoding"
        published := true }
    , { number := 15
        fileName := "0015_Session_Bus.md"
        productName := "Session Bus"
        published := true } ]

def plannedEntries : List RegistryEntry :=
  []

def allEntries : List RegistryEntry :=
  publishedEntries ++ plannedEntries

/-- Carbonado Network Protocol is not in the registry. -/
def carbonadoAssigned : Bool := false

def carbonadoAssignedNumber : Option Nat := none

/-- fargo has no assigned specification number. -/
def fargoAssigned : Bool := false

def fargoAssignedNumber : Option Nat := none

/-- Surmount Systems System Prompt is named, not specified. -/
def ssspAssigned : Bool := false

def ssspAssignedNumber : Option Nat := none

/-- Lean Machine is numbered specification 0013. -/
def leanMachineAssigned : Bool := true

def leanMachineAssignedNumber : Option Nat := some 13

/-- Anunnaki Encoding is numbered specification 0014. -/
def anunnakiAssigned : Bool := true

def anunnakiAssignedNumber : Option Nat := some 14

/-- Session Bus is numbered specification 0015. -/
def sessionBusAssigned : Bool := true

def sessionBusAssignedNumber : Option Nat := some 15

theorem spec_spec_is_0000 : specSpecNumber = 0 := rfl

theorem doge_is_0001 : dogeSpecNumber = 1 := rfl

theorem systems_lean_is_0002 : systemsLeanSpecNumber = 2 := rfl

theorem beastdb_is_0003 : beastdbSpecNumber = 3 := rfl

theorem ssss_is_0004 : ssssSpecNumber = 4 := rfl

theorem cate_is_0005 : cateSpecNumber = 5 := rfl

theorem rsi_is_0006 : rsiSpecNumber = 6 := rfl

/-- Fails if the model still numbers CATE as 0006. -/
theorem cate_is_not_0006 : cateSpecNumber ≠ 6 := by decide

theorem rsi_is_not_0005 : rsiSpecNumber ≠ 5 := by decide

theorem ci_is_0007 : ciSpecNumber = 7 := rfl

theorem ci_is_not_0005 : ciSpecNumber ≠ 5 := by decide

theorem ci_is_not_0006 : ciSpecNumber ≠ 6 := by decide

theorem formal_vibefication_is_0008 : formalVibeficationSpecNumber = 8 :=
  rfl

theorem formal_vibefication_file :
    formalVibeficationFileName = "0008_Formal_Vibefication.md" :=
  rfl

theorem formal_vibefication_is_not_0007 :
    formalVibeficationSpecNumber ≠ 7 := by
  decide

theorem formal_vibefication_is_not_0009 :
    formalVibeficationSpecNumber ≠ 9 := by
  decide

theorem formal_vibefication_is_not_0010 :
    formalVibeficationSpecNumber ≠ 10 := by
  decide

theorem vocabulary_is_0005 : vocabularySpecNumber = 5 := rfl

theorem vocabulary_file :
    vocabularyFileName = "0005_CATE.md" :=
  rfl

theorem vocabulary_equals_cate :
    vocabularySpecNumber = cateSpecNumber :=
  rfl

theorem vocabulary_is_not_0008 : vocabularySpecNumber ≠ 8 := by decide

theorem vocabulary_is_not_0010 : vocabularySpecNumber ≠ 10 := by decide

theorem vocabulary_is_not_0009 : vocabularySpecNumber ≠ 9 := by decide

theorem unlicense_is_0009 : unlicenseSpecNumber = 9 := rfl

theorem unlicense_file :
    unlicenseFileName = "0009_PDOSS.md" :=
  rfl

theorem pdoss_is_0009 : pdossSpecNumber = 9 := rfl

theorem pdoss_file : pdossFileName = "0009_PDOSS.md" := rfl

theorem pdoss_equals_unlicense_number :
    pdossSpecNumber = unlicenseSpecNumber :=
  rfl

theorem unlicense_is_not_0008 : unlicenseSpecNumber ≠ 8 := by decide

theorem unlicense_is_not_0010 : unlicenseSpecNumber ≠ 10 := by decide

theorem unlicense_is_not_0011 : unlicenseSpecNumber ≠ 11 := by decide

theorem surmount_systems_is_0010 : surmountSystemsSpecNumber = 10 := rfl

theorem tech_tree_is_0011 : techTreeSpecNumber = 11 := rfl

theorem tech_tree_file :
    techTreeFileName = "0011_Surmount_Systems_Tech_Tree.md" :=
  rfl

theorem tech_tree_is_not_0010 : techTreeSpecNumber ≠ 10 := by decide

theorem tech_tree_is_not_0012 : techTreeSpecNumber ≠ 12 := by decide

theorem memex_is_0012 : memexSpecNumber = 12 := rfl

theorem memex_file :
    memexFileName = "0012_Majestic_Memex.md" :=
  rfl

theorem memex_is_not_0011 : memexSpecNumber ≠ 11 := by decide

theorem memex_is_not_0010 : memexSpecNumber ≠ 10 := by decide

theorem lean_machine_is_0013 : leanMachineSpecNumber = 13 := rfl

theorem lean_machine_file :
    leanMachineFileName = "0013_Lean_Machine.md" :=
  rfl

theorem lean_machine_is_not_0012 : leanMachineSpecNumber ≠ 12 := by decide

theorem lean_machine_is_not_0009 : leanMachineSpecNumber ≠ 9 := by decide

theorem anunnaki_is_0014 : anunnakiSpecNumber = 14 := rfl

theorem anunnaki_file :
    anunnakiFileName = "0014_Anunnaki_Encoding.md" :=
  rfl

theorem anunnaki_is_not_0013 : anunnakiSpecNumber ≠ 13 := by decide

theorem anunnaki_is_not_0015 : anunnakiSpecNumber ≠ 15 := by decide

theorem surmount_systems_is_not_0007 : surmountSystemsSpecNumber ≠ 7 := by decide

theorem surmount_systems_is_not_0008 : surmountSystemsSpecNumber ≠ 8 := by decide

theorem surmount_systems_is_not_0009 : surmountSystemsSpecNumber ≠ 9 := by decide

theorem cate_is_not_0000 : cateSpecNumber ≠ 0 := by decide

theorem cate_is_not_rsi : cateSpecNumber ≠ rsiSpecNumber := by decide

theorem fargo_not_assigned : fargoAssigned = false := rfl

theorem fargo_number_none : fargoAssignedNumber = none := rfl

theorem fargo_is_not_0005 : cateSpecNumber = 5 ∧ fargoAssigned = false :=
  And.intro cate_is_0005 fargo_not_assigned

theorem fargo_is_not_0006 : rsiSpecNumber = 6 ∧ fargoAssigned = false :=
  And.intro rsi_is_0006 fargo_not_assigned

theorem sssp_not_assigned : ssspAssigned = false := rfl

theorem sssp_number_none : ssspAssignedNumber = none := rfl

theorem lean_machine_assigned : leanMachineAssigned = true := rfl

theorem lean_machine_number_some_13 : leanMachineAssignedNumber = some 13 :=
  rfl

theorem anunnaki_assigned : anunnakiAssigned = true := rfl

theorem anunnaki_number_some_14 : anunnakiAssignedNumber = some 14 :=
  rfl

theorem session_bus_is_0015 : sessionBusSpecNumber = 15 := rfl

theorem session_bus_file :
    sessionBusFileName = "0015_Session_Bus.md" :=
  rfl

theorem session_bus_is_not_0014 : sessionBusSpecNumber ≠ 14 := by decide

theorem session_bus_assigned : sessionBusAssigned = true := rfl

theorem session_bus_number_some_15 : sessionBusAssignedNumber = some 15 :=
  rfl

theorem ssss_is_not_spec_0002 : ssssSpecNumber ≠ 2 := by decide

theorem ssss_is_not_spec_0003 : ssssSpecNumber ≠ 3 := by decide

theorem systems_lean_is_not_0003 : systemsLeanSpecNumber ≠ 3 := by decide

theorem beastdb_is_not_0002 : beastdbSpecNumber ≠ 2 := by decide

theorem beastdb_is_not_0004 : beastdbSpecNumber ≠ 4 := by decide

theorem beastdb_is_not_0001 : beastdbSpecNumber ≠ 1 := by decide

theorem carbonado_not_assigned : carbonadoAssigned = false := rfl

theorem carbonado_number_none : carbonadoAssignedNumber = none := rfl

theorem published_count_sixteen : publishedEntries.length = 16 := rfl

theorem planned_count_zero : plannedEntries.length = 0 := rfl

theorem all_entry_numbers :
    allEntries.map (fun e => e.number) =
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] :=
  rfl

theorem number_8_published :
    (allEntries.any (fun e => e.number == 8)) = true :=
  rfl

theorem number_9_published :
    (allEntries.any (fun e => e.number == 9)) = true :=
  rfl

theorem number_11_published :
    (allEntries.any (fun e => e.number == 11)) = true :=
  rfl

theorem number_11_is_published_file :
    (publishedEntries.any (fun e => e.number == 11)) = true :=
  rfl

theorem number_12_published :
    (allEntries.any (fun e => e.number == 12)) = true :=
  rfl

theorem number_12_is_published_file :
    (publishedEntries.any (fun e => e.number == 12)) = true :=
  rfl

theorem number_12_is_not_planned :
    (plannedEntries.any (fun e => e.number == 12)) = false :=
  rfl

theorem number_13_published :
    (allEntries.any (fun e => e.number == 13)) = true :=
  rfl

theorem number_13_is_published_file :
    (publishedEntries.any (fun e => e.number == 13)) = true :=
  rfl

theorem number_13_is_not_planned :
    (plannedEntries.any (fun e => e.number == 13)) = false :=
  rfl

theorem number_14_published :
    (allEntries.any (fun e => e.number == 14)) = true :=
  rfl

theorem number_14_is_published_file :
    (publishedEntries.any (fun e => e.number == 14)) = true :=
  rfl

theorem number_14_is_not_planned :
    (plannedEntries.any (fun e => e.number == 14)) = false :=
  rfl

theorem number_15_published :
    (allEntries.any (fun e => e.number == 15)) = true :=
  rfl

theorem number_15_is_published_file :
    (publishedEntries.any (fun e => e.number == 15)) = true :=
  rfl

theorem number_15_is_not_planned :
    (plannedEntries.any (fun e => e.number == 15)) = false :=
  rfl

/-- Encode helper: tests that every published file is present use this list. -/
def publishedBasenames : List String :=
  publishedEntries.map (fun e => e.fileName)

theorem published_filenames :
    publishedEntries.map (fun e => e.fileName) =
      ["0000_spec.md", "0001_DOGE.md", "0002_Systems_Lean.md",
        "0003_beastdb.md", "0004_SSSSS.md", "0005_CATE.md",
        "0006_RSI.md", "0007_CI.md", "0008_Formal_Vibefication.md",
        "0009_PDOSS.md", "0010_Surmount_Systems.md",
        "0011_Surmount_Systems_Tech_Tree.md",
        "0012_Majestic_Memex.md",
        "0013_Lean_Machine.md",
        "0014_Anunnaki_Encoding.md",
        "0015_Session_Bus.md"] :=
  rfl

theorem published_basenames_are_entry_filenames :
    publishedBasenames = publishedEntries.map (fun e => e.fileName) :=
  rfl

theorem planned_filenames :
    plannedEntries.map (fun e => e.fileName) =
      [] :=
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

theorem cate_entry_published :
    (allEntries.filter (fun e => e.number == 5)).map (fun e => e.published) =
      [true] :=
  rfl

theorem cate_entry_filename :
    (allEntries.filter (fun e => e.number == 5)).map (fun e => e.fileName) =
      ["0005_CATE.md"] :=
  rfl

theorem rsi_entry_published :
    (allEntries.filter (fun e => e.number == 6)).map (fun e => e.published) =
      [true] :=
  rfl

theorem rsi_entry_filename :
    (allEntries.filter (fun e => e.number == 6)).map (fun e => e.fileName) =
      ["0006_RSI.md"] :=
  rfl

theorem ci_entry_published :
    (allEntries.filter (fun e => e.number == 7)).map (fun e => e.published) =
      [true] :=
  rfl

theorem ci_entry_filename :
    (allEntries.filter (fun e => e.number == 7)).map (fun e => e.fileName) =
      ["0007_CI.md"] :=
  rfl

theorem formal_vibefication_entry_published :
    (allEntries.filter (fun e => e.number == 8)).map (fun e => e.published) =
      [true] :=
  rfl

theorem formal_vibefication_entry_filename :
    (allEntries.filter (fun e => e.number == 8)).map (fun e => e.fileName) =
      ["0008_Formal_Vibefication.md"] :=
  rfl

theorem number_nine_product_is_pdoss :
    (allEntries.filter (fun e => e.number == 9)).map
        (fun e => e.productName) =
      ["PDOSS"] :=
  rfl

theorem vocabulary_catalog_file_is_cate :
    (allEntries.filter (fun e => e.number == 5)).map (fun e => e.fileName) =
      ["0005_CATE.md"] :=
  cate_entry_filename

theorem surmount_systems_entry_published :
    (allEntries.filter (fun e => e.number == 10)).map (fun e => e.published) =
      [true] :=
  rfl

theorem surmount_systems_entry_filename :
    (allEntries.filter (fun e => e.number == 10)).map (fun e => e.fileName) =
      ["0010_Surmount_Systems.md"] :=
  rfl

theorem tech_tree_entry_published :
    (allEntries.filter (fun e => e.number == 11)).map (fun e => e.published) =
      [true] :=
  rfl

theorem tech_tree_entry_filename :
    (allEntries.filter (fun e => e.number == 11)).map (fun e => e.fileName) =
      ["0011_Surmount_Systems_Tech_Tree.md"] :=
  rfl

theorem memex_entry_published :
    (allEntries.filter (fun e => e.number == 12)).map (fun e => e.published) =
      [true] :=
  rfl

theorem memex_entry_filename :
    (allEntries.filter (fun e => e.number == 12)).map (fun e => e.fileName) =
      ["0012_Majestic_Memex.md"] :=
  rfl

theorem lean_machine_entry_published :
    (allEntries.filter (fun e => e.number == 13)).map (fun e => e.published) =
      [true] :=
  rfl

theorem lean_machine_entry_filename :
    (allEntries.filter (fun e => e.number == 13)).map (fun e => e.fileName) =
      ["0013_Lean_Machine.md"] :=
  rfl

theorem anunnaki_entry_published :
    (allEntries.filter (fun e => e.number == 14)).map (fun e => e.published) =
      [true] :=
  rfl

theorem anunnaki_entry_filename :
    (allEntries.filter (fun e => e.number == 14)).map (fun e => e.fileName) =
      ["0014_Anunnaki_Encoding.md"] :=
  rfl

theorem anunnaki_product_name :
    (publishedEntries.filter (fun e => e.number == 14)).map
        (fun e => e.productName) =
      ["Anunnaki Encoding"] :=
  rfl

theorem session_bus_entry_published :
    (allEntries.filter (fun e => e.number == 15)).map (fun e => e.published) =
      [true] :=
  rfl

theorem session_bus_entry_filename :
    (allEntries.filter (fun e => e.number == 15)).map (fun e => e.fileName) =
      ["0015_Session_Bus.md"] :=
  rfl

theorem session_bus_product_name :
    (publishedEntries.filter (fun e => e.number == 15)).map
        (fun e => e.productName) =
      ["Session Bus"] :=
  rfl

theorem unlicense_entry_published :
    (allEntries.filter (fun e => e.number == 9)).map (fun e => e.published) =
      [true] :=
  rfl

theorem unlicense_entry_filename :
    (allEntries.filter (fun e => e.number == 9)).map (fun e => e.fileName) =
      ["0009_PDOSS.md"] :=
  rfl

/-!
  Residual honesty: beastdb, SSSSS, Slake, and CI are ongoing and not
  ready for use. Do not encode them as never started or as ready.
-/

inductive ProductProgress where
  | claimsNeverStarted
  | ongoingNotReadyForUse
  | claimsReadyForUse
  deriving DecidableEq, Repr, BEq

def ProductProgress.honestWhenWorkExists : ProductProgress → Bool
  | .ongoingNotReadyForUse => true
  | .claimsNeverStarted => false
  | .claimsReadyForUse => false

/--
  Surmount authored markdown besides root numbered specifications.
  Residual honesty for never-real product claims scans this list
  plus every root numbered specification. Do not shorten this list
  relative to WordStats extra markdown.
-/
def extraHonestyMarkdownFileNames : List String :=
  ["AGENTS.md", "README.md", "RESIDUAL.md", "VOCABULARY.md"]

theorem extra_honesty_markdown_files_are_four :
    extraHonestyMarkdownFileNames.length = 4 :=
  rfl

def beastdbProgress : ProductProgress := .ongoingNotReadyForUse

def sssssProgress : ProductProgress := .ongoingNotReadyForUse

def slakeProgress : ProductProgress := .ongoingNotReadyForUse

def ciProductProgress : ProductProgress := .ongoingNotReadyForUse

theorem beastdb_ongoing_not_ready :
    beastdbProgress.honestWhenWorkExists = true :=
  rfl

theorem sssss_ongoing_not_ready :
    sssssProgress.honestWhenWorkExists = true :=
  rfl

theorem slake_ongoing_not_ready :
    slakeProgress.honestWhenWorkExists = true :=
  rfl

theorem ci_product_ongoing_not_ready :
    ciProductProgress.honestWhenWorkExists = true :=
  rfl

theorem never_started_is_not_honest_when_work_exists :
    ProductProgress.claimsNeverStarted.honestWhenWorkExists = false :=
  rfl

theorem ready_for_use_is_not_honest_yet :
    ProductProgress.claimsReadyForUse.honestWhenWorkExists = false :=
  rfl

/-- Byte identity of Slake emit is required and not claimed true. -/
def byteIdentityClaimedTrue : Bool := false

theorem byte_identity_not_claimed_true :
    byteIdentityClaimedTrue = false :=
  rfl

/-- Systems Lean product tree that already holds the four language pins. -/
def systemsLeanProductTreePath : String := "/home/hunter/Projects/ai/iso"

theorem systems_lean_product_tree_is_iso :
    systemsLeanProductTreePath = "/home/hunter/Projects/ai/iso" :=
  rfl

/-- Existing pins remain. New pins are added when the cited artifact is present. -/
def keepExistingRefPins : Bool := true

def addNewRefPinsWhenPresent : Bool := true

def requiredThisRepoRefPins : List String :=
  ["rfc2119", "semver", "ecma48", "itu_t416"]

/-- Lean 4, Idris 2, CompCert, and Rust MUST NOT be copied into this `ref/`. -/
def forbiddenThisRepoRefPins : List String :=
  ["lean4", "Idris2", "CompCert", "rust"]

def pdfPermissionNotePresent : Bool := false

theorem keep_existing_ref_pins : keepExistingRefPins = true := rfl

theorem add_new_ref_pins_when_present : addNewRefPinsWhenPresent = true := rfl

theorem required_ref_pin_count : requiredThisRepoRefPins.length = 4 := rfl

theorem forbidden_ref_pin_count : forbiddenThisRepoRefPins.length = 4 := rfl

theorem pdf_permission_note_not_yet_written :
    pdfPermissionNotePresent = false :=
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

/-- Exact match of `needle` at index `i`. -/
def matchExactAt (cs : Array Char) (i : Nat) (needle : String) : Bool :=
  Id.run do
    let n := needle.toList
    let mut j := 0
    for c in n do
      let k := i + j
      if k ≥ cs.size || cs[k]! != c then
        return false
      j := j + 1
    return true

/-- Next character is not part of a path or identifier token. -/
def pathTokenEnded (cs : Array Char) (i : Nat) : Bool :=
  i ≥ cs.size || !(cs[i]!.isAlphanum)

/--
  Real Lean filenames on disk whose module prefix is `BeastDb`.
  The product name stays lowercase `beastdb`. These suffixes are not that name.
-/
def beastDbLeanFileSuffixes : List String :=
  [".lean", "Spec.lean", "Proofs.lean", "Tests.lean"]

/--
  `BeastDb` as the Lean module prefix of a real `.lean` path
  (`BeastDb.lean`, `BeastDbSpec.lean`, `BeastDbProofs.lean`,
  `BeastDbTests.lean`), with or without a `lean/` directory prefix.
-/
def isBeastDbLeanPath (cs : Array Char) (i : Nat) : Bool :=
  if sliceString cs i 7 != "BeastDb" then
    false
  else
    beastDbLeanFileSuffixes.any fun suf =>
      matchExactAt cs (i + 7) suf && pathTokenEnded cs (i + 7 + suf.length)

/--
  Wrong capitalization of the product name: any case insensitive `beastdb`
  that is not exactly `beastdb`, and any case insensitive `libbeastdb` that
  is not exactly `libbeastdb`. Spaced or hyphenated `beast db` / `beast-db`
  is always wrong. A citation of a real Lean path such as
  `lean/BeastDbSpec.lean` is not the product name.
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
      else if isBeastDbLeanPath cs i then
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

def dropLeadingSpace (cs : List Char) : List Char :=
  cs.dropWhile (fun c => c == ' ' || c == '\t')

def dropTrailingSpace (cs : List Char) : List Char :=
  (cs.reverse.dropWhile (fun c => c == ' ' || c == '\t')).reverse

def isAtxHeading (line : String) : Bool :=
  match dropLeadingSpace line.toList with
  | '#' :: _ => true
  | _ => false

/-- Title after `#` marks, with leading section numbers such as `6.` or `20.4` dropped. -/
def residualHeadingBody (line : String) : Option String :=
  if !isAtxHeading line then
    none
  else
    let afterHash :=
      dropLeadingSpace (
        (dropLeadingSpace line.toList).dropWhile (fun c => c == '#'))
    let title := dropTrailingSpace afterHash
    let body :=
      title.dropWhile (fun c => c.isDigit || c == '.' || c == ' ' || c == '\t')
    some (String.ofList body)

def startsWithChars (s : String) (pre : String) : Bool :=
  let sc := s.toList
  let pc := pre.toList
  if sc.length < pc.length then
    false
  else
    (sc.take pc.length) == pc

/-- True for markdown headings titled Residual (0005_CATE.md Clause 4.5). -/
def isResidualHeading (line : String) : Bool :=
  match residualHeadingBody line with
  | none => false
  | some body =>
    body == "Residual" || startsWithChars body "Residual "

def plannedTokenOnLine (line : String) : Option SpecToken :=
  Id.run do
    for tok in findSpecTokens line do
      match entryByNumber tok.number with
      | some e =>
        if !e.published then
          return some tok
      | none =>
        pure ()
    return none

/--
  CATE residual heading (0005_CATE.md Clause 4.5): numbered specifications
  other than 0000 that contain a planned or unpublished `NNNN_*.md` token
  MUST have a heading titled Residual. 0000 is the form spec and is exempt.
-/
def scanPlannedResidual (fileName : String) (content : String) : List Finding :=
  match fileNumberOfName fileName with
  | none => []
  | some 0 => []
  | some _ =>
    Id.run do
      let mut hasResidual := false
      let mut firstPlanned : Option (Nat × SpecToken) := none
      let mut ln : Nat := 0
      for line in splitLines content do
        ln := ln + 1
        if isResidualHeading line then
          hasResidual := true
        match plannedTokenOnLine line, firstPlanned with
        | some tok, none =>
          firstPlanned := some (ln, tok)
        | _, _ =>
          pure ()
      match firstPlanned with
      | none => []
      | some (pln, tok) =>
        if hasResidual then
          []
        else
          [{
            file := fileName
            line := some pln
            message :=
              s!"planned specification token {tok.fileName} requires a Residual heading or clause in this file (CATE)"
          }]

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
    out := out ++ scanPlannedResidual fileName content
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
  if keepExistingRefPins then
    for name in requiredThisRepoRefPins do
      let pin := repoRoot / "ref" / name
      if !(← pin.pathExists) then
        out := out ++ [{
          file := s!"ref/{name}"
          line := none
          message :=
            s!"existing pin ref/{name} MUST remain; directory is missing"
        }]
  for name in forbiddenThisRepoRefPins do
    let pin := repoRoot / "ref" / name
    if (← pin.pathExists) then
      out := out ++ [{
        file := s!"ref/{name}"
        line := none
        message :=
          s!"this specifications repository MUST NOT pin {name} under ref/; those Form 1 pins live in the Systems Lean product tree"
      }]
  return out

end SpecRegistry
