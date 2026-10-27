import SchedulaSpec
import «0017_Schedula»

open SchedulaSpec

/-
  Proofs for specification 0017. Encodings stay in the sibling module.
  `hasPositiveEigenvector` on `goodState` is the Perron statement, not `False`.
-/

theorem encoded_size : «0017_Schedula».encodedLines.size = 309 := by
  decide

theorem one_tenth_pos : 0 < (1 / 10 : Rat) := by
  decide

private theorem ratMulNonneg {a b : Rat} (ha : 0 ≤ a) (hb : 0 ≤ b) : 0 ≤ a * b := by
  grind

private theorem ratMulPos {a b : Rat} (ha : 0 < a) (hb : 0 < b) : 0 < a * b := by
  grind

private theorem ratDivPos {a b : Rat} (ha : 0 < a) (hb : 0 < b) : 0 < a / b := by
  grind

private theorem ratDivMulCancel (a b : Rat) (hb : 0 < b) : a / b * b = a := by
  grind

private theorem ratAddPosOfNonnegOfPos {a b : Rat} (ha : 0 ≤ a) (hb : 0 < b) : 0 < a + b := by
  grind

private theorem ratNatCastPos (n : Nat) (hn : 1 ≤ n) : (0 : Rat) < (n : Rat) := by
  have h0 : 0 < n := Nat.succ_le_iff.mp hn
  grind

theorem damp_entry_pos (a : Rat) (n : Nat) (ha : 0 ≤ a) (hn : 1 ≤ n) :
    0 < (1 - alpha) * a + alpha / (n : Rat) := by
  have hcoef : (0 : Rat) ≤ 1 - alpha := by
    unfold alpha
    decide
  have hprod : (0 : Rat) ≤ (1 - alpha) * a := ratMulNonneg hcoef ha
  have halpha : (0 : Rat) < alpha := by
    unfold alpha
    decide
  have hdiv : (0 : Rat) < alpha / (n : Rat) := ratDivPos halpha (ratNatCastPos n hn)
  exact ratAddPosOfNonnegOfPos hprod hdiv

theorem matrixA_exampleChain_zero (i j : NodeId) : matrixA exampleChain i j = 0 := by
  unfold matrixA exampleChain
  simp only [List.foldl_cons, List.foldl_nil]
  split <;> unfold chainEdge <;> simp

theorem chain_node_count : exampleChain.nodes.length = 2 := by
  unfold exampleChain
  rfl

theorem matrixB_exampleChain (i j : NodeId) : matrixB exampleChain i j = (1 / 10 : Rat) := by
  unfold matrixB matrixBWith
  rw [matrixA_exampleChain_zero i j, chain_node_count]
  unfold alpha
  decide

theorem matrixB_chain_nodes :
    matrixB exampleChain ⟨0⟩ ⟨0⟩ = (1 / 10 : Rat) ∧
    matrixB exampleChain ⟨0⟩ ⟨1⟩ = (1 / 10 : Rat) ∧
    matrixB exampleChain ⟨1⟩ ⟨0⟩ = (1 / 10 : Rat) ∧
    matrixB exampleChain ⟨1⟩ ⟨1⟩ = (1 / 10 : Rat) := by
  refine ⟨matrixB_exampleChain _ _, matrixB_exampleChain _ _,
    matrixB_exampleChain _ _, matrixB_exampleChain _ _⟩

theorem applyB_chain_general (v : NodeId → Rat) (i : NodeId) :
    applyB exampleChain v i = (1 / 10 : Rat) * v ⟨0⟩ + (1 / 10 : Rat) * v ⟨1⟩ := by
  unfold applyB exampleChain
  simp only [List.foldl_cons, List.foldl_nil, chainNode0, chainNode1]
  rw [matrixB_exampleChain i ⟨0⟩, matrixB_exampleChain i ⟨1⟩]
  simp

