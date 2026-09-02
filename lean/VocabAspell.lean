/-
  Runtime isomorphism between aspell_words.txt tokens and numbered
  specification 0005 (`0005_CATE.md`) L_n catalog entries.

  Types and iso functions live in VocabularySpec.lean. Proofs live in
  VocabularyProofs.lean. This module points the runtime checker at
  0005_CATE.md. Root VOCABULARY.md is a pointer file, not the catalog.

  Number 0009 is Public Domain Open Source Software (PDOSS).
  Unlicense remains the license. The catalog is CATE. This module is not ISO 24495.
-/

import SpecRegistry
import VocabularySpec
import VocabularyProofs

namespace VocabAspell

export VocabularySpec (
  VocabEntry
  idString
  toLowerAscii
  letterOf
  cmpCharNat
  cmpFolded
  cmpAscii
  cmpWord
  allHaveLetters
  keepSomeLetter
  nextIdx
  ofAspell
  toAspell
  wordsSortedList
  wordsSortedEntries
  lettersMatchBool
  idsConsecutiveGo
  hasDup
  noDupIdsBool
  noDupWordsBool
  assigned
  wellFormed
  filterBool
  letterCount
  letterIds
  consecutiveFromOne
  aspellHeaderPrefix
  digitsToNat
  parseNatDecimal
  parseAspellHeader
  parseHeading
  looksLikeEntryHeading
  startsWithFence
  parseVocabEntries
  parseLetterHeading
  parseLetterHeadings
  nonemptyLetters
  dropEmptyLines
  parseAspellFile
  fixtureWords
  fixtureEntries
  specFileName
  specNumber
  pointerFileName
)

export VocabularyProofs (
  fixture_wellFormed
  toAspell_ofAspell
  ofAspell_toAspell
)

/-- Catalog markdown the runtime iso MUST read. -/
def vocabMarkdownFileName : String := VocabularySpec.specFileName

theorem vocab_markdown_is_0005_cate :
    vocabMarkdownFileName = "0005_CATE.md" :=
  rfl

theorem vocab_markdown_equals_cate :
    vocabMarkdownFileName = SpecRegistry.vocabularyFileName :=
  rfl

theorem vocab_markdown_is_not_pointer :
    vocabMarkdownFileName ≠ VocabularySpec.pointerFileName := by
  decide

end VocabAspell
