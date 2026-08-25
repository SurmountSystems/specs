/-
  Isomorphism between aspell_words.txt tokens and VOCABULARY.md L_n entries.

  VOCABULARY.md is the human source of truth for definitions. This module
  checks that the two files name the same set of tokens, that each token has
  exactly one L_n id, that ids for letter L are L_1 .. L_k with no gaps, and
  that words under a letter are sorted by ASCII without regard to case, then
  by ASCII code when the folded forms tie.

  This module is not a numbered specification. It is not ISO 24495.
-/

namespace VocabAspell

/-- One vocabulary entry: letter, 1-based index, aspell token. -/
structure VocabEntry where
  letter : Char
  index : Nat
  word : String
  deriving DecidableEq, Repr, BEq, Inhabited

def idString (e : VocabEntry) : String :=
  s!"{e.letter}_{e.index}"

/-- Fold A-Z to a-z. Other ASCII bytes stay. -/
def toLowerAscii (c : Char) : Char :=
  if 'A' ≤ c && c ≤ 'Z' then
    Char.ofNat (c.toNat + 32)
  else
    c

/-- First letter of a token as A-Z, or none if the token is empty or not a letter. -/
def letterOf (w : String) : Option Char :=
  match w.toList with
  | [] => none
  | c :: _ =>
    let u :=
      if 'a' ≤ c && c ≤ 'z' then
        Char.ofNat (c.toNat - 32)
      else
        c
    if 'A' ≤ u && u ≤ 'Z' then some u else none

def cmpCharNat (a b : Char) : Ordering :=
  if a.toNat < b.toNat then .lt
  else if a.toNat > b.toNat then .gt
  else .eq

/-- Case-folded ASCII compare, then original ASCII when the folded forms tie. -/
def cmpFolded : List Char → List Char → Ordering
  | [], [] => .eq
  | [], _ => .lt
  | _, [] => .gt
  | x :: xs, y :: ys =>
    match cmpCharNat (toLowerAscii x) (toLowerAscii y) with
    | .eq => cmpFolded xs ys
    | o => o

def cmpAscii : List Char → List Char → Ordering
  | [], [] => .eq
  | [], _ => .lt
  | _, [] => .gt
  | x :: xs, y :: ys =>
    match cmpCharNat x y with
    | .eq => cmpAscii xs ys
    | o => o

/-- Sort key used by VOCABULARY.md and aspell_words.txt. -/
def cmpWord (a b : String) : Ordering :=
  match cmpFolded a.toList b.toList with
  | .eq => cmpAscii a.toList b.toList
  | o => o

def allHaveLetters : List String → Bool
  | [] => true
  | w :: rest => (letterOf w).isSome && allHaveLetters rest

def keepSomeLetter : List String → List String
  | [] => []
  | w :: rest =>
    match letterOf w with
    | none => keepSomeLetter rest
    | some _ => w :: keepSomeLetter rest

def nextIdx (last : Option Char) (idx : Nat) (L : Char) : Nat :=
  match last with
  | some L' => if L' = L then idx + 1 else 1
  | none => 1