theorem chain_eigenvector : isPositiveEigenvector exampleChain (fun _ => (1 : Rat)) (1 / 5) := by
  unfold isPositiveEigenvector positiveOnNodes
  constructor
  · intros
    decide
  · intros
    rw [applyB_chain_general]
    decide

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
    List.getElem_mem exampleChain.nodes 0 chain_index_lt_zero
  have hmem1 : exampleChain.nodes[1] ∈ exampleChain.nodes :=
    List.getElem_mem exampleChain.nodes 1 chain_index_lt_one
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
    grind
  cases hsplit with
  | inl hlam0 =>
    grind
  | inr heq =>
    have hlam : lam = (1 / 5 : Rat) := by
      grind
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
    by_cases hlt : r0 < r1
    · have hd0 : v 0 - r0 * w 0 = 0 := by
        grind
      have hd1 : 0 < v 1 - r0 * w 1 := by
        grind
      have hdot :
          M 0 0 * (v 0 - r0 * w 0) + M 0 1 * (v 1 - r0 * w 1) =
            lam * (v 0 - r0 * w 0) := by
        have hV : M 0 0 * v 0 + M 0 1 * v 1 = lam * v 0 := hMv 0
        have hW : M 0 0 * w 0 + M 0 1 * w 1 = lam * w 0 := hMw 0
        grind
      have hprod : M 0 1 * (v 1 - r0 * w 1) = 0 := by
        grind
      have hpos : 0 < M 0 1 * (v 1 - r0 * w 1) := ratMulPos (hM 0 1) hd1
      grind
    · have hgt : r1 < r0 := by
        grind
      have hd1 : v 1 - r1 * w 1 = 0 := by
        grind
      have hd0 : 0 < v 0 - r1 * w 0 := by
        grind
      have hdot :
          M 1 0 * (v 0 - r1 * w 0) + M 1 1 * (v 1 - r1 * w 1) =
            lam * (v 1 - r1 * w 1) := by
        have hV : M 1 0 * v 0 + M 1 1 * v 1 = lam * v 1 := hMv 1
        have hW : M 1 0 * w 0 + M 1 1 * w 1 = lam * w 1 := hMw 1
        grind
      have hprod : M 1 0 * (v 0 - r1 * w 0) = 0 := by
        grind
      have hpos : 0 < M 1 0 * (v 0 - r1 * w 0) := ratMulPos (hM 1 0) hd0
      grind

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
    simp [h1, h2, zero_add, add_zero]

private theorem matrixA_fork_nonneg (i j : NodeId) : 0 ≤ matrixA sharedPrereqGraph i j := by
  rw [matrixA_fork_form]
  unfold leftDepends rightDepends
  cases h1 : ((⟨1⟩ : NodeId) == i && (⟨0⟩ : NodeId) == j) <;>
    cases h2 : ((⟨2⟩ : NodeId) == i && (⟨0⟩ : NodeId) == j) <;>
    simp [h1, h2] <;> decide

private theorem matrixA_at (i j : NodeId) : matrixA sharedPrereqGraph i j =
    (if (⟨1⟩ : NodeId) == i && (⟨0⟩ : NodeId) == j then (1 : Rat) / 6 else 0) +
    (if (⟨2⟩ : NodeId) == i && (⟨0⟩ : NodeId) == j then (1 : Rat) / 6 else 0) := by
  rw [matrixA_fork_form]
  unfold leftDepends rightDepends
  rfl

theorem matrixA_fork_00 : matrixA sharedPrereqGraph ⟨0⟩ ⟨0⟩ = 0 := by
  rw [matrixA_at]; decide

theorem matrixA_fork_01 : matrixA sharedPrereqGraph ⟨0⟩ ⟨1⟩ = 0 := by
  rw [matrixA_at]; decide

theorem matrixA_fork_02 : matrixA sharedPrereqGraph ⟨0⟩ ⟨2⟩ = 0 := by
  rw [matrixA_at]; decide

theorem matrixA_fork_10 : matrixA sharedPrereqGraph ⟨1⟩ ⟨0⟩ = (1 / 6 : Rat) := by
  rw [matrixA_at]; decide

theorem matrixA_fork_11 : matrixA sharedPrereqGraph ⟨1⟩ ⟨1⟩ = 0 := by
  rw [matrixA_at]; decide

theorem matrixA_fork_12 : matrixA sharedPrereqGraph ⟨1⟩ ⟨2⟩ = 0 := by
  rw [matrixA_at]; decide

theorem matrixA_fork_20 : matrixA sharedPrereqGraph ⟨2⟩ ⟨0⟩ = (1 / 6 : Rat) := by
  rw [matrixA_at]; decide

