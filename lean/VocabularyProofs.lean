/-
  PROOFS for the word catalog encodings owned by specification 0005 CATE.

  This module is not the specification. It imports VocabularySpec and
  establishes inverse maps, well formed fixture facts, and catalog
  ownership by specification 0005. Numbered markdown remains the
  contract humans read.
-/

import VocabularySpec
import SpecRegistry

namespace VocabularyProofs

open VocabularySpec

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 5 := rfl

theorem spec_file : specFileName = "0005_CATE.md" := rfl

theorem mash_false : markedAsProof = false := rfl

theorem spec_number_is_5 : specNumber = 5 := rfl

theorem spec_file_is_0005_cate :
    specFileName = "0005_CATE.md" :=
  rfl

theorem pointer_is_vocabulary_md : pointerFileName = "VOCABULARY.md" :=
  rfl

theorem product_name_is_cate : productName = "CATE" := rfl

theorem spec_is_not_0008 : specNumber ≠ 8 := by decide

theorem spec_is_not_0009 : specNumber ≠ 9 := by decide

theorem spec_is_not_0010 : specNumber ≠ 10 := by decide

theorem agrees_registry :
    specNumber = SpecRegistry.vocabularySpecNumber :=
  rfl

theorem agrees_cate :
    specNumber = SpecRegistry.cateSpecNumber :=
  rfl

theorem catalog_is_not_pointer : catalogIsPointerFile = false := rfl

theorem catalog_is_numbered_spec : catalogIsNumberedSpec = true := rfl

theorem live_encodings_without_proofs :
    liveContainsSpecEncodings = true ∧
      liveContainsProofsOfThoseEncodings = false :=
  And.intro rfl rfl

theorem mash_0009_as_published_is_false :
    numberNinePublished = false :=
  rfl

/-!
  Inverse maps on finite lists.
-/

theorem toAspell_nil : toAspell [] = [] := rfl

theorem toAspell_cons (e : VocabEntry) (rest : List VocabEntry) :
    toAspell (e :: rest) = e.word :: toAspell rest :=
  rfl

theorem toAspell_eq_map :
    (es : List VocabEntry) → toAspell es = es.map (·.word)
  | [] => rfl
  | e :: rest => by
      simp [toAspell, List.map, toAspell_eq_map rest]

theorem keep_nil : keepSomeLetter [] = [] := rfl

theorem toAspell_go_keep (last : Option Char) (idx : Nat) :
    (ws : List String) →
      toAspell (ofAspell.go last idx ws) = keepSomeLetter ws
  | [] => rfl
  | w :: rest => by
      cases hletter : letterOf w with
      | none =>
        simp [ofAspell.go, keepSomeLetter, hletter]
        exact toAspell_go_keep last idx rest
      | some L =>
        simp [ofAspell.go, keepSomeLetter, toAspell, hletter, nextIdx]
        exact toAspell_go_keep (some L) (nextIdx last idx L) rest

theorem keep_of_all :
    (ws : List String) → allHaveLetters ws = true → keepSomeLetter ws = ws
  | [], _ => rfl
  | w :: rest, h => by
      unfold allHaveLetters at h
      cases hletter : letterOf w with
      | none =>
        simp [hletter, Option.isSome] at h
      | some L =>
        simp [keepSomeLetter, hletter]
        have hr : allHaveLetters rest = true := by
          simp [hletter, Option.isSome] at h
          exact h
        rw [keep_of_all rest hr]

/-- `toAspell ∘ ofAspell` is the identity on token lists whose words have letters. -/
theorem toAspell_ofAspell (ws : List String)
    (h : allHaveLetters ws = true) :
    toAspell (ofAspell ws) = ws := by
  unfold ofAspell
  rw [toAspell_go_keep none 0 ws, keep_of_all ws h]

theorem bool_and_left (a b : Bool) (h : (a && b) = true) : a = true :=
  match a, b, h with
  | true, true, _ => rfl
  | true, false, h => nomatch h
  | false, true, h => nomatch h
  | false, false, h => nomatch h

theorem bool_and_right (a b : Bool) (h : (a && b) = true) : b = true :=
  match a, b, h with
  | true, true, _ => rfl
  | true, false, h => nomatch h
  | false, true, h => nomatch h
  | false, false, h => nomatch h

theorem wellFormed_assigned (es : List VocabEntry)
    (h : wellFormed es = true) : assigned es = true :=
  bool_and_left _ _ h