/-- Assign L_n ids in list order, restarting at 1 when the letter changes. -/
def ofAspell.go (last : Option Char) (idx : Nat) : List String → List VocabEntry
  | [] => []
  | w :: rest =>
    match letterOf w with
    | none => ofAspell.go last idx rest
    | some L =>
      let idx' := nextIdx last idx L
      { letter := L, index := idx', word := w } ::
        ofAspell.go (some L) idx' rest

/-- Map an aspell token list to vocabulary entries. -/
def ofAspell (ws : List String) : List VocabEntry :=
  ofAspell.go none 0 ws

/-- Map vocabulary entries to aspell tokens, preserving order. -/
def toAspell : List VocabEntry → List String
  | [] => []
  | e :: rest => e.word :: toAspell rest

def wordsSortedList : List String → Bool
  | [] => true
  | [_] => true
  | a :: b :: rest =>
    (cmpWord a b == Ordering.lt) && wordsSortedList (b :: rest)

def wordsSortedEntries : List VocabEntry → Bool
  | [] => true
  | [_] => true
  | a :: b :: rest =>
    (cmpWord a.word b.word == Ordering.lt) && wordsSortedEntries (b :: rest)

def lettersMatchBool : List VocabEntry → Bool
  | [] => true
  | e :: rest =>
    (letterOf e.word == some e.letter) && lettersMatchBool rest

def idsConsecutiveGo (last : Option Char) (idx : Nat) : List VocabEntry → Bool
  | [] => true
  | e :: rest =>
    let expect : Nat :=
      match last with
      | some L => if L == e.letter then idx + 1 else 1
      | none => 1
    let letterStep : Bool :=
      match last with
      | none => true
      | some L => L == e.letter || decide (L.toNat < e.letter.toNat)
    (e.index == expect) && decide (e.index ≥ 1) && letterStep &&
      idsConsecutiveGo (some e.letter) e.index rest

def hasDup : List String → Bool
  | [] => false
  | x :: xs => xs.contains x || hasDup xs

def noDupIdsBool (es : List VocabEntry) : Bool :=
  !(hasDup (es.map idString))

def noDupWordsBool (es : List VocabEntry) : Bool :=
  !(hasDup (es.map (·.word)))

def assigned (es : List VocabEntry) : Bool :=
  decide (ofAspell (es.map (·.word)) = es)

def wellFormed (es : List VocabEntry) : Bool :=
  assigned es &&
    (lettersMatchBool es &&
      (wordsSortedEntries es &&
        (noDupIdsBool es &&
          (noDupWordsBool es && idsConsecutiveGo none 0 es))))

def filterBool {α} (p : α → Bool) : List α → List α
  | [] => []
  | x :: xs => if p x then x :: filterBool p xs else filterBool p xs

def letterCount (es : List VocabEntry) (L : Char) : Nat :=
  (filterBool (fun e => e.letter == L) es).length

def letterIds (es : List VocabEntry) (L : Char) : List Nat :=
  (filterBool (fun e => e.letter == L) es).map (·.index)

def consecutiveFromOne (k : Nat) : List Nat :=
  (List.range k).map (fun i => i + 1)

/-- Header `personal_ws-1.1 en N` carries the word count N. -/
def aspellHeaderPrefix : String := "personal_ws-1.1 en "

def digitsToNat (cs : List Char) : Nat :=
  cs.foldl (fun n c => n * 10 + (c.toNat - '0'.toNat)) 0

def parseNatDecimal (s : String) : Option Nat :=
  let cs := s.toList
  if cs.isEmpty then none
  else if cs.all Char.isDigit then some (digitsToNat cs) else none

def parseAspellHeader (line : String) : Option Nat :=
  if line.startsWith aspellHeaderPrefix then
    parseNatDecimal (String.ofList (line.toList.drop aspellHeaderPrefix.length))
  else
    none

/-- Parse `### A_1 `ABI`` (regex in VOCABULARY.md). -/
def parseHeading (line : String) : Option VocabEntry :=
  let cs := line.toList
  match cs with
  | '#' :: '#' :: '#' :: ' ' :: L :: '_' :: rest =>
    if !('A' ≤ L && L ≤ 'Z') then
      none
    else
      let digits := rest.takeWhile Char.isDigit
      let after := rest.dropWhile Char.isDigit
      if digits.isEmpty then
        none
      else
        match after with
        | ' ' :: '`' :: more =>
          let wordChars := more.takeWhile (fun c => c != '`')
          let tail := more.dropWhile (fun c => c != '`')
          match tail with
          | '`' :: [] =>
            if wordChars.isEmpty then none
            else
              some {
                letter := L
                index := digitsToNat digits
                word := String.ofList wordChars
              }
          | _ => none
        | _ => none
  | _ => none

/-- A line that claims to be an L_n heading (starts `### X_`). -/
def looksLikeEntryHeading (line : String) : Bool :=
  let cs := line.toList
  match cs with
  | '#' :: '#' :: '#' :: ' ' :: L :: '_' :: _ =>
    'A' ≤ L && L ≤ 'Z'
  | _ => false

def startsWithFence (cs : List Char) : Bool :=
  match cs with
  | '`' :: '`' :: '`' :: _ => true
  | _ => false

/-- Collect entry headings outside fenced code. Malformed L_n lines are errors. -/
def parseVocabEntries (content : String) :
    Except (Nat × String) (List VocabEntry) :=
  Id.run do
    let lines := content.splitOn "\n"
    let mut inFence := false
    let mut out : List VocabEntry := []
    let mut lineNo : Nat := 0
    for line in lines do
      lineNo := lineNo + 1
      let cs := line.toList
      if startsWithFence cs then
        inFence := !inFence
      else if !inFence then
        if looksLikeEntryHeading line then
          match parseHeading line with
          | some e => out := out ++ [e]
          | none =>
            return .error
              (lineNo, "entry heading does not match ^### L_n backtick-word-backtick$")
    return .ok out

def parseLetterHeading (line : String) : Option Char :=
  match line.toList with
  | '#' :: '#' :: ' ' :: L :: [] =>
    if 'A' ≤ L && L ≤ 'Z' then some L else none
  | _ => none

def parseLetterHeadings (content : String) : List Char :=
  Id.run do
    let lines := content.splitOn "\n"
    let mut inFence := false
    let mut out : List Char := []
    for line in lines do
      let cs := line.toList
      if startsWithFence cs then
        inFence := !inFence
      else if !inFence then
        match parseLetterHeading line with
        | some L => out := out ++ [L]
        | none => pure ()
    return out

def nonemptyLetters (es : List VocabEntry) : List Char :=
  Id.run do
    let mut seen : List Char := []
    for e in es do
      if !seen.contains e.letter then
        seen := seen ++ [e.letter]
    return seen

def dropEmptyLines (ws : List String) : List String :=
  filterBool (fun w => !w.isEmpty) ws

def parseAspellFile (content : String) : Except String (Nat × List String) :=
  let raw := dropEmptyLines (content.splitOn "\n")
  match raw with
  | [] => .error "aspell_words.txt is empty"
  | header :: words =>
    match parseAspellHeader header with
    | none =>
      .error "aspell_words.txt header must be `personal_ws-1.1 en N`"
    | some n =>
      if words.any (fun w => w.contains ' ') then
        .error "aspell token contains a space"
      else
        .ok (n, words)

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

/-!
  Finite fixture (not the repository list). The repository list is checked
  in `vocab_aspell_tests` by parsing both files.
-/

def fixtureWords : List String := ["ABI", "AbsInt", "beastdb"]

def fixtureEntries : List VocabEntry :=
  [
    { letter := 'A', index := 1, word := "ABI" },
    { letter := 'A', index := 2, word := "AbsInt" },
    { letter := 'B', index := 1, word := "beastdb" }
  ]

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

end VocabAspell