theorem matrixA_fork_21 : matrixA sharedPrereqGraph ⟨2⟩ ⟨1⟩ = 0 := by
  rw [matrixA_at]; decide

theorem matrixA_fork_22 : matrixA sharedPrereqGraph ⟨2⟩ ⟨2⟩ = 0 := by
  rw [matrixA_at]; decide

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

theorem matrixB_fork_00 : matrixB sharedPrereqGraph ⟨0⟩ ⟨0⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨0⟩ ⟨0⟩ 0 (1 / 15) matrixA_fork_00 (by unfold alpha; decide)

theorem matrixB_fork_01 : matrixB sharedPrereqGraph ⟨0⟩ ⟨1⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨0⟩ ⟨1⟩ 0 (1 / 15) matrixA_fork_01 (by unfold alpha; decide)

theorem matrixB_fork_02 : matrixB sharedPrereqGraph ⟨0⟩ ⟨2⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨0⟩ ⟨2⟩ 0 (1 / 15) matrixA_fork_02 (by unfold alpha; decide)

theorem matrixB_fork_10 : matrixB sharedPrereqGraph ⟨1⟩ ⟨0⟩ = (1 / 5 : Rat) :=
  matrixB_when ⟨1⟩ ⟨0⟩ ((1 : Rat) / 6) (1 / 5) matrixA_fork_10 (by unfold alpha; decide)

theorem matrixB_fork_11 : matrixB sharedPrereqGraph ⟨1⟩ ⟨1⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨1⟩ ⟨1⟩ 0 (1 / 15) matrixA_fork_11 (by unfold alpha; decide)

theorem matrixB_fork_12 : matrixB sharedPrereqGraph ⟨1⟩ ⟨2⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨1⟩ ⟨2⟩ 0 (1 / 15) matrixA_fork_12 (by unfold alpha; decide)

theorem matrixB_fork_20 : matrixB sharedPrereqGraph ⟨2⟩ ⟨0⟩ = (1 / 5 : Rat) :=
  matrixB_when ⟨2⟩ ⟨0⟩ ((1 : Rat) / 6) (1 / 5) matrixA_fork_20 (by unfold alpha; decide)

theorem matrixB_fork_21 : matrixB sharedPrereqGraph ⟨2⟩ ⟨1⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨2⟩ ⟨1⟩ 0 (1 / 15) matrixA_fork_21 (by unfold alpha; decide)

theorem matrixB_fork_22 : matrixB sharedPrereqGraph ⟨2⟩ ⟨2⟩ = (1 / 15 : Rat) :=
  matrixB_when ⟨2⟩ ⟨2⟩ 0 (1 / 15) matrixA_fork_22 (by unfold alpha; decide)

theorem applyB_fork (v : NodeId → Rat) (i : NodeId) :
    applyB sharedPrereqGraph v i =
      matrixB sharedPrereqGraph i ⟨0⟩ * v ⟨0⟩ +
      matrixB sharedPrereqGraph i ⟨1⟩ * v ⟨1⟩ +
      matrixB sharedPrereqGraph i ⟨2⟩ * v ⟨2⟩ := by
  unfold applyB sharedPrereqGraph
  simp only [List.foldl_cons, List.foldl_nil]
  unfold prereqNode leftNode rightNode
  simp only [zero_add]
  rfl

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

theorem fork_eigenvector : isPositiveEigenvector sharedPrereqGraph forkVec (4 / 15) := by
  unfold isPositiveEigenvector positiveOnNodes
  constructor
  · intro n hn
    simp [sharedPrereqGraph] at hn
    rcases hn with rfl | rfl | rfl
    · unfold prereqNode forkVec
      decide
    · unfold leftNode forkVec
      decide
    · unfold rightNode forkVec
      decide
  · intro n hn
    simp [sharedPrereqGraph] at hn
    rcases hn with rfl | rfl | rfl
    · unfold prereqNode
      rw [applyB_fork, matrixB_fork_00, matrixB_fork_01, matrixB_fork_02]
      unfold forkVec
      decide
    · unfold leftNode
      rw [applyB_fork, matrixB_fork_10, matrixB_fork_11, matrixB_fork_12]
      unfold forkVec
      decide
    · unfold rightNode
      rw [applyB_fork, matrixB_fork_20, matrixB_fork_21, matrixB_fork_22]
      unfold forkVec
      decide