theorem wellFormed_letters (es : List VocabEntry)
    (h : wellFormed es = true) : lettersMatchBool es = true :=
  bool_and_left _ _ (bool_and_right _ _ h)

theorem wellFormed_sorted (es : List VocabEntry)
    (h : wellFormed es = true) : wordsSortedEntries es = true :=
  bool_and_left _ _ (bool_and_right _ _ (bool_and_right _ _ h))

theorem wellFormed_no_dup_ids (es : List VocabEntry)
    (h : wellFormed es = true) : noDupIdsBool es = true :=
  bool_and_left _ _
    (bool_and_right _ _ (bool_and_right _ _ (bool_and_right _ _ h)))

theorem wellFormed_no_dup_words (es : List VocabEntry)
    (h : wellFormed es = true) : noDupWordsBool es = true :=
  bool_and_left _ _
    (bool_and_right _ _
      (bool_and_right _ _ (bool_and_right _ _ (bool_and_right _ _ h))))

theorem wellFormed_ids_consecutive (es : List VocabEntry)
    (h : wellFormed es = true) : idsConsecutiveGo none 0 es = true :=
  bool_and_right _ _
    (bool_and_right _ _
      (bool_and_right _ _ (bool_and_right _ _ (bool_and_right _ _ h))))

theorem assigned_eq (es : List VocabEntry) (h : assigned es = true) :
    ofAspell (es.map (·.word)) = es :=
  of_decide_eq_true h

/-- `ofAspell ∘ toAspell` is the identity on well formed entry lists. -/
theorem ofAspell_toAspell (es : List VocabEntry)
    (h : wellFormed es = true) :
    ofAspell (toAspell es) = es := by
  rw [toAspell_eq_map]
  exact assigned_eq es (wellFormed_assigned es h)

theorem fixture_toAspell_ofAspell :
    toAspell (ofAspell fixtureWords) = fixtureWords :=
  toAspell_ofAspell fixtureWords rfl

theorem fixture_ofAspell_toAspell :
    ofAspell (toAspell fixtureEntries) = fixtureEntries :=
  ofAspell_toAspell fixtureEntries rfl

theorem fixture_wellFormed : wellFormed fixtureEntries = true := rfl

theorem fixture_no_dup_ids : noDupIdsBool fixtureEntries = true := rfl

theorem fixture_letter_count_A : letterCount fixtureEntries 'A' = 2 := rfl

theorem fixture_letter_count_B : letterCount fixtureEntries 'B' = 1 := rfl

theorem fixture_letter_count_X : letterCount fixtureEntries 'X' = 0 := rfl

theorem fixture_letter_ids_A : letterIds fixtureEntries 'A' = [1, 2] := rfl

theorem fixture_letter_ids_B : letterIds fixtureEntries 'B' = [1] := rfl

theorem fixture_ids_are_one_to_k_A :
    letterIds fixtureEntries 'A' = consecutiveFromOne 2 := rfl

theorem changelog_before_changelog :
    cmpWord "Changelog" "changelog" = Ordering.lt := rfl

theorem markdown_before_markdown :
    cmpWord "Markdown" "markdown" = Ordering.lt := rfl

theorem ofAspell_case_tie :
    ofAspell ["Changelog", "changelog"] =
      [
        { letter := 'C', index := 1, word := "Changelog" },
        { letter := 'C', index := 2, word := "changelog" }
      ] := rfl

theorem mash_duplicate_token_check_is_complete_ambiguity_checker_is_false :
    mashDuplicateTokenCheckIsCompleteAmbiguityCheckerIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem mash_catalog_isomorphism_proves_definitions_complete_is_false :
    mashCatalogIsomorphismProvesDefinitionsCompleteIsFalse := by
  intro h
  exact Bool.noConfusion h

theorem requires_science_cycle : requiresScienceCycle = true :=
  rfl

theorem tests_only_does_not_conform : testsOnlyConforms = false :=
  rfl

theorem tests_alone_are_not_sufficient :
    testsAloneAreSufficient = false :=
  rfl

theorem model_and_proofs_without_experiments_does_not_conform :
    modelAndProofsWithoutExperimentsConforms = false :=
  rfl

theorem complete_science_conforms_here :
    completeScienceConformsHere = true :=
  rfl

theorem tests_without_model_does_not_conform :
    testsWithoutModelDoesNotConform :=
  rfl

theorem model_and_proofs_without_experiments_does_not_conform_prop :
    modelAndProofsWithoutExperimentsDoesNotConform :=
  rfl

theorem complete_science_conforms : completeScienceConforms :=
  rfl

end VocabularyProofs
