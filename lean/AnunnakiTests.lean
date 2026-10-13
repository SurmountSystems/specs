/-
  Runtime checks for Anunnaki Encoding spec encodings and proofs.
  Theorems in AnunnakiProofs.lean already fail to typecheck if the
  split is mashed. This executable re-checks the decidable facts so a
  silent Bool regression prints FAIL lines.

  TDD named contracts (observe intended FAIL as comments, then the
  same cases PASS when AnunnakiSpec encodings are correct):

  1. specNumber is 14. FAIL if that Nat is not 14.
  2. File name is 0014_Anunnaki_Encoding.md. FAIL if it is 0015 or another stem.
  3. ENKI is the index and Anunnaki is the bitstream. FAIL if those names are one object.
  4. This specification does not replace CATE 0005, SSSSS 0004, or Majestic Memex 0012.
  5. A conforming encoder is not claimed. FAIL if conformingEncoderClaimed is true.
  6. Ones padding is valid; a claimed pad that contains a zero is rejected.
  7. Science cycle tests alone are not sufficient.
  8. Mash of spec encodings plus proofs in one module is False.
  9. Clause 6 leftover residual Bools stay false.
  10. Clause 6.5 leftover clashes are Cons False. This is not a second mash of spec encodings plus proofs.
  11. A dialect does not need its own LanguageID. Two spelling tables for one language share the frequency ranked word number. The user's preference selects which table decode uses. A spelling converter program is not claimed. Claiming a spelling converter program is Cons False. The byte layout of a spelling table is not specified. FAIL if a dialect is encoded as needing its own LanguageID. FAIL if a spelling converter program is claimed.

  Lake roots for AnunnakiSpec, AnunnakiProofs, and anunnaki_tests
  exist in lean/lakefile.toml. This file does not import SpecRegistry
  or the sibling line encoding.
-/

import AnunnakiSpec
import AnunnakiProofs

open AnunnakiSpec
open AnunnakiProofs

structure Case where
  name : String
  ok : Bool
  detail : String := ""
  deriving Repr

def expectTrue (name : String) (b : Bool) : Case :=
  { name := name, ok := b, detail := if b then "" else "expected true" }

def expectFalse (name : String) (b : Bool) : Case :=
  { name := name, ok := !b, detail := if !b then "" else "expected false" }

def expectEqNat (name : String) (got want : Nat) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectEqString (name : String) (got want : String) : Case :=
  if got == want then
    { name := name, ok := true }
  else
    { name := name, ok := false, detail := s!"expected {want}, got {got}" }

def expectConsFalse (name : String) (accepted : Bool) (clash : Prop)
    (isFalse : Prop) (_same : isFalse = (clash -> False))
    (_proof : isFalse) : Case :=
  expectFalse name accepted