theorem fork_equal_components (v : NodeId → Rat) (lam : Rat)
    (hv : isPositiveEigenvector sharedPrereqGraph v lam) :
    lam = (4 / 15 : Rat) ∧ v ⟨1⟩ = v ⟨2⟩ ∧ v ⟨0⟩ = (2 / 3 : Rat) * v ⟨1⟩ ∧
      0 < v ⟨0⟩ ∧ 0 < v ⟨1⟩ ∧ 0 < v ⟨2⟩ := by
  unfold isPositiveEigenvector positiveOnNodes at hv
  obtain ⟨hpos, happ⟩ := hv
  have hmem0 : sharedPrereqGraph.nodes[0] ∈ sharedPrereqGraph.nodes :=
    List.getElem_mem sharedPrereqGraph.nodes 0 fork_len0
  have hmem1 : sharedPrereqGraph.nodes[1] ∈ sharedPrereqGraph.nodes :=
    List.getElem_mem sharedPrereqGraph.nodes 1 fork_len1
  have hmem2 : sharedPrereqGraph.nodes[2] ∈ sharedPrereqGraph.nodes :=
    List.getElem_mem sharedPrereqGraph.nodes 2 fork_len2
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
  have hsame : lam * v ⟨1⟩ = lam * v ⟨2⟩ := by
    grind
  have hsplit : lam = 0 ∨ v ⟨1⟩ = v ⟨2⟩ := by
    grind
  have hsum : 0 < (1 / 15 : Rat) * v ⟨0⟩ + (1 / 15) * v ⟨1⟩ + (1 / 15) * v ⟨2⟩ := by
    grind
  cases hsplit with
  | inl hlam0 =>
    grind
  | inr hyz =>
    have h0 : (1 / 15 : Rat) * v ⟨0⟩ + (2 / 15) * v ⟨1⟩ = lam * v ⟨0⟩ := by
      grind
    have h1 : (1 / 5 : Rat) * v ⟨0⟩ + (2 / 15) * v ⟨1⟩ = lam * v ⟨1⟩ := by
      grind
    have hcross :
        v ⟨1⟩ * ((1 / 15 : Rat) * v ⟨0⟩ + (2 / 15) * v ⟨1⟩) =
          v ⟨0⟩ * ((1 / 5 : Rat) * v ⟨0⟩ + (2 / 15) * v ⟨1⟩) := by
      grind
    have hpoly : (3 : Rat) * v ⟨0⟩ * v ⟨0⟩ + v ⟨0⟩ * v ⟨1⟩ - 2 * v ⟨1⟩ * v ⟨1⟩ = 0 := by
      grind
    have hfac : ((3 : Rat) * v ⟨0⟩ - 2 * v ⟨1⟩) * (v ⟨0⟩ + v ⟨1⟩) = 0 := by
      grind
    have hsumpos : v ⟨0⟩ + v ⟨1⟩ ≠ 0 := by
      grind
    have hlin : (3 : Rat) * v ⟨0⟩ - 2 * v ⟨1⟩ = 0 := by
      grind
    have hxratio : v ⟨0⟩ = (2 / 3 : Rat) * v ⟨1⟩ := by
      grind
    have hlam : lam = (4 / 15 : Rat) := by
      grind
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
    grind
  · unfold leftNode
    exact (ratDivMulCancel (v ⟨1⟩) (w ⟨1⟩) hwpos1).symm
  · unfold rightNode
    grind

theorem fork_entryPositive : entryPositive sharedPrereqGraph := by
  intro n1 _hn1 n2 _hn2
  exact damp_entry_pos (matrixA sharedPrereqGraph n1.id n2.id) sharedPrereqGraph.nodes.length
    (matrixA_fork_nonneg n1.id n2.id) (by rw [fork_node_count]; decide)

theorem fork_bNonneg : bNonnegative sharedPrereqGraph := by
  intro n1 hn1 n2 hn2
  unfold matrixB matrixBWith
  exact le_of_lt (fork_entryPositive n1 hn1 n2 hn2)

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
  · exact ⟨leftDepends, List.mem_cons_self _ _, rfl, rfl, rfl⟩
  · exact ⟨rightDepends, List.mem_cons_of_mem _ (List.mem_cons_self _ _), rfl, rfl, rfl⟩

