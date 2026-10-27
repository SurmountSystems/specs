import SchedulaSpec
import «0017_Schedula»

theorem ratNatDivPos (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
    (0 : Rat) < (n : Rat) / (d : Rat) := by
  rw [Rat.div_def]
  exact Rat.mul_pos (Rat.natCast_pos.mpr hn) (Rat.inv_pos.mpr (Rat.natCast_pos.mpr hd))

theorem ratNatDivNonneg (n d : Nat) (hn : 0 < n) (hd : 0 < d) :
    (0 : Rat) ≤ (n : Rat) / (d : Rat) :=
  Rat.le_of_lt (ratNatDivPos n d hn hd)

open SchedulaSpec

/-
  Proofs for specification 0017. Encodings stay in the sibling module.
  `hasPositiveEigenvector` on `goodState` is the Perron statement, not `False`.
-/

private theorem natAddOneAdd (a b : Nat) : a + 1 + b = a + b + 1 := by
  rw [Nat.add_assoc, Nat.add_comm 1 b, ← Nat.add_assoc]

/-- Length splits across `take` and `drop` without walking a concrete encoding. -/
private theorem length_take_add_drop {α : Type} (xs : List α) (n : Nat) :
    xs.length = (xs.take n).length + (xs.drop n).length := by
  induction xs generalizing n with
  | nil =>
    cases n <;> rfl
  | cons a xs ih =>
    cases n with
    | zero =>
      simp only [List.take, List.drop]
      rw [List.length_nil]
      exact (Nat.zero_add ((a :: xs).length)).symm
    | succ n =>
      simp only [List.take, List.drop, List.length]
      rw [ih n]
      exact (natAddOneAdd (xs.take n).length (xs.drop n).length).symm

private theorem length_eq_take_drop {α : Type} (xs : List α) (n k : Nat)
    (ht : (xs.take n).length = n) (hd : (xs.drop n).length = k) :
    xs.length = n + k := by
  rw [length_take_add_drop xs n, ht, hd]

theorem encoded_size : «0017_Schedula».encodedLines.size = 309 := by
  -- One `decide` on all 309 lines recurses past the limit. Each step
  -- decides a take of 32 lines, then simplifies one `drop` so the next
  -- step does not nest another walk.
  rw [show «0017_Schedula».encodedLines.size =
      «0017_Schedula».encodedLines.toList.length from rfl]
  have hnum : (309 : Nat) = 32 + 277 := by decide
  rw [hnum]
  apply length_eq_take_drop (n := 32) (k := 277)
  · decide
  · unfold «0017_Schedula».encodedLines
    dsimp only [List.toArray]
    repeat rw [List.drop_succ_cons]
    rw [List.drop_zero]
    have hnum : (277 : Nat) = 32 + 245 := by decide
    rw [hnum]
    apply length_eq_take_drop (n := 32) (k := 245)
    · decide
    · repeat rw [List.drop_succ_cons]
      rw [List.drop_zero]
      have hnum : (245 : Nat) = 32 + 213 := by decide
      rw [hnum]
      apply length_eq_take_drop (n := 32) (k := 213)
      · decide
      · repeat rw [List.drop_succ_cons]
        rw [List.drop_zero]
        have hnum : (213 : Nat) = 32 + 181 := by decide
        rw [hnum]
        apply length_eq_take_drop (n := 32) (k := 181)
        · decide
        · repeat rw [List.drop_succ_cons]
          rw [List.drop_zero]
          have hnum : (181 : Nat) = 32 + 149 := by decide
          rw [hnum]
          apply length_eq_take_drop (n := 32) (k := 149)
          · decide
          · repeat rw [List.drop_succ_cons]
            rw [List.drop_zero]
            have hnum : (149 : Nat) = 32 + 117 := by decide
            rw [hnum]
            apply length_eq_take_drop (n := 32) (k := 117)
            · decide
            · repeat rw [List.drop_succ_cons]
              rw [List.drop_zero]
              have hnum : (117 : Nat) = 32 + 85 := by decide
              rw [hnum]
              apply length_eq_take_drop (n := 32) (k := 85)
              · decide
              · repeat rw [List.drop_succ_cons]
                rw [List.drop_zero]
                have hnum : (85 : Nat) = 32 + 53 := by decide
                rw [hnum]
                apply length_eq_take_drop (n := 32) (k := 53)
                · decide
                · repeat rw [List.drop_succ_cons]
                  rw [List.drop_zero]
                  have hnum : (53 : Nat) = 32 + 21 := by decide
                  rw [hnum]
                  apply length_eq_take_drop (n := 32) (k := 21)
                  · decide
                  · repeat rw [List.drop_succ_cons]
                    rw [List.drop_zero]
                    decide

private theorem ratLtOfLtOfLe {a b c : Rat} (hab : a < b) (hbc : b ≤ c) : a < c := by
  rw [Rat.lt_iff_le_and_ne] at hab ⊢
  refine ⟨Rat.le_trans hab.1 hbc, ?_⟩
  intro heq
  exact hab.2 (Rat.le_antisymm hab.1 (heq ▸ hbc))

private theorem ratMulNonneg {a b : Rat} (ha : 0 ≤ a) (hb : 0 ≤ b) : 0 ≤ a * b :=
  Rat.mul_nonneg ha hb

private theorem ratMulPos {a b : Rat} (ha : 0 < a) (hb : 0 < b) : 0 < a * b :=
  Rat.mul_pos ha hb

private theorem ratDivPos {a b : Rat} (ha : 0 < a) (hb : 0 < b) : 0 < a / b := by
  rw [Rat.div_def]
  exact Rat.mul_pos ha (Rat.inv_pos.mpr hb)

private theorem ratDivMulCancel (a b : Rat) (hb : 0 < b) : a / b * b = a :=
  Rat.div_mul_cancel (Rat.ne_of_gt hb)

private theorem ratAddPosOfNonnegOfPos {a b : Rat} (ha : 0 ≤ a) (hb : 0 < b) : 0 < a + b := by
  have hle : b ≤ a + b := by
    have h : 0 + b ≤ a + b := (Rat.add_le_add_right).mpr ha
    simpa [Rat.zero_add] using h
  exact ratLtOfLtOfLe hb hle

private theorem ratAddNonneg {a b : Rat} (ha : 0 ≤ a) (hb : 0 ≤ b) : 0 ≤ a + b := by
  have h1 : 0 + b ≤ a + b := (Rat.add_le_add_right).mpr ha
  exact Rat.le_trans (by simpa [Rat.zero_add] using hb) h1

private theorem ratCastNeZero (n : Nat) (hn : 0 < n) : (n : Rat) ≠ 0 :=
  fun h => Nat.ne_of_gt hn (Rat.natCast_eq_zero_iff.mp h)

private theorem ratNatCastPos (n : Nat) (hn : 1 ≤ n) : (0 : Rat) < (n : Rat) :=
  Rat.natCast_pos.mpr (Nat.succ_le_iff.mp hn)

private theorem ratNatNe (a b : Nat) (h : a ≠ b) : (a : Rat) ≠ (b : Rat) :=
  fun heq => h ((Rat.natCast_inj).mp heq)

private theorem ratNatDivEq (a b c d : Nat) (hb : 0 < b) (hd : 0 < d)
    (h : a * d = c * b) : (a : Rat) / (b : Rat) = (c : Rat) / (d : Rat) := by
  have hb0 : ((b : Nat) : Int) ≠ 0 := Int.natCast_ne_zero.mpr (Nat.ne_of_gt hb)
  have hd0 : ((d : Nat) : Int) ≠ 0 := Int.natCast_ne_zero.mpr (Nat.ne_of_gt hd)
  have hI : ((a : Nat) : Int) * ((d : Nat) : Int) = ((c : Nat) : Int) * ((b : Nat) : Int) := by
    rw [← Int.natCast_mul, ← Int.natCast_mul]
    exact congrArg (Nat.cast : Nat → Int) h
  have h1 : (a : Rat) / (b : Rat) = Rat.divInt ((a : Nat) : Int) ((b : Nat) : Int) :=
    (Rat.divInt_eq_div ((a : Nat) : Int) ((b : Nat) : Int)).symm
  have h2 : (c : Rat) / (d : Rat) = Rat.divInt ((c : Nat) : Int) ((d : Nat) : Int) :=
    (Rat.divInt_eq_div ((c : Nat) : Int) ((d : Nat) : Int)).symm
  have h3 : Rat.divInt ((a : Nat) : Int) ((b : Nat) : Int) = Rat.divInt ((c : Nat) : Int) ((d : Nat) : Int) :=
    (Rat.divInt_eq_divInt_iff hb0 hd0).mpr hI
  exact h1.trans (h3.trans h2.symm)

private theorem ratInvMul (b c : Rat) : b⁻¹ * c⁻¹ = (b * c)⁻¹ := by
  rw [Rat.inv_mul_rev, Rat.mul_comm]

private theorem ratDivDiv (a b c : Rat) : (a / b) / c = a / (b * c) := by
  rw [Rat.div_def, Rat.div_def, Rat.div_def, Rat.mul_assoc, ratInvMul]

private theorem ratMulDivDivRat (a b c d : Rat) : (a / b) * (c / d) = (a * c) / (b * d) := by
  rw [Rat.div_def, Rat.div_def, Rat.div_def, ← ratInvMul]
  calc
    (a * b⁻¹) * (c * d⁻¹) = a * (b⁻¹ * (c * d⁻¹)) := Rat.mul_assoc a b⁻¹ (c * d⁻¹)
    _ = a * ((b⁻¹ * c) * d⁻¹) := by rw [Rat.mul_assoc b⁻¹ c d⁻¹]
    _ = a * ((c * b⁻¹) * d⁻¹) := by rw [Rat.mul_comm b⁻¹ c]
    _ = a * (c * (b⁻¹ * d⁻¹)) := by rw [← Rat.mul_assoc c b⁻¹ d⁻¹]
    _ = (a * c) * (b⁻¹ * d⁻¹) := by rw [← Rat.mul_assoc a c (b⁻¹ * d⁻¹)]

private theorem ratMulDivDiv (a b c d : Nat) :
    ((a : Rat) / (b : Rat)) * ((c : Rat) / (d : Rat)) =
      ((a * c : Nat) : Rat) / ((b * d : Nat) : Rat) := by
  rw [ratMulDivDivRat, Rat.natCast_mul, Rat.natCast_mul]

private theorem ratAddDiv (a b d : Rat) : a / d + b / d = (a + b) / d := by
  rw [Rat.div_def, Rat.div_def, Rat.div_def, ← Rat.add_mul]

private theorem ratAddDivNat (a b d : Nat) :
    (a : Rat) / (d : Rat) + (b : Rat) / (d : Rat) = ((a + b : Nat) : Rat) / (d : Rat) := by
  rw [ratAddDiv, Rat.natCast_add]

private theorem ratSubDiv (a b d : Rat) : a / d - b / d = (a - b) / d := by
  rw [Rat.sub_eq_add_neg, Rat.sub_eq_add_neg, Rat.div_def, Rat.div_def, Rat.div_def,
    ← Rat.neg_mul, ← Rat.add_mul]

private theorem ratNatDivSelf (n : Nat) (hn : 0 < n) : (n : Rat) / (n : Rat) = 1 := by
  rw [Rat.div_def]
  exact Rat.mul_inv_cancel _ (ratCastNeZero n hn)

private theorem ratNatSubOne (n : Nat) (hn : 1 ≤ n) :
    (n : Rat) - 1 = ((n - 1 : Nat) : Rat) := by
  have h : (n - 1) + 1 = n := Nat.sub_add_cancel hn
  rw [← h, Rat.natCast_add, Rat.natCast_ofNat (a := 1), Rat.add_sub_cancel,
    Nat.add_sub_cancel]

private theorem oneSubOneOver (n : Nat) (hn : 1 ≤ n) :
    (1 : Rat) - (1 : Rat) / (n : Rat) = ((n - 1 : Nat) : Rat) / (n : Rat) := by
  have hn0 : 0 < n := Nat.succ_le_iff.mp hn
  calc
    (1 : Rat) - (1 : Rat) / (n : Rat)
        = (n : Rat) / (n : Rat) - (1 : Rat) / (n : Rat) := by rw [ratNatDivSelf n hn0]
    _ = ((n : Rat) - 1) / (n : Rat) := ratSubDiv (n : Rat) 1 (n : Rat)
    _ = ((n - 1 : Nat) : Rat) / (n : Rat) := by rw [ratNatSubOne n hn]

private theorem ratMulDivCancelNat (a b : Nat) (hb : 0 < b) :
    ((a * b : Nat) : Rat) / (b : Rat) = (a : Rat) := by
  rw [Rat.natCast_mul, Rat.mul_div_cancel (ratCastNeZero b hb)]

private theorem ratNatOverOne (n : Nat) : (n : Rat) / (1 : Rat) = (n : Rat) := by
  have hne : (1 : Rat) ≠ 0 := ratCastNeZero 1 (by decide)
  have hinv : (1 : Rat)⁻¹ = 1 := by
    have h := Rat.mul_inv_cancel (1 : Rat) hne
    rw [Rat.one_mul] at h
    exact h
  rw [Rat.div_def, hinv, Rat.mul_one]

private theorem ratOneInv : (1 : Rat)⁻¹ = 1 := by
  have h := Rat.mul_inv_cancel (1 : Rat) (ratCastNeZero 1 (by decide))
  rw [Rat.one_mul] at h
  exact h

private theorem ratMulNatDiv (k a d : Nat) (hd : 0 < d) :
    (k : Rat) * ((a : Rat) / (d : Rat)) = ((k * a : Nat) : Rat) / (d : Rat) := by
  rw [← ratNatOverOne k, ← Rat.natCast_ofNat (a := 1), ratMulDivDiv, Nat.one_mul]

private theorem oneMinusAlpha : (1 : Rat) - alpha = (4 : Rat) / 5 := by
  unfold alpha
  have h := oneSubOneOver 5 (by decide)
  have h4 : (5 - 1 : Nat) = 4 := by decide
  rwa [h4] at h

private theorem alphaPos : (0 : Rat) < alpha := by
  unfold alpha
  exact ratNatDivPos 1 5 (by decide) (by decide)

private theorem oneMinusAlphaNonneg : (0 : Rat) ≤ 1 - alpha := by
  rw [oneMinusAlpha]
  exact ratNatDivNonneg 4 5 (by decide) (by decide)

private theorem ratMulSub (a b c : Rat) : a * (b - c) = a * b - a * c := by
  rw [Rat.sub_eq_add_neg, Rat.sub_eq_add_neg, Rat.mul_add, Rat.mul_neg]

private theorem ratSubMul (a b c : Rat) : (a - b) * c = a * c - b * c := by
  rw [Rat.sub_eq_add_neg, Rat.sub_eq_add_neg, Rat.add_mul, Rat.neg_mul]

private theorem ratSubEqZero {a b : Rat} (h : a - b = 0) : a = b := by
  have h' := congrArg (· + b) h
  simpa [Rat.sub_add_cancel, Rat.zero_add] using h'

private theorem ratMulRightCancel {a b c : Rat} (hc : c ≠ 0) (h : a * c = b * c) : a = b := by
  have h' := congrArg (· * c⁻¹) h
  rw [Rat.mul_assoc, Rat.mul_assoc, Rat.mul_inv_cancel _ hc, Rat.mul_one, Rat.mul_one] at h'
  exact h'

private theorem ratSubAddSub (a b c d : Rat) : (a - b) + (c - d) = (a + c) - (b + d) := by
  rw [Rat.sub_eq_add_neg, Rat.sub_eq_add_neg, Rat.sub_eq_add_neg, Rat.neg_add]
  rw [Rat.add_assoc, ← Rat.add_assoc (-b) c (-d), Rat.add_comm (-b) c]
  rw [Rat.add_assoc, ← Rat.add_assoc a c]

private theorem ratMulAssocComm (a b c : Rat) : a * (b * c) = b * (a * c) := by
  rw [← Rat.mul_assoc, Rat.mul_comm a b, Rat.mul_assoc]

private theorem ratSubAdd (a b c : Rat) : a - (b + c) = a - b - c := by
  rw [Rat.sub_eq_add_neg, Rat.sub_eq_add_neg, Rat.sub_eq_add_neg, Rat.neg_add, Rat.add_assoc]

private theorem ratThreeSubTwo (z : Rat) : (3 : Rat) * z - (2 : Rat) * z = z := by
  have h32 : (3 : Nat) = 2 + 1 := by decide
  have hNat : (3 : Nat) - 2 = 1 := by
    rewrite [h32]
    exact Nat.add_sub_cancel_left _ _
  have h3 : (3 : Rat) = (2 : Rat) + ((3 - 2 : Nat) : Rat) := by
    rw [← Rat.natCast_ofNat (a := 3), congrArg (fun n : Nat => (n : Rat)) h32,
      Rat.natCast_add, Rat.natCast_ofNat (a := 2),
      ← congrArg (fun n : Nat => (n : Rat)) hNat]
  rw [h3, congrArg (fun n : Nat => (n : Rat)) hNat, Rat.natCast_ofNat (a := 1),
    Rat.add_mul, Rat.one_mul, Rat.add_comm ((2 : Rat) * z) z, Rat.add_sub_cancel]

private theorem ratInvDiv (c d : Rat) : (c / d)⁻¹ = d / c := by
  rw [Rat.div_def, Rat.inv_mul_rev, Rat.inv_inv, ← Rat.div_def]

private theorem midConst (n : Nat) : ((n : Rat) + (n : Rat)) / 2 = (n : Rat) := by
  rw [← Rat.natCast_add, (Nat.two_mul n).symm, Nat.mul_comm, ← Rat.natCast_ofNat (a := 2), ratMulDivCancelNat n 2 (by decide)]

theorem one_tenth_pos : 0 < (1 / 10 : Rat) :=
  ratNatDivPos 1 10 (by decide) (by decide)

theorem damp_entry_pos (a : Rat) (n : Nat) (ha : 0 ≤ a) (hn : 1 ≤ n) :
    0 < (1 - alpha) * a + alpha / (n : Rat) := by
  have hprod : (0 : Rat) ≤ (1 - alpha) * a := ratMulNonneg oneMinusAlphaNonneg ha
  have hdiv : (0 : Rat) < alpha / (n : Rat) :=
    ratDivPos alphaPos (ratNatCastPos n hn)
  exact ratAddPosOfNonnegOfPos hprod hdiv

theorem matrixA_exampleChain_zero (i j : NodeId) : matrixA exampleChain i j = 0 := by
  unfold matrixA exampleChain
  simp only [List.foldl_cons, List.foldl_nil]
  unfold chainEdge
  split
  · rw [Rat.zero_add]
  · rfl

theorem chain_node_count : exampleChain.nodes.length = 2 := by
  unfold exampleChain
  rfl

theorem matrixB_exampleChain (i j : NodeId) : matrixB exampleChain i j = (1 / 10 : Rat) := by
  unfold matrixB matrixBWith
  rw [matrixA_exampleChain_zero i j, chain_node_count]
  unfold alpha
  rw [Rat.mul_zero, Rat.zero_add, ratDivDiv,
    ← Rat.natCast_ofNat (a := 1), ← Rat.natCast_ofNat (a := 5),
    ← Rat.natCast_ofNat (a := 10), ← Rat.natCast_mul]

theorem matrixB_chain_nodes :
    matrixB exampleChain ⟨0⟩ ⟨0⟩ = (1 / 10 : Rat) ∧
    matrixB exampleChain ⟨0⟩ ⟨1⟩ = (1 / 10 : Rat) ∧
    matrixB exampleChain ⟨1⟩ ⟨0⟩ = (1 / 10 : Rat) ∧
    matrixB exampleChain ⟨1⟩ ⟨1⟩ = (1 / 10 : Rat) := by
  refine ⟨matrixB_exampleChain ⟨0⟩ ⟨0⟩, matrixB_exampleChain ⟨0⟩ ⟨1⟩,
    matrixB_exampleChain ⟨1⟩ ⟨0⟩, matrixB_exampleChain ⟨1⟩ ⟨1⟩⟩

theorem applyB_chain_general (v : NodeId → Rat) (i : NodeId) :
    applyB exampleChain v i = (1 / 10 : Rat) * v ⟨0⟩ + (1 / 10 : Rat) * v ⟨1⟩ := by
  have h0 := matrixB_exampleChain i ⟨0⟩
  have h1 := matrixB_exampleChain i ⟨1⟩
  unfold applyB exampleChain at *
  simp only [List.foldl_cons, List.foldl_nil]
  have hid0 : chainNode0.id = ⟨0⟩ := rfl
  have hid1 : chainNode1.id = ⟨1⟩ := rfl
  rw [hid0, hid1, h0, h1, Rat.zero_add]

theorem chain_eigenvector : isPositiveEigenvector exampleChain (fun _ => (1 : Rat)) (1 / 5) := by
  unfold isPositiveEigenvector positiveOnNodes
  constructor
  · intro _n _hn
    exact Rat.natCast_pos.mpr (by decide)
  · intro _n _hn
    rw [applyB_chain_general, Rat.mul_one, Rat.mul_one]
    simp only [← Rat.natCast_ofNat]
    rw [ratAddDivNat 1 1 10]
    have h2 : (1 + 1 : Nat) = 2 := by decide
    rw [h2]
    exact ratNatDivEq 2 10 1 5 (by decide) (by decide) (by decide)

private theorem chain_index_lt_zero : 0 < exampleChain.nodes.length := by
  rw [chain_node_count]
  decide

private theorem chain_index_lt_one : 1 < exampleChain.nodes.length := by
  rw [chain_node_count]
  decide

private theorem chain_node0_id : (exampleChain.nodes[0]'chain_index_lt_zero).id = ⟨0⟩ := by
  unfold exampleChain chainNode0
  rfl

private theorem chain_node1_id : (exampleChain.nodes[1]'chain_index_lt_one).id = ⟨1⟩ := by
  unfold exampleChain chainNode1
  rfl

theorem chain_equal_components (v : NodeId → Rat) (lam : Rat)
    (hv : isPositiveEigenvector exampleChain v lam) :
    lam = (1 / 5 : Rat) ∧ v ⟨0⟩ = v ⟨1⟩ ∧ 0 < v ⟨0⟩ ∧ 0 < v ⟨1⟩ := by
  unfold isPositiveEigenvector positiveOnNodes at hv
  obtain ⟨hpos, happ⟩ := hv
  have hmem0 : exampleChain.nodes[0] ∈ exampleChain.nodes :=
    List.getElem_mem chain_index_lt_zero
  have hmem1 : exampleChain.nodes[1] ∈ exampleChain.nodes :=
    List.getElem_mem chain_index_lt_one
  have happ0 := happ _ hmem0
  have happ1 := happ _ hmem1
  rw [chain_node0_id, applyB_chain_general] at happ0
  rw [chain_node1_id, applyB_chain_general] at happ1
  have hpos0 : 0 < v ⟨0⟩ := by
    simpa [chain_node0_id] using hpos _ hmem0
  have hpos1 : 0 < v ⟨1⟩ := by
    simpa [chain_node1_id] using hpos _ hmem1
  have hS0 : (1 / 10 : Rat) * v ⟨0⟩ + (1 / 10 : Rat) * v ⟨1⟩ = lam * v ⟨0⟩ := happ0
  have hS1 : (1 / 10 : Rat) * v ⟨0⟩ + (1 / 10 : Rat) * v ⟨1⟩ = lam * v ⟨1⟩ := happ1
  have hxy : lam * v ⟨0⟩ = lam * v ⟨1⟩ := hS0.symm.trans hS1
  have hsplit : lam = 0 ∨ v ⟨0⟩ = v ⟨1⟩ := by
    have hzero : lam * v ⟨0⟩ - lam * v ⟨1⟩ = 0 := by
      rw [hxy, Rat.sub_self]
    have hfac : lam * (v ⟨0⟩ - v ⟨1⟩) = 0 := by
      rw [ratMulSub, hzero]
    cases (Rat.mul_eq_zero).mp hfac with
    | inl hlam0 =>
      exact Or.inl hlam0
    | inr hdiff =>
      exact Or.inr (ratSubEqZero hdiff)
  cases hsplit with
  | inl hlam0 =>
    exfalso
    have htenth : (0 : Rat) < (1 / 10 : Rat) := ratNatDivPos 1 10 (by decide) (by decide)
    have hsum : 0 < (1 / 10 : Rat) * v ⟨0⟩ + (1 / 10 : Rat) * v ⟨1⟩ :=
      ratAddPosOfNonnegOfPos (Rat.le_of_lt (Rat.mul_pos htenth hpos0)) (Rat.mul_pos htenth hpos1)
    rw [hlam0, Rat.zero_mul] at hS0
    exact Rat.ne_of_gt hsum hS0
  | inr heq =>
    have hlam : lam = (1 / 5 : Rat) := by
      have hsum : (1 / 10 : Rat) * v ⟨0⟩ + (1 / 10 : Rat) * v ⟨0⟩ = lam * v ⟨0⟩ := by
        rw [← heq] at hS0
        exact hS0
      have htwo : (1 / 10 : Rat) + (1 / 10 : Rat) = (2 : Rat) / 10 := by
        simp only [← Rat.natCast_ofNat]
        rw [ratAddDivNat 1 1 10]
      have hfac : ((2 : Rat) / 10) * v ⟨0⟩ = lam * v ⟨0⟩ := by
        rw [← Rat.add_mul, htwo] at hsum
        exact hsum
      have hfifth : (2 : Rat) / 10 = (1 : Rat) / 5 :=
        ratNatDivEq 2 10 1 5 (by decide) (by decide) (by decide)
      rw [hfifth] at hfac
      have hsub : ((1 : Rat) / 5) * v ⟨0⟩ - lam * v ⟨0⟩ = 0 := by
        rw [hfac, Rat.sub_self]
      have hlin : ((1 : Rat) / 5 - lam) * v ⟨0⟩ = 0 := by
        rw [ratSubMul, hsub]
      cases (Rat.mul_eq_zero).mp hlin with
      | inl hdiff =>
        exact (ratSubEqZero hdiff).symm
      | inr hzero =>
        exact absurd hzero (Rat.ne_of_gt hpos0)
    exact ⟨hlam, heq, hpos0, hpos1⟩

theorem pair_unique_scale
    (M : Fin 2 → Fin 2 → Rat)
    (v w : Fin 2 → Rat)
    (lam : Rat)
    (hM : ∀ i j : Fin 2, 0 < M i j)
    (hv : ∀ i : Fin 2, 0 < v i)
    (hw : ∀ i : Fin 2, 0 < w i)
    (hMv : ∀ i : Fin 2, M i 0 * v 0 + M i 1 * v 1 = lam * v i)
    (hMw : ∀ i : Fin 2, M i 0 * w 0 + M i 1 * w 1 = lam * w i) :
    ∃ s : Rat, 0 < s ∧ ∀ i : Fin 2, v i = s * w i := by
  let r0 : Rat := v 0 / w 0
  let r1 : Rat := v 1 / w 1
  have hr0 : 0 < r0 := ratDivPos (hv 0) (hw 0)
  by_cases heq : r0 = r1
  · refine ⟨r0, hr0, ?_⟩
    intro i
    match i with
    | 0 =>
      exact (ratDivMulCancel (v 0) (w 0) (hw 0)).symm
    | 1 =>
      have hr : r0 = v 1 / w 1 := by
        simpa [r1] using heq
      rw [hr]
      exact (ratDivMulCancel (v 1) (w 1) (hw 1)).symm
  · exfalso
    have rowDiff (m0 m1 r v0 v1 w0 w1 : Rat)
        (hV : m0 * v0 + m1 * v1 = lam * v0)
        (hW : m0 * w0 + m1 * w1 = lam * w0) :
        m0 * (v0 - r * w0) + m1 * (v1 - r * w1) = lam * (v0 - r * w0) := by
      have hL :
          m0 * (v0 - r * w0) + m1 * (v1 - r * w1) =
            (m0 * v0 + m1 * v1) - (m0 * (r * w0) + m1 * (r * w1)) := by
        rw [ratMulSub, ratMulSub, ratSubAddSub]
      have hpull :
          m0 * (r * w0) + m1 * (r * w1) = r * (m0 * w0 + m1 * w1) := by
        rw [← ratMulAssocComm r m0 w0, ← ratMulAssocComm r m1 w1, ← Rat.mul_add]
      rw [hL, hpull, hV, hW, ratMulAssocComm r lam w0, ← ratMulSub]
    by_cases hlt : r0 < r1
    · have hd0 : v 0 - r0 * w 0 = 0 := by
        unfold r0
        rw [ratDivMulCancel (v 0) (w 0) (hw 0), Rat.sub_self]
      have hd1 : 0 < v 1 - r0 * w 1 := by
        rw [← Rat.lt_iff_sub_pos]
        have hr1 : r0 < v 1 / w 1 := by
          simpa [r1] using hlt
        exact (Rat.lt_div_iff (hw 1)).mp hr1
      have hdot :=
        rowDiff (M 0 0) (M 0 1) r0 (v 0) (v 1) (w 0) (w 1) (hMv 0) (hMw 0)
      rw [hd0, Rat.mul_zero, Rat.zero_add, Rat.mul_zero] at hdot
      exact Rat.ne_of_gt (ratMulPos (hM 0 1) hd1) hdot
    · have hgt : r1 < r0 := by
        have hle : r1 ≤ r0 := by
          cases Rat.le_total (a := r0) (b := r1) with
          | inl hle01 =>
            exact False.elim (heq (Rat.le_antisymm hle01 (Rat.not_lt.mp hlt)))
          | inr hle10 =>
            exact hle10
        exact Rat.lt_of_le_of_ne hle (Ne.symm heq)
      have hd1 : v 1 - r1 * w 1 = 0 := by
        unfold r1
        rw [ratDivMulCancel (v 1) (w 1) (hw 1), Rat.sub_self]
      have hd0 : 0 < v 0 - r1 * w 0 := by
        rw [← Rat.lt_iff_sub_pos]
        have hr0 : r1 < v 0 / w 0 := by
          simpa [r0] using hgt
        exact (Rat.lt_div_iff (hw 0)).mp hr0
      have hV : M 1 1 * v 1 + M 1 0 * v 0 = lam * v 1 := by
        rw [Rat.add_comm]
        exact hMv 1
      have hW : M 1 1 * w 1 + M 1 0 * w 0 = lam * w 1 := by
        rw [Rat.add_comm]
        exact hMw 1
      have hdot :=
        rowDiff (M 1 1) (M 1 0) r1 (v 1) (v 0) (w 1) (w 0) hV hW
      rw [hd1, Rat.mul_zero, Rat.zero_add, Rat.mul_zero] at hdot
      exact Rat.ne_of_gt (ratMulPos (hM 1 0) hd0) hdot

theorem chain_perron_unique : perronUniqueness exampleChain := by
  unfold perronUniqueness
  intro v w lam hv hw
  obtain ⟨_hlam, hvEq, hv0, _hv1⟩ := chain_equal_components v lam hv
  obtain ⟨_hmu, hwEq, hw0, _hw1⟩ := chain_equal_components w lam hw
  refine ⟨v ⟨0⟩ / w ⟨0⟩, ratDivPos hv0 hw0, ?_⟩
  intro n hn
  simp [exampleChain] at hn
  rcases hn with rfl | rfl
  · simp only [chainNode0]
    exact (ratDivMulCancel (v ⟨0⟩) (w ⟨0⟩) hw0).symm
  · simp only [chainNode1, hvEq.symm, hwEq.symm]
    exact (ratDivMulCancel (v ⟨0⟩) (w ⟨0⟩) hw0).symm

private theorem chain_step (a b : NodeId) (h : hasStep exampleChain a b) : a = ⟨0⟩ ∧ b = ⟨1⟩ := by
  unfold hasStep exampleChain at h
  obtain ⟨_e, he, hs, hd⟩ := h
  simp at he
  subst he
  unfold chainEdge at hs hd
  exact ⟨hs.symm, hd.symm⟩

theorem chain_no_cycle : workGraphHasNoDirectedCycle exampleChain := by
  intro w hw
  unfold isDirectedCycle at hw
  obtain ⟨hlen, hwalk, hends⟩ := hw
  match w with
  | [] =>
    simp at hlen
  | [a] =>
    simp at hlen
  | a :: b :: rest =>
    unfold isWalk at hwalk
    obtain ⟨hstep, hrest⟩ := hwalk
    obtain ⟨rfl, rfl⟩ := chain_step a b hstep
    match rest with
    | [] =>
      unfold endsMatch at hends
      simp at hends
    | c :: _more =>
      unfold isWalk at hrest
      obtain ⟨hstep2, _⟩ := hrest
      obtain ⟨hsrc, _⟩ := chain_step ⟨1⟩ c hstep2
      have hv : (1 : Nat) = 0 := congrArg NodeId.val hsrc
      cases hv

theorem loop_edge_01 : ∃ e ∈ exampleLoop.edges, e.src = ⟨0⟩ ∧ e.dst = ⟨1⟩ := by
  unfold exampleLoop
  exact ⟨chainEdge, by simp, rfl, rfl⟩

theorem loop_edge_10 : ∃ e ∈ exampleLoop.edges, e.src = ⟨1⟩ ∧ e.dst = ⟨0⟩ := by
  unfold exampleLoop
  exact ⟨loopEdgeBack, by simp, rfl, rfl⟩

theorem loop_is_cycle : isDirectedCycle exampleLoop loopWitnessWalk := by
  unfold isDirectedCycle
  refine ⟨?_, ?_, ?_⟩
  · unfold loopWitnessWalk
    decide
  · unfold loopWitnessWalk isWalk
    refine ⟨loop_edge_01, ?_⟩
    unfold isWalk
    refine ⟨loop_edge_10, ?_⟩
    unfold isWalk
    trivial
  · unfold endsMatch loopWitnessWalk
    rfl

theorem three_edge_kinds (k : EdgeKind) : edgeKindAllowed k := by
  cases k
  · exact Or.inl rfl
  · exact Or.inr (Or.inl rfl)
  · exact Or.inr (Or.inr rfl)

theorem fork_node_count : sharedPrereqGraph.nodes.length = 3 := by
  unfold sharedPrereqGraph
  rfl

private theorem matrixA_fork_form (i j : NodeId) :
    matrixA sharedPrereqGraph i j =
      (if leftDepends.src == i && leftDepends.dst == j then leftDepends.weight else 0) +
      (if rightDepends.src == i && rightDepends.dst == j then rightDepends.weight else 0) := by
  unfold matrixA sharedPrereqGraph
  simp only [List.foldl_cons, List.foldl_nil]
  cases h1 : (leftDepends.src == i && leftDepends.dst == j) <;>
    cases h2 : (rightDepends.src == i && rightDepends.dst == j) <;>
    simp [h1, h2, Rat.zero_add, Rat.add_zero]

private theorem matrixA_both_false (p q : Bool) (hp : p = false) (hq : q = false) :
    (if p then (1 : Rat) / 6 else 0) + (if q then (1 : Rat) / 6 else 0) = 0 := by
  rw [hp, hq]
  have hne : ¬ (false = true) := by decide
  rw [if_neg hne]
  exact Rat.zero_add 0

private theorem matrixA_left_only (q : Bool) (hq : q = false) :
    (if true then (1 : Rat) / 6 else 0) + (if q then (1 : Rat) / 6 else 0) = (1 : Rat) / 6 := by
  rw [hq]
  have ht : true = true := rfl
  have hne : ¬ (false = true) := by decide
  rw [if_pos ht, if_neg hne, Rat.add_zero]

private theorem matrixA_right_only (p : Bool) (hp : p = false) :
    (if p then (1 : Rat) / 6 else 0) + (if true then (1 : Rat) / 6 else 0) = (1 : Rat) / 6 := by
  rw [hp]
  have ht : true = true := rfl
  have hne : ¬ (false = true) := by decide
  rw [if_neg hne, if_pos ht, Rat.zero_add]

private theorem matrixA_at (i j : NodeId) : matrixA sharedPrereqGraph i j =
    (if (⟨1⟩ : NodeId) == i && (⟨0⟩ : NodeId) == j then (1 : Rat) / 6 else 0) +
    (if (⟨2⟩ : NodeId) == i && (⟨0⟩ : NodeId) == j then (1 : Rat) / 6 else 0) := by
  rw [matrixA_fork_form]
  unfold leftDepends rightDepends
  rfl

private theorem matrixA_fork_nonneg (i j : NodeId) : 0 ≤ matrixA sharedPrereqGraph i j := by
  rw [matrixA_at]
  cases hL : ((⟨1⟩ : NodeId) == i && (⟨0⟩ : NodeId) == j) <;>
    cases hR : ((⟨2⟩ : NodeId) == i && (⟨0⟩ : NodeId) == j)
  · have hne : ¬ (false = true) := by decide
    rw [if_neg hne, Rat.zero_add]
    exact Rat.le_refl
  · have hne : ¬ (false = true) := by decide
    have ht : true = true := rfl
    rw [if_neg hne, if_pos ht, Rat.zero_add]
    exact ratNatDivNonneg 1 6 (by decide) (by decide)
  · have ht : true = true := rfl
    have hne : ¬ (false = true) := by decide
    rw [if_pos ht, if_neg hne, Rat.add_zero]
    exact ratNatDivNonneg 1 6 (by decide) (by decide)
  · exact ratAddNonneg (ratNatDivNonneg 1 6 (by decide) (by decide))
      (ratNatDivNonneg 1 6 (by decide) (by decide))

theorem matrixA_fork_00 : matrixA sharedPrereqGraph ⟨0⟩ ⟨0⟩ = 0 := by
  rw [matrixA_at]
  exact matrixA_both_false _ _ (by decide) (by decide)

theorem matrixA_fork_01 : matrixA sharedPrereqGraph ⟨0⟩ ⟨1⟩ = 0 := by
  rw [matrixA_at]
  exact matrixA_both_false _ _ (by decide) (by decide)

theorem matrixA_fork_02 : matrixA sharedPrereqGraph ⟨0⟩ ⟨2⟩ = 0 := by
  rw [matrixA_at]
  exact matrixA_both_false _ _ (by decide) (by decide)

theorem matrixA_fork_10 : matrixA sharedPrereqGraph ⟨1⟩ ⟨0⟩ = (1 / 6 : Rat) := by
  rw [matrixA_at]
  have hL : ((⟨1⟩ : NodeId) == ⟨1⟩ && (⟨0⟩ : NodeId) == ⟨0⟩) = true := by decide
  rw [hL]
  exact matrixA_left_only _ (by decide)

theorem matrixA_fork_11 : matrixA sharedPrereqGraph ⟨1⟩ ⟨1⟩ = 0 := by
  rw [matrixA_at]
  exact matrixA_both_false _ _ (by decide) (by decide)

theorem matrixA_fork_12 : matrixA sharedPrereqGraph ⟨1⟩ ⟨2⟩ = 0 := by
  rw [matrixA_at]
  exact matrixA_both_false _ _ (by decide) (by decide)

theorem matrixA_fork_20 : matrixA sharedPrereqGraph ⟨2⟩ ⟨0⟩ = (1 / 6 : Rat) := by
  rw [matrixA_at]
  have hL : ((⟨1⟩ : NodeId) == ⟨2⟩ && (⟨0⟩ : NodeId) == ⟨0⟩) = false := by decide
  have hR : ((⟨2⟩ : NodeId) == ⟨2⟩ && (⟨0⟩ : NodeId) == ⟨0⟩) = true := by decide
  rw [hR]
  exact matrixA_right_only _ hL

theorem matrixA_fork_21 : matrixA sharedPrereqGraph ⟨2⟩ ⟨1⟩ = 0 := by
  rw [matrixA_at]
  exact matrixA_both_false _ _ (by decide) (by decide)

theorem matrixA_fork_22 : matrixA sharedPrereqGraph ⟨2⟩ ⟨2⟩ = 0 := by
  rw [matrixA_at]
  exact matrixA_both_false _ _ (by decide) (by decide)

private theorem matrixB_fork_at (i j : NodeId) (a : Rat) (ha : matrixA sharedPrereqGraph i j = a) :
    matrixB sharedPrereqGraph i j = (1 - alpha) * a + alpha / (3 : Rat) := by
  unfold matrixB matrixBWith
  rw [ha, fork_node_count]
  rfl

private theorem matrixB_when (i j : NodeId) (a expected : Rat)
    (ha : matrixA sharedPrereqGraph i j = a)
    (he : (1 - alpha) * a + alpha / (3 : Rat) = expected) :
    matrixB sharedPrereqGraph i j = expected := by
  rw [matrixB_fork_at i j a ha, he]

private theorem dampZeroToFifteenth :
    (1 - alpha) * (0 : Rat) + alpha / (3 : Rat) = (1 / 15 : Rat) := by
  unfold alpha
  rw [Rat.mul_zero, Rat.zero_add, ratDivDiv]
  simp only [← Rat.natCast_ofNat]
  rw [← Rat.natCast_mul]

private theorem dampSixthToFifth :
    (1 - alpha) * ((1 : Rat) / 6) + alpha / (3 : Rat) = (1 / 5 : Rat) := by
  rw [oneMinusAlpha]
  unfold alpha
  simp only [← Rat.natCast_ofNat]
  rw [ratMulDivDiv]
  have hn : (4 * 1 : Nat) = 4 := by decide
  have hd : (5 * 6 : Nat) = 30 := by decide
  rw [hn, hd, ratDivDiv, ← Rat.natCast_mul]
  have h53 : (5 * 3 : Nat) = 15 := by decide
  rw [h53]
  simp only [Rat.natCast_ofNat]
  have hswap : (1 : Rat) / (15 : Rat) = (2 : Rat) / (30 : Rat) :=
    ratNatDivEq 1 15 2 30 (by decide) (by decide) (by decide)
  rw [hswap]
  have hadd : (4 : Rat) / (30 : Rat) + (2 : Rat) / (30 : Rat) = (6 : Rat) / (30 : Rat) := by
    have h42 : (4 + 2 : Nat) = 6 := by decide
    simpa [Rat.natCast_ofNat, h42] using ratAddDivNat 4 2 30
  rw [hadd]
  exact ratNatDivEq 6 30 1 5 (by decide) (by decide) (by decide)

theorem matrixB_fork_00 : matrixB sharedPrereqGraph ⟨0⟩ ⟨0⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨0⟩ ⟨0⟩ 0 (1 / 15) matrixA_fork_00 dampZeroToFifteenth

theorem matrixB_fork_01 : matrixB sharedPrereqGraph ⟨0⟩ ⟨1⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨0⟩ ⟨1⟩ 0 (1 / 15) matrixA_fork_01 dampZeroToFifteenth

theorem matrixB_fork_02 : matrixB sharedPrereqGraph ⟨0⟩ ⟨2⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨0⟩ ⟨2⟩ 0 (1 / 15) matrixA_fork_02 dampZeroToFifteenth

theorem matrixB_fork_10 : matrixB sharedPrereqGraph ⟨1⟩ ⟨0⟩ = (1 / 5 : Rat) :=
  matrixB_when ⟨1⟩ ⟨0⟩ ((1 : Rat) / 6) (1 / 5) matrixA_fork_10 dampSixthToFifth

theorem matrixB_fork_11 : matrixB sharedPrereqGraph ⟨1⟩ ⟨1⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨1⟩ ⟨1⟩ 0 (1 / 15) matrixA_fork_11 dampZeroToFifteenth

theorem matrixB_fork_12 : matrixB sharedPrereqGraph ⟨1⟩ ⟨2⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨1⟩ ⟨2⟩ 0 (1 / 15) matrixA_fork_12 dampZeroToFifteenth

theorem matrixB_fork_20 : matrixB sharedPrereqGraph ⟨2⟩ ⟨0⟩ = (1 / 5 : Rat) :=
  matrixB_when ⟨2⟩ ⟨0⟩ ((1 : Rat) / 6) (1 / 5) matrixA_fork_20 dampSixthToFifth

theorem matrixB_fork_21 : matrixB sharedPrereqGraph ⟨2⟩ ⟨1⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨2⟩ ⟨1⟩ 0 (1 / 15) matrixA_fork_21 dampZeroToFifteenth

theorem matrixB_fork_22 : matrixB sharedPrereqGraph ⟨2⟩ ⟨2⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨2⟩ ⟨2⟩ 0 (1 / 15) matrixA_fork_22 dampZeroToFifteenth

theorem applyB_fork (v : NodeId → Rat) (i : NodeId) :
    applyB sharedPrereqGraph v i =
      matrixB sharedPrereqGraph i ⟨0⟩ * v ⟨0⟩ +
      matrixB sharedPrereqGraph i ⟨1⟩ * v ⟨1⟩ +
      matrixB sharedPrereqGraph i ⟨2⟩ * v ⟨2⟩ := by
  unfold applyB sharedPrereqGraph
  simp only [List.foldl_cons, List.foldl_nil]
  unfold prereqNode leftNode rightNode
  simp only [Rat.zero_add]

def forkVec : NodeId → Rat
  | ⟨0⟩ => 2
  | ⟨1⟩ => 3
  | ⟨2⟩ => 3
  | _ => 1

private theorem fork_len0 : 0 < sharedPrereqGraph.nodes.length := by
  rw [fork_node_count]
  decide

private theorem fork_len1 : 1 < sharedPrereqGraph.nodes.length := by
  rw [fork_node_count]
  decide

private theorem fork_len2 : 2 < sharedPrereqGraph.nodes.length := by
  rw [fork_node_count]
  decide

private theorem fork_id0 : (sharedPrereqGraph.nodes[0]'fork_len0).id = ⟨0⟩ := by
  unfold sharedPrereqGraph prereqNode
  rfl

private theorem fork_id1 : (sharedPrereqGraph.nodes[1]'fork_len1).id = ⟨1⟩ := by
  unfold sharedPrereqGraph leftNode
  rfl

private theorem fork_id2 : (sharedPrereqGraph.nodes[2]'fork_len2).id = ⟨2⟩ := by
  unfold sharedPrereqGraph rightNode
  rfl

private theorem oneFifteenthMul (k : Nat) :
    (1 / 15 : Rat) * (k : Rat) = (k : Rat) / 15 := by
  rw [Rat.mul_comm]
  simp only [← Rat.natCast_ofNat]
  rw [ratMulNatDiv k 1 15 (by decide)]
  have h : (k * 1 : Nat) = k := Nat.mul_one k
  rw [h]

private theorem forkRowZero :
    (1 / 15 : Rat) * (2 : Rat) + (1 / 15 : Rat) * (3 : Rat) + (1 / 15 : Rat) * (3 : Rat) =
      (4 / 15 : Rat) * (2 : Rat) := by
  rw [← Rat.natCast_ofNat (a := 2), ← Rat.natCast_ofNat (a := 3)]
  rw [oneFifteenthMul 2, oneFifteenthMul 3, ratAddDiv]
  have h23 : (2 + 3 : Nat) = 5 := by decide
  rw [← Rat.natCast_add, h23, ratAddDiv]
  have h53 : (5 + 3 : Nat) = 8 := by decide
  rw [← Rat.natCast_add, h53, Rat.mul_comm]
  simp only [← Rat.natCast_ofNat]
  rw [ratMulNatDiv 2 4 15 (by decide)]

private theorem forkRowSide :
    (1 / 5 : Rat) * (2 : Rat) + (1 / 15 : Rat) * (3 : Rat) + (1 / 15 : Rat) * (3 : Rat) =
      (4 / 15 : Rat) * (3 : Rat) := by
  rw [← Rat.natCast_ofNat (a := 2), ← Rat.natCast_ofNat (a := 3)]
  rw [oneFifteenthMul 3]
  have hleft : (1 / 5 : Rat) * ((2 : Nat) : Rat) = ((2 : Nat) : Rat) / 5 := by
    rw [Rat.mul_comm, ← Rat.natCast_ofNat (a := 1), ← Rat.natCast_ofNat (a := 5),
      ratMulNatDiv 2 1 5 (by decide)]
  rw [hleft]
  have h25 : ((2 : Nat) : Rat) / 5 = ((6 : Nat) : Rat) / 15 := by
    rw [← Rat.natCast_ofNat (a := 5), ← Rat.natCast_ofNat (a := 15)]
    exact ratNatDivEq 2 5 6 15 (by decide) (by decide) (by decide)
  rw [h25, ratAddDiv, ratAddDiv]
  have h63 : (6 + 3 : Nat) = 9 := by decide
  have h93 : (9 + 3 : Nat) = 12 := by decide
  rw [← Rat.natCast_add, h63, ← Rat.natCast_add, h93, Rat.mul_comm]
  simp only [← Rat.natCast_ofNat]
  rw [ratMulNatDiv 3 4 15 (by decide)]

theorem fork_eigenvector : isPositiveEigenvector sharedPrereqGraph forkVec (4 / 15) := by
  unfold isPositiveEigenvector positiveOnNodes
  constructor
  · intro n hn
    simp [sharedPrereqGraph] at hn
    rcases hn with rfl | rfl | rfl
    · unfold prereqNode forkVec
      exact Rat.natCast_pos.mpr (by decide)
    · unfold leftNode forkVec
      exact Rat.natCast_pos.mpr (by decide)
    · unfold rightNode forkVec
      exact Rat.natCast_pos.mpr (by decide)
  · intro n hn
    simp [sharedPrereqGraph] at hn
    rcases hn with rfl | rfl | rfl
    · unfold prereqNode
      rw [applyB_fork, matrixB_fork_00, matrixB_fork_01, matrixB_fork_02]
      unfold forkVec
      exact forkRowZero
    · unfold leftNode
      rw [applyB_fork, matrixB_fork_10, matrixB_fork_11, matrixB_fork_12]
      unfold forkVec
      exact forkRowSide
    · unfold rightNode
      rw [applyB_fork, matrixB_fork_20, matrixB_fork_21, matrixB_fork_22]
      unfold forkVec
      exact forkRowSide

private theorem fifteenMulOneFifteenth : (15 : Rat) * ((1 : Rat) / 15) = 1 := by
  rw [Rat.mul_comm]
  simp only [← Rat.natCast_ofNat]
  have hb : (0 : Rat) < (15 : Rat) / ((OfNat.ofNat 1 : Nat) : Rat) := by
    rw [Rat.natCast_ofNat (a := 1)]
    exact ratDivPos (ratNatCastPos 15 (by decide)) (ratNatCastPos 1 (by decide))
  rw [← ratNatOverOne 15, ← Rat.natCast_ofNat (a := 1)]
  exact ratDivMulCancel (1 : Rat) ((15 : Rat) / ((OfNat.ofNat 1 : Nat) : Rat)) hb

private theorem fifteenMulTwoFifteenth : (15 : Rat) * ((2 : Rat) / 15) = 2 := by
  rw [Rat.mul_comm]
  simp only [← Rat.natCast_ofNat]
  have hb : (0 : Rat) < (15 : Rat) / ((OfNat.ofNat 1 : Nat) : Rat) := by
    rw [Rat.natCast_ofNat (a := 1)]
    exact ratDivPos (ratNatCastPos 15 (by decide)) (ratNatCastPos 1 (by decide))
  rw [← ratNatOverOne 15, ← Rat.natCast_ofNat (a := 1)]
  exact ratDivMulCancel (2 : Rat) ((15 : Rat) / ((OfNat.ofNat 1 : Nat) : Rat)) hb

private theorem fifteenMulOneFifth : (15 : Rat) * ((1 : Rat) / 5) = 3 := by
  rw [Rat.mul_comm]
  simp only [← Rat.natCast_ofNat]
  rw [← ratNatOverOne 15, ← Rat.natCast_ofNat (a := 1), ratMulDivDiv]
  have hn : (1 * 15 : Nat) = 15 := by decide
  have hd : (5 * 1 : Nat) = 5 := by decide
  rw [hn, hd]
  have h15 : (15 : Nat) = 3 * 5 := by decide
  rw [h15]
  exact ratMulDivCancelNat 3 5 (by decide)

private theorem scaledCross (a b : Rat) :
    (15 : Rat) *
        (b * ((1 / 15 : Rat) * a + (2 / 15 : Rat) * b) -
          a * ((1 / 5 : Rat) * a + (2 / 15 : Rat) * b)) =
      b * (a + (2 : Rat) * b) - a * ((3 : Rat) * a + (2 : Rat) * b) := by
  have hX :
      (15 : Rat) * ((1 / 15 : Rat) * a + (2 / 15 : Rat) * b) =
        a + (2 : Rat) * b := by
    rw [Rat.mul_add, ← Rat.mul_assoc, ← Rat.mul_assoc, fifteenMulOneFifteenth,
      fifteenMulTwoFifteenth, Rat.one_mul]
  have hY :
      (15 : Rat) * ((1 / 5 : Rat) * a + (2 / 15 : Rat) * b) =
        (3 : Rat) * a + (2 : Rat) * b := by
    rw [Rat.mul_add, ← Rat.mul_assoc, ← Rat.mul_assoc, fifteenMulOneFifth, fifteenMulTwoFifteenth]
  rw [ratMulSub, ratMulAssocComm, hX, ratMulAssocComm, hY]

private theorem ratTwoSubOne (z : Rat) : (2 : Rat) * z - z = z := by
  have h2 : (2 : Rat) = 1 + 1 := by
    have hnat : (2 : Nat) = 1 + 1 := by decide
    rewrite [← Rat.natCast_ofNat (a := 2), congrArg (fun n : Nat => (n : Rat)) hnat,
      Rat.natCast_add, Rat.natCast_ofNat (a := 1)]
    rfl
  rw [h2, Rat.add_mul, Rat.one_mul, Rat.add_sub_cancel]

private theorem ratOneSubTwo (z : Rat) : z - (2 : Rat) * z = -z := by
  have h := congrArg Neg.neg (ratTwoSubOne z)
  rw [Rat.neg_sub] at h
  exact h

private theorem subComm (x y z : Rat) : x - y - z = x - z - y := by
  rw [Rat.sub_eq_add_neg, Rat.sub_eq_add_neg, Rat.sub_eq_add_neg, Rat.sub_eq_add_neg,
    Rat.add_assoc, Rat.add_comm (-y) (-z), ← Rat.add_assoc]

private theorem rearrangePoly (A B C : Rat) :
    (B + C) - A - ((2 : Rat) * B) = -((A + B) - C) := by
  rw [Rat.add_comm B C, subComm]
  have hpull : (C + B) - (2 : Rat) * B = C + (B - (2 : Rat) * B) := by
    rw [Rat.sub_eq_add_neg, Rat.sub_eq_add_neg, Rat.add_assoc]
  rw [hpull, ratOneSubTwo, ← Rat.sub_eq_add_neg, subComm, ← ratSubAdd, ← Rat.neg_sub]

private theorem expandCross (a b : Rat) :
    b * (a + (2 : Rat) * b) - a * ((3 : Rat) * a + (2 : Rat) * b) =
      -((3 : Rat) * a * a + a * b - (2 : Rat) * b * b) := by
  rw [Rat.mul_add, Rat.mul_add, Rat.mul_comm b a, ← Rat.mul_assoc b (2 : Rat) b,
    Rat.mul_comm b (2 : Rat), ← Rat.mul_assoc a (3 : Rat) a, Rat.mul_comm a (3 : Rat),
    ← Rat.mul_assoc a (2 : Rat) b, Rat.mul_comm a (2 : Rat), Rat.mul_assoc (2 : Rat) a b,
    ratSubAdd]
  exact rearrangePoly ((3 : Rat) * a * a) (a * b) ((2 : Rat) * b * b)

private theorem ratAddSubPull (x y w : Rat) : x + y - w = x + (y - w) := by
  rw [Rat.sub_eq_add_neg, Rat.sub_eq_add_neg, Rat.add_assoc]

private theorem forkQuadFactor (a b : Rat) :
    ((3 : Rat) * a - (2 : Rat) * b) * (a + b) =
      (3 : Rat) * a * a + a * b - (2 : Rat) * b * b := by
  rw [ratSubMul, Rat.mul_add, Rat.mul_add, ratSubAdd, Rat.mul_assoc (3 : Rat) a b,
    Rat.mul_assoc (2 : Rat) b a, Rat.mul_comm b a, ratAddSubPull, ratThreeSubTwo]

theorem fork_equal_components (v : NodeId → Rat) (lam : Rat)
    (hv : isPositiveEigenvector sharedPrereqGraph v lam) :
    lam = (4 / 15 : Rat) ∧ v ⟨1⟩ = v ⟨2⟩ ∧ v ⟨0⟩ = (2 / 3 : Rat) * v ⟨1⟩ ∧
      0 < v ⟨0⟩ ∧ 0 < v ⟨1⟩ ∧ 0 < v ⟨2⟩ := by
  unfold isPositiveEigenvector positiveOnNodes at hv
  obtain ⟨hpos, happ⟩ := hv
  have hmem0 : sharedPrereqGraph.nodes[0] ∈ sharedPrereqGraph.nodes :=
    List.getElem_mem fork_len0
  have hmem1 : sharedPrereqGraph.nodes[1] ∈ sharedPrereqGraph.nodes :=
    List.getElem_mem fork_len1
  have hmem2 : sharedPrereqGraph.nodes[2] ∈ sharedPrereqGraph.nodes :=
    List.getElem_mem fork_len2
  have happ0 := happ _ hmem0
  have happ1 := happ _ hmem1
  have happ2 := happ _ hmem2
  rw [fork_id0, applyB_fork, matrixB_fork_00, matrixB_fork_01, matrixB_fork_02] at happ0
  rw [fork_id1, applyB_fork, matrixB_fork_10, matrixB_fork_11, matrixB_fork_12] at happ1
  rw [fork_id2, applyB_fork, matrixB_fork_20, matrixB_fork_21, matrixB_fork_22] at happ2
  have hx : 0 < v ⟨0⟩ := by
    simpa [fork_id0] using hpos _ hmem0
  have hy : 0 < v ⟨1⟩ := by
    simpa [fork_id1] using hpos _ hmem1
  have hz : 0 < v ⟨2⟩ := by
    simpa [fork_id2] using hpos _ hmem2
  have hsame : lam * v ⟨1⟩ = lam * v ⟨2⟩ :=
    happ1.symm.trans happ2
  have hsplit : lam = 0 ∨ v ⟨1⟩ = v ⟨2⟩ := by
    have hzero : lam * v ⟨1⟩ - lam * v ⟨2⟩ = 0 := by
      rw [hsame, Rat.sub_self]
    have hfacLam : lam * (v ⟨1⟩ - v ⟨2⟩) = 0 := by
      rw [ratMulSub, hzero]
    cases (Rat.mul_eq_zero).mp hfacLam with
    | inl hlam0 =>
      exact Or.inl hlam0
    | inr hdiff =>
      exact Or.inr (ratSubEqZero hdiff)
  have hfifteenth : (0 : Rat) < (1 / 15 : Rat) :=
    ratNatDivPos 1 15 (by decide) (by decide)
  have hsum : 0 < (1 / 15 : Rat) * v ⟨0⟩ + (1 / 15 : Rat) * v ⟨1⟩ + (1 / 15 : Rat) * v ⟨2⟩ := by
    have h01 : 0 < (1 / 15 : Rat) * v ⟨0⟩ + (1 / 15 : Rat) * v ⟨1⟩ :=
      ratAddPosOfNonnegOfPos (Rat.le_of_lt (Rat.mul_pos hfifteenth hx)) (Rat.mul_pos hfifteenth hy)
    exact ratAddPosOfNonnegOfPos (Rat.le_of_lt h01) (Rat.mul_pos hfifteenth hz)
  cases hsplit with
  | inl hlam0 =>
    exfalso
    rw [hlam0, Rat.mul_comm (0 : Rat) (v ⟨0⟩), Rat.mul_zero] at happ0
    exact Rat.ne_of_gt hsum happ0
  | inr hyz =>
    have htwice :
        (1 / 15 : Rat) * v ⟨1⟩ + (1 / 15 : Rat) * v ⟨1⟩ = (2 / 15 : Rat) * v ⟨1⟩ := by
      rw [← Rat.add_mul]
      have htwo : (1 / 15 : Rat) + (1 / 15 : Rat) = (2 : Rat) / 15 := by
        simp only [← Rat.natCast_ofNat]
        rw [ratAddDivNat 1 1 15]
      rw [htwo]
    have h0 : (1 / 15 : Rat) * v ⟨0⟩ + (2 / 15 : Rat) * v ⟨1⟩ = lam * v ⟨0⟩ := by
      rw [← hyz, Rat.add_assoc, htwice] at happ0
      exact happ0
    have h1 : (1 / 5 : Rat) * v ⟨0⟩ + (2 / 15 : Rat) * v ⟨1⟩ = lam * v ⟨1⟩ := by
      rw [← hyz, Rat.add_assoc, htwice] at happ1
      exact happ1
    have hcross :
        v ⟨1⟩ * ((1 / 15 : Rat) * v ⟨0⟩ + (2 / 15 : Rat) * v ⟨1⟩) =
          v ⟨0⟩ * ((1 / 5 : Rat) * v ⟨0⟩ + (2 / 15 : Rat) * v ⟨1⟩) := by
      rw [h0, h1]
      calc
        v ⟨1⟩ * (lam * v ⟨0⟩) = (v ⟨1⟩ * lam) * v ⟨0⟩ := (Rat.mul_assoc (v ⟨1⟩) lam (v ⟨0⟩)).symm
        _ = (lam * v ⟨1⟩) * v ⟨0⟩ := by rw [Rat.mul_comm (v ⟨1⟩) lam]
        _ = lam * (v ⟨1⟩ * v ⟨0⟩) := Rat.mul_assoc lam (v ⟨1⟩) (v ⟨0⟩)
        _ = lam * (v ⟨0⟩ * v ⟨1⟩) := by rw [Rat.mul_comm (v ⟨1⟩) (v ⟨0⟩)]
        _ = (lam * v ⟨0⟩) * v ⟨1⟩ := (Rat.mul_assoc lam (v ⟨0⟩) (v ⟨1⟩)).symm
        _ = (v ⟨0⟩ * lam) * v ⟨1⟩ := by rw [Rat.mul_comm lam (v ⟨0⟩)]
        _ = v ⟨0⟩ * (lam * v ⟨1⟩) := Rat.mul_assoc (v ⟨0⟩) lam (v ⟨1⟩)
    have hdiff :
        v ⟨1⟩ * ((1 / 15 : Rat) * v ⟨0⟩ + (2 / 15 : Rat) * v ⟨1⟩) -
          v ⟨0⟩ * ((1 / 5 : Rat) * v ⟨0⟩ + (2 / 15 : Rat) * v ⟨1⟩) = 0 := by
      rw [hcross, Rat.sub_self]
    have hscaled0 :
        (15 : Rat) *
            (v ⟨1⟩ * ((1 / 15 : Rat) * v ⟨0⟩ + (2 / 15 : Rat) * v ⟨1⟩) -
              v ⟨0⟩ * ((1 / 5 : Rat) * v ⟨0⟩ + (2 / 15 : Rat) * v ⟨1⟩)) = 0 := by
      rw [hdiff, Rat.mul_zero]
    have hscaled :
        v ⟨1⟩ * (v ⟨0⟩ + (2 : Rat) * v ⟨1⟩) -
          v ⟨0⟩ * ((3 : Rat) * v ⟨0⟩ + (2 : Rat) * v ⟨1⟩) = 0 := by
      rw [← scaledCross (v ⟨0⟩) (v ⟨1⟩), hscaled0]
    have hnegQuad :
        -((3 : Rat) * v ⟨0⟩ * v ⟨0⟩ + v ⟨0⟩ * v ⟨1⟩ - (2 : Rat) * v ⟨1⟩ * v ⟨1⟩) = 0 := by
      rw [← expandCross (v ⟨0⟩) (v ⟨1⟩)]
      exact hscaled
    have hpoly :
        (3 : Rat) * v ⟨0⟩ * v ⟨0⟩ + v ⟨0⟩ * v ⟨1⟩ - (2 : Rat) * v ⟨1⟩ * v ⟨1⟩ = 0 := by
      have h := congrArg
        (fun x => x + ((3 : Rat) * v ⟨0⟩ * v ⟨0⟩ + v ⟨0⟩ * v ⟨1⟩ - (2 : Rat) * v ⟨1⟩ * v ⟨1⟩))
        hnegQuad
      rw [Rat.add_comm (-((3 : Rat) * v ⟨0⟩ * v ⟨0⟩ + v ⟨0⟩ * v ⟨1⟩ - (2 : Rat) * v ⟨1⟩ * v ⟨1⟩))
          ((3 : Rat) * v ⟨0⟩ * v ⟨0⟩ + v ⟨0⟩ * v ⟨1⟩ - (2 : Rat) * v ⟨1⟩ * v ⟨1⟩),
        ← Rat.sub_eq_add_neg, Rat.sub_self, Rat.zero_add] at h
      exact h.symm
    have hfac : ((3 : Rat) * v ⟨0⟩ - (2 : Rat) * v ⟨1⟩) * (v ⟨0⟩ + v ⟨1⟩) = 0 := by
      rw [forkQuadFactor, hpoly]
    have hsumpos : v ⟨0⟩ + v ⟨1⟩ ≠ 0 :=
      Rat.ne_of_gt (ratAddPosOfNonnegOfPos (Rat.le_of_lt hx) hy)
    have hlin : (3 : Rat) * v ⟨0⟩ - (2 : Rat) * v ⟨1⟩ = 0 := by
      have hprod :
          ((3 : Rat) * v ⟨0⟩ - (2 : Rat) * v ⟨1⟩) * (v ⟨0⟩ + v ⟨1⟩) =
            (0 : Rat) * (v ⟨0⟩ + v ⟨1⟩) := by
        rw [Rat.mul_comm (0 : Rat) (v ⟨0⟩ + v ⟨1⟩), Rat.mul_zero]
        exact hfac
      exact ratMulRightCancel hsumpos hprod
    have hxratio : v ⟨0⟩ = (2 / 3 : Rat) * v ⟨1⟩ := by
      have heq3 : (3 : Rat) * v ⟨0⟩ = (2 : Rat) * v ⟨1⟩ := ratSubEqZero hlin
      have hdiv3 := congrArg (fun x => x / (3 : Rat)) heq3
      rw [Rat.mul_comm (3 : Rat) (v ⟨0⟩), Rat.mul_div_cancel (by simpa [Rat.natCast_ofNat] using ratCastNeZero 3 (by decide))] at hdiv3
      have hmove : (2 : Rat) * v ⟨1⟩ / (3 : Rat) = (2 / 3 : Rat) * v ⟨1⟩ := by
        rw [Rat.div_def, Rat.div_def, Rat.mul_assoc, Rat.mul_comm (v ⟨1⟩) ((3 : Rat)⁻¹), ←
          Rat.mul_assoc]
      rw [hmove] at hdiv3
      exact hdiv3
    have hlam : lam = (4 / 15 : Rat) := by
      have hsub := h0
      rw [hxratio] at hsub
      have hcoef :
          (1 / 15 : Rat) * ((2 / 3 : Rat) * v ⟨1⟩) + (2 / 15 : Rat) * v ⟨1⟩ =
            (4 / 15 : Rat) * ((2 / 3 : Rat) * v ⟨1⟩) := by
        rw [← Rat.mul_assoc (1 / 15 : Rat) (2 / 3 : Rat) (v ⟨1⟩),
          ← Rat.mul_assoc (4 / 15 : Rat) (2 / 3 : Rat) (v ⟨1⟩), ← Rat.add_mul]
        have hleft : (1 / 15 : Rat) * (2 / 3 : Rat) = (2 : Rat) / 45 := by
          simp only [← Rat.natCast_ofNat]
          rw [ratMulDivDiv]
        have hright : (4 / 15 : Rat) * (2 / 3 : Rat) = (8 : Rat) / 45 := by
          simp only [← Rat.natCast_ofNat]
          rw [ratMulDivDiv]
        have h215 : (2 / 15 : Rat) = (6 : Rat) / 45 :=
          ratNatDivEq 2 15 6 45 (by decide) (by decide) (by decide : (2 * 45 : Nat) = 6 * 15)
        have h26 : (2 + 6 : Nat) = 8 := by decide
        rw [hleft, h215, hright]
        simp only [← Rat.natCast_ofNat]
        rw [ratAddDivNat, h26]
      rw [hcoef] at hsub
      have hfacScale : ((4 / 15 : Rat) - lam) * ((2 / 3 : Rat) * v ⟨1⟩) = 0 := by
        have hzero :
            (4 / 15 : Rat) * ((2 / 3 : Rat) * v ⟨1⟩) - lam * ((2 / 3 : Rat) * v ⟨1⟩) = 0 := by
          rw [hsub, Rat.sub_self]
        rw [ratSubMul, hzero]
      have hposScale : (2 / 3 : Rat) * v ⟨1⟩ ≠ 0 :=
        Rat.ne_of_gt (Rat.mul_pos (ratNatDivPos 2 3 (by decide) (by decide)) hy)
      cases (Rat.mul_eq_zero).mp hfacScale with
      | inl hdiff =>
        exact (ratSubEqZero hdiff).symm
      | inr hzero =>
        exact absurd hzero hposScale
    exact ⟨hlam, hyz, hxratio, hx, hy, hz⟩

theorem fork_perron_unique : perronUniqueness sharedPrereqGraph := by
  unfold perronUniqueness
  intro v w lam hv hw
  obtain ⟨_, hv12, hv0, _, hvpos1, _⟩ := fork_equal_components v lam hv
  obtain ⟨_, hw12, hw0, _, hwpos1, _⟩ := fork_equal_components w lam hw
  refine ⟨v ⟨1⟩ / w ⟨1⟩, ratDivPos hvpos1 hwpos1, ?_⟩
  intro n hn
  simp [sharedPrereqGraph] at hn
  rcases hn with rfl | rfl | rfl
  · unfold prereqNode
    rw [hv0, hw0, ratMulAssocComm (v ⟨1⟩ / w ⟨1⟩) (2 / 3 : Rat) (w ⟨1⟩),
      ratDivMulCancel (v ⟨1⟩) (w ⟨1⟩) hwpos1]
  · unfold leftNode
    exact (ratDivMulCancel (v ⟨1⟩) (w ⟨1⟩) hwpos1).symm
  · unfold rightNode
    rw [← hv12, ← hw12]
    exact (ratDivMulCancel (v ⟨1⟩) (w ⟨1⟩) hwpos1).symm

theorem fork_entryPositive : entryPositive sharedPrereqGraph := by
  intro n1 _hn1 n2 _hn2
  exact damp_entry_pos (matrixA sharedPrereqGraph n1.id n2.id) sharedPrereqGraph.nodes.length
    (matrixA_fork_nonneg n1.id n2.id) (by rw [fork_node_count]; decide)

theorem fork_bNonneg : bNonnegative sharedPrereqGraph := by
  intro n1 hn1 n2 hn2
  unfold matrixB matrixBWith
  exact Rat.le_of_lt (fork_entryPositive n1 hn1 n2 hn2)

private theorem fork_step (a b : NodeId) (h : hasStep sharedPrereqGraph a b) :
    (a = ⟨1⟩ ∧ b = ⟨0⟩) ∨ (a = ⟨2⟩ ∧ b = ⟨0⟩) := by
  unfold hasStep sharedPrereqGraph at h
  obtain ⟨_e, he, hs, hd⟩ := h
  simp at he
  rcases he with rfl | rfl
  · unfold leftDepends at hs hd
    exact Or.inl ⟨hs.symm, hd.symm⟩
  · unfold rightDepends at hs hd
    exact Or.inr ⟨hs.symm, hd.symm⟩

theorem fork_no_cycle : workGraphHasNoDirectedCycle sharedPrereqGraph := by
  intro w hw
  unfold isDirectedCycle at hw
  obtain ⟨hlen, hwalk, hends⟩ := hw
  match w with
  | [] =>
    simp at hlen
  | [_] =>
    simp at hlen
  | a :: b :: rest =>
    unfold isWalk at hwalk
    obtain ⟨hstep, hrest⟩ := hwalk
    rcases fork_step a b hstep with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · match rest with
      | [] =>
        unfold endsMatch at hends
        simp at hends
      | c :: _more =>
        unfold isWalk at hrest
        obtain ⟨hstep2, _⟩ := hrest
        rcases fork_step ⟨0⟩ c hstep2 with ⟨hsrc, _⟩ | ⟨hsrc, _⟩
        · have hv : (0 : Nat) = 1 := congrArg NodeId.val hsrc
          cases hv
        · have hv : (0 : Nat) = 2 := congrArg NodeId.val hsrc
          cases hv
    · match rest with
      | [] =>
        unfold endsMatch at hends
        simp at hends
      | c :: _more =>
        unfold isWalk at hrest
        obtain ⟨hstep2, _⟩ := hrest
        rcases fork_step ⟨0⟩ c hstep2 with ⟨hsrc, _⟩ | ⟨hsrc, _⟩
        · have hv : (0 : Nat) = 1 := congrArg NodeId.val hsrc
          cases hv
        · have hv : (0 : Nat) = 2 := congrArg NodeId.val hsrc
          cases hv

theorem fork_shared : hasSharedPrerequisite sharedPrereqGraph := by
  unfold hasSharedPrerequisite isSharedPrerequisite
  refine ⟨⟨0⟩, ⟨1⟩, ⟨2⟩, ?_, ?_, ?_, ?_, ?_⟩
  · decide
  · decide
  · decide
  · exact ⟨leftDepends, List.mem_cons_self, rfl, rfl, rfl⟩
  · exact ⟨rightDepends, List.mem_cons_of_mem _ List.mem_cons_self, rfl, rfl, rfl⟩

theorem chain_not_shared : ¬ hasSharedPrerequisite exampleChain := by
  intro h
  unfold hasSharedPrerequisite isSharedPrerequisite at h
  obtain ⟨_p, a, b, hne, _ha, _hb, ⟨e1, he1, _hk1, hs1, _hd1⟩, ⟨e2, he2, _hk2, hs2, _hd2⟩⟩ := h
  simp [exampleChain] at he1 he2
  subst he1
  subst he2
  unfold chainEdge at hs1 hs2
  exact absurd (hs1.symm.trans hs2) hne

theorem sixth_contrib_matches (d : Dimension) :
    sixthContrib d = dimensionShareOf sixthAssessment d := by
  cases d <;>
    unfold sixthContrib dimensionShareOf sixthAssessment share Assessment.get oneSixth <;>
    dsimp only <;>
    simp only [← Rat.natCast_ofNat] <;>
    rw [ratMulDivDiv] <;>
    (have hnum : (1 * 1 : Nat) = 1 := by decide
     have hden : (6 * 7 : Nat) = 42 := by decide
     rw [hnum, hden]
     rfl)

private theorem sevenFortySeconds :
    ((1 : Rat) / 42) + ((1 : Rat) / 42) + ((1 : Rat) / 42) + ((1 : Rat) / 42) +
      ((1 : Rat) / 42) + ((1 : Rat) / 42) + ((1 : Rat) / 42) = (1 : Rat) / 6 := by
  simp only [← Rat.natCast_ofNat]
  rw [ratAddDivNat, ratAddDivNat, ratAddDivNat, ratAddDivNat, ratAddDivNat, ratAddDivNat]
  have h7 : (((((((1 + 1) + 1) + 1) + 1) + 1) + 1) : Nat) = 7 := by decide
  rw [h7]
  exact ratNatDivEq 7 42 1 6 (by decide) (by decide) (by decide)

theorem weight_from_sixth : weightFromAssessment sixthAssessment = (1 / 6 : Rat) := by
  unfold weightFromAssessment
  rw [← sixth_contrib_matches, ← sixth_contrib_matches, ← sixth_contrib_matches,
    ← sixth_contrib_matches, ← sixth_contrib_matches, ← sixth_contrib_matches,
    ← sixth_contrib_matches]
  unfold sixthContrib
  exact sevenFortySeconds

def zeroAssessment : Assessment where
  productValue := 0
  revenue := 0
  riskReduction := 0
  unblocking := 0
  operatorTime := 0
  computeTokens := 0
  calendarTime := 0

def benefitHigher : Candidate where
  node := ⟨0⟩
  cost := ⟨1, 1, Rat.le_refl⟩
  benefit := ⟨2, 2, Rat.le_refl⟩

def benefitLower : Candidate where
  node := ⟨1⟩
  cost := ⟨2, 2, Rat.le_refl⟩
  benefit := ⟨2, 2, Rat.le_refl⟩

def honestRow : LedgerRecord where
  node := ⟨0⟩
  tokensIn := 2
  tokensOut := 1
  tokensCached := 1
  money := 1
  wallTime := 3
  model := "m"
  config := "c"
  providerCount := 3
  harnessCount := 5
  flagged := true
  usedCount := 5

def measuredEstimate : TokenEstimate where
  node := ⟨0⟩
  model := "m"
  config := "c"
  tokensIn := 2
  tokensOut := 1
  tokensCached := 1
  money := 1
  wallTime := 3
  operatorMinutes := 4

def liveBench : BenchRow where
  config := "c"
  tokens := 4
  money := 1
  time := 3
  passRate := 1

def honestEst : EstimatorState where
  k := 4
  estimate := 2
  actual := 7
  newEstimate := 3
  version := decisionRuleNat
  loggedError := ErrorValue.ratio ((7 : Rat) / 2)

def goodState : SchedulaState where
  graph := sharedPrereqGraph
  assessment := sixthAssessment
  candidates := [benefitHigher, benefitLower]
  decisionRuleVersion := decisionRuleNat
  ruleChangedAfterData := false
  claimedOrder := [⟨0⟩, ⟨1⟩]
  ledger := [honestRow]
  estimator := honestEst
  benchmarks := [liveBench]
  tokenEstimates := [measuredEstimate]
  ledgerHost := ledgerHostName
  leanMeasure := schedulaMeasure
  views := derivedViews sharedPrereqGraph
  viewsEditedSeparately := false
  storyPointsUsed := false
  estimatesLabeledFlag := true
  shippedService := false
  usesCocomoAsSchedule := false
  damping := alpha
  hasPositiveEigenvector := isPositiveEigenvector sharedPrereqGraph forkVec (4 / 15)

theorem good_graph : graphClause goodState := by
  unfold graphClause
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · simpa [goodState, graphHasNoDirectedCycle] using fork_no_cycle
  · simpa [goodState] using fork_shared
  · intro e he
    simp [goodState, sharedPrereqGraph] at he
    rcases he with rfl | rfl
    · unfold leftDepends edgeKindAllowed
      exact Or.inl rfl
    · unfold rightDepends edgeKindAllowed
      exact Or.inl rfl
  · intro e1 he1 _e2 _he2 hkind _hdep
    simp [goodState, sharedPrereqGraph] at he1
    rcases he1 with rfl | rfl
    · unfold leftDepends at hkind
      cases hkind
    · unfold rightDepends at hkind
      cases hkind
  · intro e he hkind
    simp [goodState, sharedPrereqGraph] at he
    rcases he with rfl | rfl
    · unfold leftDepends at hkind
      cases hkind
    · unfold rightDepends at hkind
      cases hkind
  · intro n hn
    simp [goodState, sharedPrereqGraph] at hn
    rcases hn with rfl | rfl | rfl
    · unfold prereqNode
      exact ⟨Rat.natCast_nonneg, Rat.natCast_nonneg, by decide⟩
    · unfold leftNode
      exact ⟨Rat.natCast_nonneg, Rat.natCast_nonneg, by decide⟩
    · unfold rightNode
      exact ⟨Rat.natCast_nonneg, Rat.natCast_nonneg, by decide⟩
  · rfl

theorem listed_zero_before_one : listedBefore [⟨0⟩, ⟨1⟩] ⟨0⟩ ⟨1⟩ := by
  unfold listedBefore
  refine ⟨0, 1, by decide, by decide, by decide⟩

theorem score_cost_one_benefit_two : scoreOf benefitHigher = Score.finite 2 := by
  unfold scoreOf mid benefitHigher
  dsimp only
  have h1 : ((1 : Rat) + 1) / 2 = (1 : Rat) := by
    rw [← Rat.natCast_ofNat (a := 1)]
    exact midConst 1
  have h2 : ((2 : Rat) + 2) / 2 = (2 : Rat) := by
    rw [← Rat.natCast_ofNat (a := 2)]
    exact midConst 2
  rw [h1, h2]
  rw [Rat.div_def, ratOneInv, Rat.mul_one]
  rw [← Rat.natCast_ofNat (a := 1)]
  rw [if_pos (Rat.natCast_pos.mpr (by decide : (0 : Nat) < 1))]

theorem score_cost_two_benefit_two : scoreOf benefitLower = Score.finite 1 := by
  unfold scoreOf mid benefitLower
  dsimp only
  have h2 : ((2 : Rat) + 2) / 2 = (2 : Rat) := by
    rw [← Rat.natCast_ofNat (a := 2)]
    exact midConst 2
  rw [h2]
  have hdiv : (2 : Rat) / 2 = (1 : Rat) := by
    rw [← Rat.natCast_ofNat (a := 2)]
    exact ratNatDivSelf 2 (by decide)
  rw [hdiv]
  rw [← Rat.natCast_ofNat (a := 2)]
  rw [if_pos (Rat.natCast_pos.mpr (by decide : (0 : Nat) < 2))]

theorem strictScoreOrder_finite_two_one :
    strictScoreOrder (Score.finite 2) (Score.finite 1) := by
  unfold strictScoreOrder
  dsimp only
  exact Rat.natCast_lt_natCast.mpr (by decide : (1 : Nat) < 2)

theorem midpoint_score_order :
    scoreOf benefitHigher = Score.finite 2 ∧
    scoreOf benefitLower = Score.finite 1 ∧
    strictScoreOrder (scoreOf benefitHigher) (scoreOf benefitLower) := by
  refine ⟨score_cost_one_benefit_two, score_cost_two_benefit_two, ?_⟩
  rw [score_cost_one_benefit_two, score_cost_two_benefit_two]
  exact strictScoreOrder_finite_two_one

theorem good_monotone : monotoneScore goodState := by
  intro c1 c2 hc1 hc2 hscore
  simp [goodState] at hc1 hc2
  rcases hc1 with rfl | rfl <;> rcases hc2 with rfl | rfl
  · exfalso
    rw [score_cost_one_benefit_two] at hscore
    unfold strictScoreOrder at hscore
    exact absurd hscore (fun hlt => Nat.lt_irrefl 2 (Rat.natCast_lt_natCast.mp hlt))
  · exfalso
    rw [score_cost_two_benefit_two, score_cost_one_benefit_two] at hscore
    unfold strictScoreOrder at hscore
    exact absurd hscore (fun hlt => absurd (Rat.natCast_lt_natCast.mp hlt) (by decide : ¬ ((2 : Nat) < 1)))
  · simpa [goodState, benefitHigher, benefitLower] using listed_zero_before_one
  · exfalso
    rw [score_cost_two_benefit_two] at hscore
    unfold strictScoreOrder at hscore
    exact absurd hscore (fun hlt => Nat.lt_irrefl 1 (Rat.natCast_lt_natCast.mp hlt))

theorem good_total : totalOrder goodState := by
  intro c1 c2 hc1 hc2
  simp [goodState] at hc1 hc2
  rcases hc1 with rfl | rfl <;> rcases hc2 with rfl | rfl
  · exact Or.inl rfl
  · exact Or.inr (Or.inl (by simpa [goodState, benefitHigher, benefitLower] using listed_zero_before_one))
  · exact Or.inr (Or.inr (by simpa [goodState, benefitHigher, benefitLower] using listed_zero_before_one))
  · exact Or.inl rfl

theorem good_stable : stableOrder goodState := by
  unfold stableOrder
  refine ⟨rfl, rfl, ?_⟩
  intro c1 c2 hc1 hc2 hscore hval
  simp [goodState] at hc1 hc2
  rcases hc1 with rfl | rfl <;> rcases hc2 with rfl | rfl
  · simp [benefitHigher] at hval
  · rw [score_cost_one_benefit_two, score_cost_two_benefit_two] at hscore
    injection hscore with h
    exact absurd h (ratNatNe 2 1 (by decide))
  · rw [score_cost_two_benefit_two, score_cost_one_benefit_two] at hscore
    injection hscore with h
    exact absurd h (ratNatNe 1 2 (by decide))
  · simp [benefitLower] at hval

theorem good_intervals : intervalsRankable goodState := by
  intro c hc
  simp [goodState] at hc
  rcases hc with rfl | rfl
  · unfold benefitHigher mid
    dsimp only
    refine ⟨?_, ?_, Rat.le_refl, Rat.le_refl⟩
    · rw [← Rat.natCast_ofNat (a := 1),
        ← Rat.natCast_ofNat (a := 2), ← Rat.natCast_add]
      exact ratNatDivNonneg (1 + 1) 2 (by decide) (by decide)
    · rw [← Rat.natCast_ofNat (a := 2),
        ← Rat.natCast_add]
      exact ratNatDivNonneg (2 + 2) 2 (by decide) (by decide)
  · unfold benefitLower mid
    dsimp only
    refine ⟨?_, ?_, Rat.le_refl, Rat.le_refl⟩
    · rw [← Rat.natCast_ofNat (a := 2),
        ← Rat.natCast_add]
      exact ratNatDivNonneg (2 + 2) 2 (by decide) (by decide)
    · rw [← Rat.natCast_ofNat (a := 2),
        ← Rat.natCast_add]
      exact ratNatDivNonneg (2 + 2) 2 (by decide) (by decide)

theorem good_decision : decisionClause goodState :=
  ⟨good_intervals, good_monotone, good_total, good_stable⟩

theorem good_dimensions : dimensionClause goodState := by
  unfold dimensionClause
  refine ⟨?_, ?_, rfl, rfl, ?_⟩
  · intro e he
    simp [goodState, sharedPrereqGraph] at he
    rcases he with rfl | rfl
    · refine ⟨?_, ?_, ?_, ?_⟩
      · unfold leftDepends
        simpa [goodState] using weight_from_sixth.symm
      · intro d
        simpa [goodState, leftDepends] using sixth_contrib_matches d
      · unfold leftDepends
        exact ratNatDivPos 1 6 (by decide) (by decide)
      · intro d
        simp [goodState]
        cases d <;> unfold sixthAssessment Assessment.get oneSixth <;> dsimp only <;>
          exact ratNatDivNonneg 1 6 (by decide) (by decide)
    · refine ⟨?_, ?_, ?_, ?_⟩
      · unfold rightDepends
        simpa [goodState] using weight_from_sixth.symm
      · intro d
        simpa [goodState, rightDepends] using sixth_contrib_matches d
      · unfold rightDepends
        exact ratNatDivPos 1 6 (by decide) (by decide)
      · intro d
        simp [goodState]
        cases d <;> unfold sixthAssessment Assessment.get oneSixth <;> dsimp only <;>
          exact ratNatDivNonneg 1 6 (by decide) (by decide)
  · unfold goodState sharedPrereqGraph
    exact List.cons_ne_nil _ _
  · intro _d
    unfold dimensionShare
    rfl

theorem good_nostory : estimateClause goodState := by
  unfold estimateClause
  refine ⟨rfl, ?_, ?_⟩
  · unfold goodState
    exact List.cons_ne_nil _ _
  · intro e he
    simp [goodState] at he
    subst he
    unfold measuredEstimate
    exact ⟨Rat.natCast_pos.mpr (by decide : (0 : Nat) < 2), Rat.natCast_nonneg,
      Rat.natCast_nonneg, Rat.natCast_nonneg, Rat.natCast_nonneg, Rat.natCast_nonneg,
      by decide, by decide⟩

theorem largerCount_3_5 : largerCount honestRow = 5 := by
  unfold largerCount honestRow
  decide

theorem max_eq_either (a b : Nat) (hne : a ≠ b) : max a b = a ∨ max a b = b := by
  have _used : a ≠ b := hne
  cases Nat.le_total a b with
  | inl hab =>
    exact Or.inr (Nat.max_eq_right hab)
  | inr hba =>
    exact Or.inl (Nat.max_eq_left hba)

theorem disagree_3_5 : recordHonest honestRow := by
  unfold recordHonest
  intro _hne
  refine ⟨rfl, ?_⟩
  unfold largerCount honestRow
  decide

theorem disagree_general (r : LedgerRecord)
    (hf : r.flagged = true)
    (hu : r.usedCount = max r.providerCount r.harnessCount) :
    recordHonest r := by
  intro _hne
  refine ⟨hf, ?_⟩
  unfold largerCount
  exact hu

theorem good_ledger : ledgerClause goodState := by
  unfold ledgerClause
  refine ⟨rfl, ?_, ?_⟩
  · unfold goodState
    exact List.cons_ne_nil _ _
  · intro r hr
    simp [goodState] at hr
    subst hr
    refine ⟨disagree_3_5, ?_⟩
    unfold honestRow
    exact ⟨Rat.natCast_nonneg, Rat.natCast_nonneg, Rat.natCast_nonneg,
      Rat.natCast_nonneg, Rat.natCast_nonneg⟩

theorem linear_pool_eq (old actual : Rat) :
    linearPool old actual = (old * 4 + actual) / 5 := by
  unfold linearPool
  rfl

theorem linear_pool_num : linearPool 2 7 = 3 := by
  unfold linearPool
  simp only [← Rat.natCast_ofNat]
  rw [← Rat.natCast_mul]
  have h8 : (2 * 4 : Nat) = 8 := by decide
  rw [h8, ← Rat.natCast_add]
  have h15 : (8 + 7 : Nat) = 15 := by decide
  rw [h15]
  have hmul : (3 * 5 : Nat) = 15 := by decide
  rw [← hmul]
  exact ratMulDivCancelNat 3 5 (by decide)

theorem good_estimator : estimatorRule goodState := by
  unfold estimatorRule errorRatio goodState honestEst
  refine ⟨rfl, rfl, linear_pool_num.symm, ?_, ?_, ?_⟩
  · unfold errorRatioOf
    split
    · next h =>
      exact absurd h (Rat.ne_of_gt (Rat.natCast_pos.mpr (by decide : (0 : Nat) < 2)))
    · rfl
  · intro h
    exact absurd h (Rat.ne_of_gt (Rat.natCast_pos.mpr (by decide : 0 < 2)))
  · intro _
    rfl

theorem good_update : updateClause goodState := by
  unfold updateClause
  refine ⟨good_estimator, ⟨prereqNode, ?_, ?_⟩⟩
  · have hmem : prereqNode ∈ sharedPrereqGraph.nodes := by
      unfold sharedPrereqGraph
      exact List.mem_cons_self
    simpa [goodState] using hmem
  · unfold prereqNode
    rfl

theorem good_benchmarks : benchmarkClause goodState := by
  unfold benchmarkClause
  refine ⟨?_, ?_⟩
  · unfold goodState
    exact List.cons_ne_nil _ _
  · intro b hb
    simp [goodState] at hb
    subst hb
    refine ⟨?_, ⟨honestRow, ?_, ?_⟩⟩
    · unfold benchComplete liveBench
      exact ⟨Rat.natCast_nonneg, Rat.natCast_nonneg, Rat.natCast_nonneg,
        Rat.natCast_nonneg, Rat.le_refl, by decide⟩
    · unfold goodState
      exact List.mem_cons_self
    · unfold liveBench honestRow
      rfl

theorem structural_cost_num : structuralCost schedulaMeasure = (321 : Rat) := by
  unfold structuralCost schedulaMeasure
  show ((11 + 309 + 1 : Nat) : Rat) = 321
  have h : (11 + 309 + 1 : Nat) = 321 := by decide
  rw [h]
  rfl

theorem good_from_specs : specEstimateClause goodState := by
  unfold specEstimateClause
  refine ⟨?_, rfl, rfl, ?_, ?_⟩
  · intro n hn
    simp [goodState, sharedPrereqGraph] at hn
    rcases hn with rfl | rfl | rfl
    · unfold prereqNode
      exact structural_cost_num.symm
    · unfold leftNode
      exact structural_cost_num.symm
    · unfold rightNode
      exact structural_cost_num.symm
  · unfold goodState schedulaMeasure
    decide
  · unfold goodState schedulaMeasure
    decide

theorem measure_line_count :
    goodState.leanMeasure.encodedLineCount = «0017_Schedula».encodedLines.size := by
  rw [encoded_size]
  unfold goodState schedulaMeasure
  rfl

theorem good_views : viewsClause goodState := by
  unfold viewsClause
  refine ⟨?_, ?_, rfl, rfl, rfl⟩
  · intro k
    cases k
    · unfold derivedViews
      dsimp
      exact List.mem_cons_self
    · unfold derivedViews
      dsimp
      exact List.mem_cons_of_mem ViewKind.kanban List.mem_cons_self
    · unfold derivedViews
      dsimp
      exact List.mem_cons_of_mem ViewKind.kanban (List.mem_cons_of_mem ViewKind.gantt List.mem_cons_self)
    · unfold derivedViews
      dsimp
      exact List.mem_cons_of_mem ViewKind.kanban (List.mem_cons_of_mem ViewKind.gantt (List.mem_cons_of_mem ViewKind.mermaid List.mem_cons_self))
    · unfold derivedViews
      dsimp
      exact List.mem_cons_of_mem ViewKind.kanban (List.mem_cons_of_mem ViewKind.gantt (List.mem_cons_of_mem ViewKind.mermaid (List.mem_cons_of_mem ViewKind.ranked List.mem_cons_self)))
  · unfold goodState
    rfl

theorem good_candidates_nonempty : goodState.candidates ≠ [] := by
  unfold goodState
  exact List.cons_ne_nil _ _

theorem carries_higher : carriesClosedInterval benefitHigher := by
  unfold carriesClosedInterval benefitHigher
  refine ⟨?_, ?_, ?_, ?_⟩
  · exact Rat.le_refl
  · exact Rat.le_refl
  · unfold mid
    rfl
  · unfold mid
    rfl

theorem carries_lower : carriesClosedInterval benefitLower := by
  unfold carriesClosedInterval benefitLower
  refine ⟨?_, ?_, ?_, ?_⟩
  · exact Rat.le_refl
  · exact Rat.le_refl
  · unfold mid
    rfl
  · unfold mid
    rfl

theorem good_notshipped : honestyClause goodState := by
  unfold honestyClause
  refine ⟨?_, ?_, rfl, rfl, rfl, rfl, ?_⟩
  · intro c hc
    simp [goodState] at hc
    rcases hc with rfl | rfl
    · exact carries_higher
    · exact carries_lower
  · exact good_candidates_nonempty
  · intro h
    nomatch h

theorem chain_bNonneg : bNonnegative exampleChain := by
  unfold bNonnegative
  intro _n1 _hn1 _n2 _hn2
  rw [matrixB_exampleChain]
  exact ratNatDivNonneg 1 10 (by decide) (by decide)

theorem chain_entryPositive : entryPositive exampleChain := by
  intro n1 _hn1 n2 _hn2
  exact damp_entry_pos (matrixA exampleChain n1.id n2.id) exampleChain.nodes.length
    (by rw [matrixA_exampleChain_zero]; exact Rat.le_refl)
    (by rw [chain_node_count]; decide)

theorem good_damped : dampedMatrix goodState := by
  unfold dampedMatrix
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · simp [goodState, fork_node_count]
  · simp [goodState]
  · intro e he
    simp [goodState, sharedPrereqGraph] at he
    rcases he with rfl | rfl
    · unfold leftDepends
      exact ratNatDivNonneg 1 6 (by decide) (by decide)
    · unfold rightDepends
      exact ratNatDivNonneg 1 6 (by decide) (by decide)
  · intro n hn
    simp [goodState, sharedPrereqGraph] at hn
    rcases hn with rfl | rfl | rfl
    · unfold prereqNode
      exact ⟨Rat.natCast_nonneg, Rat.natCast_nonneg⟩
    · unfold leftNode
      exact ⟨Rat.natCast_nonneg, Rat.natCast_nonneg⟩
    · unfold rightNode
      exact ⟨Rat.natCast_nonneg, Rat.natCast_nonneg⟩
  · intro e he
    simp [goodState, sharedPrereqGraph] at he
    rcases he with rfl | rfl
    · unfold leftDepends edgeContribSum sixthContrib
      exact sevenFortySeconds.symm
    · unfold rightDepends edgeContribSum sixthContrib
      exact sevenFortySeconds.symm
  · unfold nodeIdsUnique goodState sharedPrereqGraph
    decide
  · simpa [goodState] using fork_entryPositive

theorem good_perron : perronFrobeniusConditions goodState := by
  unfold perronFrobeniusConditions
  refine ⟨?_, ?_, ?_, ?_⟩
  · simpa [goodState] using fork_bNonneg
  · simpa [goodState] using fork_entryPositive
  · simpa [goodState] using fork_perron_unique
  · simpa [goodState] using fork_eigenvector

theorem good_ranking : rankingClause goodState :=
  ⟨good_damped, good_perron⟩

theorem good_conforms : requiredConformance goodState :=
  ⟨good_graph, good_ranking, good_decision, good_dimensions, good_nostory,
    good_ledger, good_update, good_benchmarks, good_from_specs, good_views,
    good_notshipped⟩

def loopState : SchedulaState :=
  { goodState with
    graph := exampleLoop
    views := derivedViews exampleLoop
    hasPositiveEigenvector := False }

def storyState : SchedulaState :=
  { goodState with storyPointsUsed := true }

def ruleChangedState : SchedulaState :=
  { goodState with ruleChangedAfterData := true }

theorem loop_fails : ¬ requiredConformance loopState := by
  intro h
  unfold requiredConformance at h
  rcases h with ⟨hgraph, _⟩
  unfold graphClause at hgraph
  rcases hgraph with ⟨hfree, _⟩
  unfold workGraphHasNoDirectedCycle at hfree
  exact hfree loopWitnessWalk (by simpa [loopState] using loop_is_cycle)

theorem story_fails : ¬ requiredConformance storyState := by
  intro h
  unfold requiredConformance at h
  rcases h with ⟨_, _, _, _, hest, _⟩
  unfold estimateClause at hest
  rcases hest with ⟨hflag, _⟩
  simp [storyState] at hflag

theorem rule_changed_fails : ¬ requiredConformance ruleChangedState := by
  intro h
  unfold requiredConformance at h
  rcases h with ⟨_, _, hdec, _⟩
  unfold decisionClause at hdec
  rcases hdec with ⟨_, _, _, hstable⟩
  unfold stableOrder at hstable
  rcases hstable with ⟨hflag, _⟩
  simp [ruleChangedState] at hflag

def chainState : SchedulaState :=
  { goodState with
    graph := exampleChain
    views := derivedViews exampleChain }

theorem chain_fails_graph : ¬ graphClause chainState := by
  intro h
  unfold graphClause at h
  obtain ⟨_, hshared, _⟩ := h
  exact chain_not_shared (by simpa [chainState] using hshared)

def emptyBenchState : SchedulaState :=
  { goodState with benchmarks := [] }

theorem empty_benchmark_fails : ¬ requiredConformance emptyBenchState := by
  intro h
  unfold requiredConformance at h
  rcases h with ⟨_, _, _, _, _, _, _, hbench, _⟩
  unfold benchmarkClause at hbench
  rcases hbench with ⟨hne, _⟩
  exact absurd (rfl : emptyBenchState.benchmarks = []) hne

namespace Proofs_0017

open «0017_Schedula»

theorem encoding_is_not_proof :
    «0017_Schedula».markedAsSpecEncoding = true ∧ «0017_Schedula».markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : «0017_Schedula».specNumber = 17 := rfl

end Proofs_0017