def runCases : List Case :=
  [
    -- Intended FAIL if specNumber is not 14.
    expectEqNat "Anunnaki Encoding is specification 0014" specNumber 14,
    -- Intended FAIL if the file name is 0015_Anunnaki_Encoding.md or another stem.
    expectEqString "Anunnaki Encoding file is 0014_Anunnaki_Encoding.md"
      specFileName "0014_Anunnaki_Encoding.md",
    expectEqString "product name is Anunnaki Encoding"
      productName "Anunnaki Encoding",
    expectTrue "spec encoding module is marked as spec encoding"
      markedAsSpecEncoding,
    expectFalse "spec encoding module is not marked as proof" markedAsProof,
    expectTrue "AnunnakiSpec live module contains spec encodings"
      liveContainsSpecEncodings,
    expectFalse "AnunnakiSpec live module does not mash proofs into encodings"
      liveContainsProofsOfThoseEncodings,
    expectTrue "ENKI is the index" enkiIsIndex,
    expectTrue "Anunnaki is the bitstream" anunnakiIsBitstream,
    expectFalse "ENKI and Anunnaki are not one object"
      enkiAndAnunnakiAreOneObject,
    expectFalse "ENKI has no numbered specification"
      enkiHasNumberedSpecification,
    expectFalse "this specification does not replace CATE" replacesCate,
    expectEqNat "CATE is specification 0005" cateSpecNumber 5,
    expectFalse "this specification does not replace SSSSS" replacesSssss,
    expectEqNat "SSSSS is specification 0004" sssssSpecNumber 4,
    expectFalse "this specification does not replace Majestic Memex"
      replacesMemex,
    expectEqNat "Majestic Memex is specification 0012" memexSpecNumber 12,
    expectTrue "Memex keeps MAJESTIC plus 0x01" memexKeepsMajesticPlus01,
    expectFalse "a conforming encoder is not claimed"
      conformingEncoderClaimed,
    expectTrue "Huffman coding MAY be measured" huffmanMayBeMeasured,
    expectFalse "Huffman coding is not the lemma spine" huffmanIsLemmaSpine,
    expectTrue "Huffman coding MUST NOT be the lemma spine"
      huffmanMustNotBeLemmaSpine,
    expectEqNat "arm 0 payload is one byte" (payloadBytesFromLeadingOnes 0) 1,
    expectEqNat "arm 10 payload is two bytes" (payloadBytesFromLeadingOnes 1) 2,
    expectEqNat "arm 110 payload is three bytes"
      (payloadBytesFromLeadingOnes 2) 3,
    expectEqNat "arm 1110 payload is four bytes"
      (payloadBytesFromLeadingOnes 3) 4,
    expectEqNat "payload byte cap is 8" payloadByteCap 8,
    expectTrue "ones padding fixture is valid"
      (claimedPadIsValid padOnesFixture),
    expectTrue "claimed pad that contains a zero is rejected"
      (mustRejectClaimedPad padContainsZeroFixture),
    expectFalse "claimed pad that contains a zero is not valid"
      (claimedPadIsValid padContainsZeroFixture),
    expectEqNat "perfectly efficient pad length is zero"
      padLengthWhenPerfectlyEfficient 0,
    expectTrue "bit 7 is consumed first" bit7First,
    expectEqNat "page 0 has 256 slots" page0Slots 256,
    expectEqNat "page 0 index is one byte" page0IndexBytes 1,
    expectEqNat "page 1 has 65536 slots" page1Slots 65536,
    expectEqNat "page 1 index is two bytes" page1IndexBytes 2,
    expectTrue "page 1 index is little endian" page1LittleEndian,
    expectTrue "payload is bytes" payloadIsBytes,
    expectTrue "repeat character residual is a plane"
      repeatCharacterIsResidualPlane,
    expectTrue "symbol residual is separate" symbolResidualIsSeparate,
    expectFalse "repeat character residual is not the symbol residual"
      repeatCharacterEqualsSymbolResidual,
    expectTrue "normalize first then encode" normalizeFirstThenEncode,
    expectTrue "decode MUST rebuild the original surface"
      decodeMustRebuildOriginalSurface,
    expectTrue "one language keeps one LanguageID"
      oneLanguageKeepsOneLanguageId,
    expectFalse "a dialect does not need its own LanguageID"
      dialectNeedsOwnLanguageId,
    expectTrue "spelling tables are isomorphic at the frequency ranked word number"
      spellingTablesIsomorphicAtRank,
    expectEqNat "frequency ranked word number stays the same"
      americanSpellingTable.rankNumber regionalSpellingTable.rankNumber,
    expectEqNat "spelling tables share one LanguageID"
      americanSpellingTable.languageId regionalSpellingTable.languageId,
    expectTrue "the user's preference selects the decode table"
      userPreferenceSelectsDecodeTable,
    expectEqString "user preference presents the regional surface"
      (tableFor .userPreferred).surface "regional form",
    expectEqString "repository preference presents the American surface"
      (tableFor .repositoryAmerican).surface "color",
    expectFalse "a spelling converter program is not claimed"
      spellingConverterProgramClaimed,
    expectFalse "spelling table byte layout is not specified"
      spellingTableByteLayoutSpecified,
    expectFalse "migration corpus is not pinned" migrationCorpusPinned,
    expectTrue "English fixture is in the v2 slice" englishFixturePinned,
    expectTrue "Lean 4 fixture is in the v2 slice" lean4FixturePinned,
    expectFalse "C fixture is unpinned" cFixturePinned,
    expectFalse "Rust 1 fixture is unpinned" rust1FixturePinned,
    expectFalse "Nix fixture is unpinned" nixFixturePinned,
    expectFalse "C++ fixture is unpinned" cppFixturePinned,
    expectTrue "human markdown is the contract humans read"
      humanMarkdownIsTheHumanContract,
    expectFalse "human markdown does not substitute for Lean spec encodings"
      humanMarkdownSubstitutesForLeanSpecEncoding,
    expectFalse "Lean proof is not the spec" leanProofIsTheSpec,
    expectTrue "separate spec encoding fixture conforms"
      (conformingThisRepo specEncodingFixture),
    expectTrue "separate proof fixture conforms"
      (conformingThisRepo proofFixture),
    expectFalse "mashed spec and proof fixture does not conform"
      (conformingThisRepo mashedFixture),
    expectTrue "mashed fixture hides the split" (hidesSplit mashedFixture),
    expectFalse "tests without a model do not conform" testsOnlyConforms,
    expectFalse "model and proofs without corollary experiments do not conform"
      modelAndProofsWithoutExperimentsConforms,
    expectTrue "complete science cycle conforms" completeScienceConformsHere,
    expectFalse "tests alone are not sufficient" testsAloneAreSufficient,
    expectTrue "required conformance holds iff every listed item holds"
      requiredConformanceHolds,
    expectFalse "products are not claimed ready for use"
      productsClaimedReadyForUse,
    expectFalse "products are not claimed never started"
      productsClaimedNeverStarted,
    expectFalse "RDPS is not assigned a number here" rdpsAssignedNumber,
    expectFalse "FilterScript is not assigned a number here"
      filterScriptAssignedNumber,
    expectFalse "Carbonado is not assigned a number here"
      carbonadoAssignedNumber,
    expectFalse "number 0015 is not assigned here" number0015Assigned,
    expectFalse "number 0015 is not this specification"
      number0015IsThisSpecification,
    expectFalse "this specification does not create an ENKI numbered file"
      createsEnkiNumberedFile,
    expectFalse "fargo is not assigned a number here" fargoAssignedNumber,
    expectFalse "a stack program instruction set is not specified"
      stackProgramInstructionSetSpecified,
    expectFalse "nested language is not specified here"
      nestedLanguageSpecified,
    expectFalse "on disk join shape is not specified here"
      onDiskJoinShapeSpecified,
    expectFalse "compound word rules are not specified here"
      compoundWordRulesSpecified,
    expectFalse "default Majestic use is not specified here"
      anunnakiDefaultMajesticSpecified,
    expectFalse "who emits the stack program is not specified here"
      whoEmitsStackProgramSpecified,
    expectFalse "Huffman versus pages length is not measured here"
      huffmanVersusPagesMeasured,
    expectConsFalse "treating ENKI and Anunnaki as one object is Cons False"
      enkiAndAnunnakiAreOneObject
      mashEnkiAndAnunnakiAreOneObject
      mashEnkiAndAnunnakiAreOneObjectIsFalse
      rfl
      mash_enki_and_anunnaki_are_one_object_is_false,
    expectConsFalse "claiming a conforming encoder is Cons False"
      conformingEncoderClaimed
      mashConformingEncoderClaimed
      mashConformingEncoderClaimedIsFalse
      rfl
      mash_conforming_encoder_claimed_is_false,
    expectConsFalse "treating number 0015 as this specification is Cons False"
      number0015IsThisSpecification
      mashNumber0015IsThisSpecification
      mashNumber0015IsThisSpecificationIsFalse
      rfl
      mash_number_0015_is_this_specification_is_false,
    expectConsFalse "treating Carbonado as assigned a number here is Cons False"
      carbonadoAssignedNumber
      mashCarbonadoAssignedNumber
      mashCarbonadoAssignedNumberIsFalse
      rfl
      mash_carbonado_assigned_number_is_false,
    expectConsFalse "treating ENKI as having a numbered specification is Cons False"
      enkiHasNumberedSpecification
      mashEnkiHasNumberedSpecification
      mashEnkiHasNumberedSpecificationIsFalse
      rfl
      mash_enki_has_numbered_specification_is_false,
    expectConsFalse "treating RDPS as assigned a number here is Cons False"
      rdpsAssignedNumber
      mashRdpsAssignedNumber
      mashRdpsAssignedNumberIsFalse
      rfl
      mash_rdps_assigned_number_is_false,
    expectConsFalse "treating FilterScript as assigned a number here is Cons False"
      filterScriptAssignedNumber
      mashFilterScriptAssignedNumber
      mashFilterScriptAssignedNumberIsFalse
      rfl
      mash_filter_script_assigned_number_is_false,
    expectConsFalse "treating a dialect as needing its own LanguageID is Cons False"
      dialectNeedsOwnLanguageId
      mashDialectNeedsOwnLanguageId
      mashDialectNeedsOwnLanguageIdIsFalse
      rfl
      mash_dialect_needs_own_language_id_is_false,
    expectConsFalse "claiming a spelling converter program is Cons False"
      spellingConverterProgramClaimed
      mashSpellingConverterProgramClaimed
      mashSpellingConverterProgramClaimedIsFalse
      rfl
      mash_spelling_converter_claimed_is_false
  ]

def main (_args : List String) : IO UInt32 := do
  let mut failed : Nat := 0
  for c in runCases do
    if c.ok then
      IO.println s!"PASS {c.name}"
    else
      failed := failed + 1
      if c.detail.isEmpty then
        IO.eprintln s!"FAIL {c.name}"
      else
        IO.eprintln s!"FAIL {c.name}: {c.detail}"
  if failed == 0 then
    IO.println s!"anunnaki_tests: {runCases.length} passed"
    return 0
  else
    IO.eprintln s!"anunnaki_tests: {failed} failed"
    return 1