theorem chain_not_shared : ¬ hasSharedPrerequisite exampleChain := by
  intro h
  unfold hasSharedPrerequisite isSharedPrerequisite at h
  obtain ⟨_p, a, b, hne, _ha, _hb, ⟨e1, he1, _hk1, hs1, _hd1⟩, ⟨e2, he2, _hk2, hs2, _hd2⟩⟩ := h
  simp [exampleChain] at he1 he2
  subst he1
  subst he2
  unfold chainEdge at hs1 hs2
  exact absurd (hs1.symm.trans hs2) hne

theorem weight_from_sixth : weightFromAssessment sixthAssessment = (1 / 6 : Rat) := by
  unfold weightFromAssessment dimensionShareOf sixthAssessment share Assessment.get oneSixth
  decide

theorem sixth_contrib_matches (d : Dimension) :
    sixthContrib d = dimensionShareOf sixthAssessment d := by
  cases d <;>
    unfold sixthContrib dimensionShareOf sixthAssessment share Assessment.get oneSixth <;>
    decide

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
  cost := ⟨1, 1, by decide⟩
  benefit := ⟨2, 2, by decide⟩

def benefitLower : Candidate where
  node := ⟨1⟩
  cost := ⟨2, 2, by decide⟩
  benefit := ⟨2, 2, by decide⟩

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
      decide
    · unfold leftNode
      decide
    · unfold rightNode
      decide
  · rfl

theorem listed_zero_before_one : listedBefore [⟨0⟩, ⟨1⟩] ⟨0⟩ ⟨1⟩ := by
  unfold listedBefore
  refine ⟨0, 1, by decide, by decide, by decide⟩

theorem score_cost_one_benefit_two : scoreOf benefitHigher = Score.finite 2 := by
  unfold scoreOf mid benefitHigher
  decide

theorem score_cost_two_benefit_two : scoreOf benefitLower = Score.finite 1 := by
  unfold scoreOf mid benefitLower
  decide

theorem strictScoreOrder_finite_two_one :
    strictScoreOrder (Score.finite 2) (Score.finite 1) := by
  unfold strictScoreOrder
  decide

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
    exact absurd hscore (by decide : ¬ ((2 : Rat) < 2))
  · exfalso
    rw [score_cost_two_benefit_two, score_cost_one_benefit_two] at hscore
    unfold strictScoreOrder at hscore
    exact absurd hscore (by decide : ¬ ((2 : Rat) < 1))
  · simpa [goodState, benefitHigher, benefitLower] using listed_zero_before_one
  · exfalso
    rw [score_cost_two_benefit_two] at hscore
    unfold strictScoreOrder at hscore
    exact absurd hscore (by decide : ¬ ((1 : Rat) < 1))

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
    exact absurd hval (by decide : ¬ ((0 : Nat) < 0))
  · rw [score_cost_one_benefit_two, score_cost_two_benefit_two] at hscore
    injection hscore with h
    exact absurd h (by decide : (2 : Rat) ≠ 1)
  · rw [score_cost_two_benefit_two, score_cost_one_benefit_two] at hscore
    injection hscore with h
    exact absurd h (by decide : (1 : Rat) ≠ 2)
  · simp [benefitLower] at hval
    exact absurd hval (by decide : ¬ ((1 : Nat) < 1))

theorem good_intervals : intervalsRankable goodState := by
  intro c hc
  simp [goodState] at hc
  rcases hc with rfl | rfl
  · unfold benefitHigher mid
    decide
  · unfold benefitLower mid
    decide

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
        decide
      · intro d
        simp [goodState]
        cases d <;> unfold sixthAssessment Assessment.get oneSixth <;> decide
    · refine ⟨?_, ?_, ?_, ?_⟩
      · unfold rightDepends
        simpa [goodState] using weight_from_sixth.symm
      · intro d
        simpa [goodState, rightDepends] using sixth_contrib_matches d
      · unfold rightDepends
        decide
      · intro d
        simp [goodState]
        cases d <;> unfold sixthAssessment Assessment.get oneSixth <;> decide
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
    decide

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
    decide

