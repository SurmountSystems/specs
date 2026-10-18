/-
  Proven logical inconsistency table for README.md.

  Catalog of proven False mash claims in this repository's Lean
  meaning models. These are intentional nonconformance theorems.
  They are not a stack numbering bug. Reasoning lives in RESIDUAL.md.

  Numbered markdown remains the contract humans read. This module
  is a checker. It is not a second markdown form suite.
-/

import AnunnakiProofs
import CateProofs
import CiProofs
import SystemsLeanProofs
import UnlicenseProofs

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

/--
  Catalog of proven False mash claims that the README table must match.
  Names match theorems in FormalVibeficationProofs, UnlicenseProofs, Surmount, and AnunnakiProofs.
-/
def provenClaims : List ProvenClaim :=
  [
    { file := "lean/FormalVibeficationProofs.lean"
      claim := "mash_spec_and_proof"
      kind := .intentionalNonconformance },
    { file := "lean/FormalVibeficationProofs.lean"
      claim := "mash_homes_is_inconsistent"
      kind := .intentionalNonconformance },
    { file := "lean/UnlicenseProofs.lean"
      claim := "mash_spec_and_proof"
      kind := .intentionalNonconformance },
    { file := "lean/UnlicenseProofs.lean"
      claim := "mash_mit_meets_pdoss"
      kind := .intentionalNonconformance },
    { file := "lean/UnlicenseProofs.lean"
      claim := "mash_apache_meets_pdoss"
      kind := .intentionalNonconformance },
    { file := "lean/Surmount.lean"
      claim := "mash_layers_inconsistent"
      kind := .intentionalNonconformance },
    { file := "lean/AnunnakiProofs.lean"
      claim := "mash_spec_and_proof_is_false"
      kind := .intentionalNonconformance }
  ]

theorem proven_claim_count : provenClaims.length = 7 :=
  rfl

/-- Last component of a declaration name. -/
def declBaseName : Lean.Name → String
  | .str _ s => s
  | .num p _ => declBaseName p
  | .anonymous => ""

/--
  Honesty mash theorems that stay outside the README catalog.
  Each entry is a resolved constant. Deleting or renaming that
  theorem fails elaboration. provenClaims stays the seven catalog
  rows. This list is not rendered into the README table.
-/
def honestyMashTheorems : List Lean.Name :=
  [
    ``SystemsLean.mash_compcert_verified_compilation_claimed_done_is_false,
    ``SystemsLean.mash_slake_bootstrap_typecheck_claimed_done_is_false,
    ``SystemsLean.mash_compcert_tso_satisfies_clause42_item6_is_false,
    ``AnunnakiProofs.mash_spelling_converter_claimed_is_false,
    ``Cate.mash_british_spelling_conforms_is_false,
    ``Ci.mash_byte_identity_claimed_true_is_false,
    ``AnunnakiProofs.mash_conforming_encoder_claimed_is_false,
    ``SystemsLean.mash_safe_c_is_own_published_spec_number_is_false,
    ``AnunnakiProofs.mash_dialect_needs_own_language_id_is_false,
    ``SystemsLean.mash_self_host_from_c_satisfies_bootstrap_is_false,
    ``UnlicenseProofs.mash_cc0_pinned_is_false,
    ``UnlicenseProofs.mash_cc0_claimed_meets_pdoss_is_false
  ]

/-- String names are the last component of honestyMashTheorems. -/
def honestyMashesOutsideCatalog : List String :=
  honestyMashTheorems.map declBaseName

theorem honesty_mashes_outside_catalog_count :
    honestyMashesOutsideCatalog.length = 12 :=
  rfl

theorem honesty_mashes_outside_catalog_names :
    honestyMashesOutsideCatalog = [
      "mash_compcert_verified_compilation_claimed_done_is_false",
      "mash_slake_bootstrap_typecheck_claimed_done_is_false",
      "mash_compcert_tso_satisfies_clause42_item6_is_false",
      "mash_spelling_converter_claimed_is_false",
      "mash_british_spelling_conforms_is_false",
      "mash_byte_identity_claimed_true_is_false",
      "mash_conforming_encoder_claimed_is_false",
      "mash_safe_c_is_own_published_spec_number_is_false",
      "mash_dialect_needs_own_language_id_is_false",
      "mash_self_host_from_c_satisfies_bootstrap_is_false",
      "mash_cc0_pinned_is_false",
      "mash_cc0_claimed_meets_pdoss_is_false"
    ] :=
  rfl

/-- True when `name` is a claim string in provenClaims. -/
def honestyMashNameInProvenClaims (name : String) : Bool :=
  provenClaims.any (fun c => c.claim == name)

/-- No honesty mash name is also a claim in provenClaims. -/
theorem honesty_mashes_outside_catalog_disjoint :
    honestyMashesOutsideCatalog.filter honestyMashNameInProvenClaims = [] :=
  rfl

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

end InconsistencyReport