theorem linear_pool_eq (old actual : Rat) :
    linearPool old actual = (old * 4 + actual) / 5 := by
  unfold linearPool
  rfl

theorem linear_pool_num : linearPool 2 7 = 3 := by
  unfold linearPool
  decide

theorem good_estimator : estimatorRule goodState := by
  unfold estimatorRule errorRatio goodState honestEst
  refine ⟨rfl, rfl, linear_pool_num.symm, ?_, ?_, ?_⟩
  · unfold errorRatioOf
    decide
  · intro h
    exact absurd h (by decide : (2 : Rat) ≠ 0)
  · intro _
    unfold errorRatioOf
    rfl

theorem good_update : updateClause goodState := by
  unfold updateClause
  refine ⟨good_estimator, ⟨prereqNode, ?_, ?_⟩⟩
  · have hmem : prereqNode ∈ sharedPrereqGraph.nodes := by
      unfold sharedPrereqGraph
      exact List.mem_cons_self _ _
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
      decide
    · unfold goodState
      exact List.mem_cons_self _ _
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
    cases k <;> unfold derivedViews <;> decide
  · unfold goodState
    rfl

theorem good_candidates_nonempty : goodState.candidates ≠ [] := by
  unfold goodState
  exact List.cons_ne_nil _ _

theorem carries_higher : carriesClosedInterval benefitHigher := by
  unfold carriesClosedInterval benefitHigher
  refine ⟨?_, ?_, ?_, ?_⟩
  · decide
  · decide
  · unfold mid
    rfl
  · unfold mid
    rfl

theorem carries_lower : carriesClosedInterval benefitLower := by
  unfold carriesClosedInterval benefitLower
  refine ⟨?_, ?_, ?_, ?_⟩
  · decide
  · decide
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
  decide

theorem chain_entryPositive : entryPositive exampleChain := by
  intro n1 _hn1 n2 _hn2
  exact damp_entry_pos (matrixA exampleChain n1.id n2.id) exampleChain.nodes.length
    (by rw [matrixA_exampleChain_zero]; decide)
    (by rw [chain_node_count]; decide)

theorem good_damped : dampedMatrix goodState := by
  unfold dampedMatrix
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · simp [goodState, fork_node_count]
    decide
  · simp [goodState]
  · intro e he
    simp [goodState, sharedPrereqGraph] at he
    rcases he with rfl | rfl
    · unfold leftDepends
      decide
    · unfold rightDepends
      decide
  · intro n hn
    simp [goodState, sharedPrereqGraph] at hn
    rcases hn with rfl | rfl | rfl
    · unfold prereqNode
      decide
    · unfold leftNode
      decide
    · unfold rightNode
      decide
  · intro e he
    simp [goodState, sharedPrereqGraph] at he
    rcases he with rfl | rfl
    · unfold leftDepends edgeContribSum sixthContrib
      decide
    · unfold rightDepends edgeContribSum sixthContrib
      decide
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
  unfold graphHasNoDirectedCycle workGraphHasNoDirectedCycle at hfree
  exact hfree loopWitnessWalk (by simpa [loopState] using loop_is_cycle)

theorem story_fails : ¬ requiredConformance storyState := by
  intro h
  unfold requiredConformance at h
  rcases h with ⟨_, _, _, _, hest, _⟩
  unfold estimateClause at hest
  rcases hest with ⟨hflag, _⟩
  simp [storyState] at hflag
  exact absurd hflag (by decide : true ≠ false)

theorem rule_changed_fails : ¬ requiredConformance ruleChangedState := by
  intro h
  unfold requiredConformance at h
  rcases h with ⟨_, _, hdec, _⟩
  unfold decisionClause at hdec
  rcases hdec with ⟨_, _, _, hstable⟩
  unfold stableOrder at hstable
  rcases hstable with ⟨hflag, _⟩
  simp [ruleChangedState] at hflag
  exact absurd hflag (by decide : true ≠ false)

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

theorem encoding_is_not_proof :
    markedAsSpecEncoding = true ∧ markedAsProof = false :=
  And.intro rfl rfl

theorem spec_number : specNumber = 17 := rfl
