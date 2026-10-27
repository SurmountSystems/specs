/-
  SPEC ENCODINGS for numbered specification 0017 Schedula.

  This module is not the specification. Numbered markdown
  0017_Schedula.md is the contract humans read. Proofs live in a
  separate module. Lean proofs are not the specification. A conforming
  Schedula is not claimed.

  Schedula is the Surmount Systems Scientific Scheduling Service.
  These declarations say what must be true of a state. They do not
  discharge those claims.

  Lessons (not a copy of the papers):
  Formal Vibefication:
    https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
  Taking Don't Trust. Verify. Seriously:
    https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html

  The cycle shape follows specification 0011 Clause 4.4: no directed
  cycle in the edge relation. This graph is not a second .sstt format.
  Estimates use Rat. This module does not define a real number type.
  Existence of a positive eigenvector is a hypothesis slot, not a proof.
  COCOMO is not the cost and is not the schedule.
  The logarithm of an error ratio is informative and is not computed.
  Estimates keep improving through the linear pool. That sentence does
  not claim a service shipped.

  Comments in this module use the CATE leftover unstack floor. They do
  not claim every comment is a complete American English thought.
-/

namespace SchedulaSpec

/-- This module is a spec encoding, not a proof. -/
def liveContainsSpecEncodings : Bool := true

def liveContainsProofsOfThoseEncodings : Bool := false

def markedAsSpecEncoding : Bool := true

def markedAsProof : Bool := false

/-- Identity of numbered specification 0017. -/
def schedulaSpecNumber : Nat := 17

def specNumber : Nat := 17

def specFileName : String := "0017_Schedula.md"

def productName : String := "Schedula"

def serviceName : String := "Surmount Systems Scientific Scheduling Service"

/-- Spec version 0.1.0. The Nat used on the estimator and the decision rule is 1. -/
def specVersion : String := "0.1.0"

def specVersionDate : String := "20261026"

def decisionRuleNat : Nat := 1

def humanMarkdownIsTheHumanContract : Bool := true

def humanMarkdownSubstitutesForLeanSpecEncoding : Bool := false

def leanProofIsTheSpec : Bool := false

/-- A conforming Schedula is not claimed. This flag is not a catalog row. -/
def conformingSchedulaClaimed : Bool := false

def productsClaimedReadyForUse : Bool := false

/-- No constructor. A later proof can close a claimed inhabitant with nomatch. -/
inductive ShippedSchedula : Prop

/-
  Node identities, status, and edges.
  The human word for the first status is open. Lean reserves that word,
  so the constructor is opened.
-/

structure NodeId where
  val : Nat
  deriving DecidableEq, Repr, BEq

inductive Status where
  | opened
  | active
  | done
  | dropped
  deriving DecidableEq, Repr, BEq

inductive EdgeKind where
  | dependsOn
  | enables
  | competesForResource
  deriving DecidableEq, Repr, BEq

inductive Dimension where
  | productValue
  | revenue
  | riskReduction
  | unblocking
  | operatorTime
  | computeTokens
  | calendarTime
  deriving DecidableEq, Repr, BEq

/-- Each of the seven dimensions has this share. -/
def share : Rat := (1 : Rat) / 7

/-- Damping constant. One fifth. -/
def alpha : Rat := (1 : Rat) / 5

def dimensionShare : Dimension → Rat := fun _ => share

def dimensions : List Dimension :=
  [ Dimension.productValue
  , Dimension.revenue
  , Dimension.riskReduction
  , Dimension.unblocking
  , Dimension.operatorTime
  , Dimension.computeTokens
  , Dimension.calendarTime
  ]

/-- Sum of the seven dimension contributions on one edge. -/
def edgeContribSum (c : Dimension → Rat) : Rat :=
  c Dimension.productValue +
    c Dimension.revenue +
    c Dimension.riskReduction +
    c Dimension.unblocking +
    c Dimension.operatorTime +
    c Dimension.computeTokens +
    c Dimension.calendarTime

structure PlanNode where
  id : NodeId
  costEstimate : Rat
  valueEstimate : Rat
  status : Status
  owner : String
  evidence : List String

structure PlanEdge where
  src : NodeId
  dst : NodeId
  kind : EdgeKind
  weight : Rat
  contrib : Dimension → Rat

structure WorkGraph where
  nodes : List PlanNode
  edges : List PlanEdge

/-- Seven coordinates. Not a single Rat. -/
structure Assessment where
  productValue : Rat
  revenue : Rat
  riskReduction : Rat
  unblocking : Rat
  operatorTime : Rat
  computeTokens : Rat
  calendarTime : Rat

def Assessment.get : Assessment → Dimension → Rat
  | a, .productValue => a.productValue
  | a, .revenue => a.revenue
  | a, .riskReduction => a.riskReduction
  | a, .unblocking => a.unblocking
  | a, .operatorTime => a.operatorTime
  | a, .computeTokens => a.computeTokens
  | a, .calendarTime => a.calendarTime

/-- One dimension's share of an edge weight. Version 0.1.0 uses one seventh. -/
def dimensionShareOf (a : Assessment) (d : Dimension) : Rat :=
  Assessment.get a d * share

/-- Edge weight is the sum of the seven shares. Not one collapsed factor. -/
def weightFromAssessment (a : Assessment) : Rat :=
  dimensionShareOf a Dimension.productValue +
    dimensionShareOf a Dimension.revenue +
    dimensionShareOf a Dimension.riskReduction +
    dimensionShareOf a Dimension.unblocking +
    dimensionShareOf a Dimension.operatorTime +
    dimensionShareOf a Dimension.computeTokens +
    dimensionShareOf a Dimension.calendarTime

/-- Unit and evidence source for one named dimension. -/
structure DimensionFact where
  dim : Dimension
  unitName : String
  sourceName : String

def dimensionFacts : List DimensionFact :=
  [ ⟨Dimension.productValue, "rational score", "numbered specification"⟩
  , ⟨Dimension.revenue, "rational money", "recorded payment"⟩
  , ⟨Dimension.riskReduction, "rational score", "risk note"⟩
  , ⟨Dimension.unblocking, "successor count", "work graph"⟩
  , ⟨Dimension.operatorTime, "operator minutes", "operator record"⟩
  , ⟨Dimension.computeTokens, "token count and money", "ledger"⟩
  , ⟨Dimension.calendarTime, "wall clock time", "ledger"⟩
  ]

structure ClosedInterval where
  lo : Rat
  hi : Rat
  loLeHi : lo ≤ hi

def mid (iv : ClosedInterval) : Rat :=
  (iv.lo + iv.hi) / 2

structure Candidate where
  node : NodeId
  cost : ClosedInterval
  benefit : ClosedInterval

/--
  Midpoint score. A positive cost uses benefit mid divided by cost mid.
  A cost mid that is not positive, with a positive benefit mid, is the
  top rank. Otherwise the score is zero. The top rank is a constructor,
  not a punctuation mark.
-/
inductive Score where
  | finite (value : Rat)
  | topRank
  deriving DecidableEq, Repr

def scoreOf (c : Candidate) : Score :=
  let costMid := mid c.cost
  let benefitMid := mid c.benefit
  if costMid > 0 then
    Score.finite (benefitMid / costMid)
  else if benefitMid > 0 then
    Score.topRank
  else
    Score.finite 0

structure LedgerRecord where
  node : NodeId
  tokensIn : Rat
  tokensOut : Rat
  tokensCached : Rat
  money : Rat
  wallTime : Rat
  model : String
  config : String
  providerCount : Nat
  harnessCount : Nat
  flagged : Bool
  usedCount : Nat

/-- Logged error. undefined is the separate flag when the estimate is zero. -/
inductive ErrorValue where
  | ratio (value : Rat)
  | undefined
  deriving DecidableEq, Repr

structure EstimatorState where
  k : Nat
  estimate : Rat
  actual : Rat
  newEstimate : Rat
  version : Nat
  loggedError : ErrorValue

structure BenchRow where
  config : String
  tokens : Rat
  money : Rat
  time : Rat
  passRate : Rat

inductive ViewKind where
  | kanban
  | gantt
  | mermaid
  | ranked
  | calibration
  deriving DecidableEq, Repr, BEq

/-- Tokens and money for one model configuration. Wall time and operator minutes are separate. -/
structure TokenEstimate where
  node : NodeId
  model : String
  config : String
  tokensIn : Rat
  tokensOut : Rat
  tokensCached : Rat
  money : Rat
  wallTime : Rat
  operatorMinutes : Rat

/-- Structural measures computed in Lean. Not a Boolean that is true by definition. -/
structure LeanMeasure where
  clauseCount : Nat
  conformanceCount : Nat
  encodedLineCount : Nat
  proofObligationCount : Nat

/-- Clause count plus encoded line count plus proof obligation count. -/
def structuralCost (m : LeanMeasure) : Rat :=
  (m.clauseCount + m.encodedLineCount + m.proofObligationCount : Nat)

def schedulaMeasure : LeanMeasure where
  clauseCount := 11
  conformanceCount := 11
  encodedLineCount := 309
  proofObligationCount := 1

/-- The ledger host named in Clause 4.6. -/
def ledgerHostName : String := "surmount-1"

/--
  State of a Schedula model. hasPositiveEigenvector is a hypothesis slot.
  The default is False, which means the slot is empty. It is not an
  existence proof and it is not the constant True.
-/
structure SchedulaState where
  graph : WorkGraph
  assessment : Assessment
  candidates : List Candidate
  decisionRuleVersion : Nat
  ruleChangedAfterData : Bool
  claimedOrder : List NodeId
  ledger : List LedgerRecord
  estimator : EstimatorState
  benchmarks : List BenchRow
  tokenEstimates : List TokenEstimate
  ledgerHost : String
  leanMeasure : LeanMeasure
  views : List ViewKind
  viewsEditedSeparately : Bool
  storyPointsUsed : Bool
  estimatesLabeledFlag : Bool
  shippedService : Bool
  usesCocomoAsSchedule : Bool
  damping : Rat
  hasPositiveEigenvector : Prop := False

/-
  Directed walks. A cycle is a walk with at least one edge whose first
  and last ids are equal. A one node list is not a cycle.
  exampleChain is a two node chain. It has no shared prerequisite, so it
  fails the work graph conjunct. exampleLoop is a two node loop.
  sharedPrereqGraph is not a tree: node 0 is a prerequisite of nodes 1 and 2.
-/

def hasStep (g : WorkGraph) (src dst : NodeId) : Prop :=
  ∃ e ∈ g.edges, e.src = src ∧ e.dst = dst

def isWalk (g : WorkGraph) : List NodeId → Prop
  | [] => True
  | [_] => True
  | a :: b :: rest => hasStep g a b ∧ isWalk g (b :: rest)

def endsMatch (w : List NodeId) : Prop :=
  match w.getLast? with
  | some last =>
      match w.head? with
      | some head => last = head
      | none => False
  | none => False

def isDirectedCycle (g : WorkGraph) (w : List NodeId) : Prop :=
  2 ≤ w.length ∧ isWalk g w ∧ endsMatch w

def workGraphHasNoDirectedCycle (g : WorkGraph) : Prop :=
  ∀ w : List NodeId, ¬ isDirectedCycle g w

def graphHasNoDirectedCycle (s : SchedulaState) : Prop :=
  workGraphHasNoDirectedCycle s.graph

/-
  Damped matrix. Index is position in nodes, also exposed as NodeId to NodeId.
  A_ij is the edge weight, or zero when no edge matches.
  B_ij = (1 - alpha) * A_ij + alpha / n, for n at least 1.
  Rat division by zero is zero in the prelude, so n at least 1 is required
  here and is not left to that division.
-/

def matrixA (g : WorkGraph) (i j : NodeId) : Rat :=
  g.edges.foldl (fun acc e =>
    if e.src == i && e.dst == j then acc + e.weight else acc) 0

def matrixBWith (g : WorkGraph) (damping : Rat) (i j : NodeId) : Rat :=
  (1 - damping) * matrixA g i j + damping / (g.nodes.length : Rat)

def matrixB (g : WorkGraph) (i j : NodeId) : Rat :=
  matrixBWith g alpha i j

def matrixRow (g : WorkGraph) (i : NodeId) : List Rat :=
  g.nodes.map (fun n => matrixB g i n.id)

def bMatrix (g : WorkGraph) : List (List Rat) :=
  g.nodes.map (fun n => matrixRow g n.id)

def nodeAt (g : WorkGraph) (i : Fin g.nodes.length) : PlanNode :=
  g.nodes.get i

def matrixAt (g : WorkGraph) (i j : Fin g.nodes.length) : Rat :=
  matrixB g (nodeAt g i).id (nodeAt g j).id

def weightsNonneg (g : WorkGraph) : Prop :=
  ∀ e ∈ g.edges, 0 ≤ e.weight

def estimatesNonneg (s : SchedulaState) : Prop :=
  ∀ n ∈ s.graph.nodes, 0 ≤ n.costEstimate ∧ 0 ≤ n.valueEstimate

def edgeWeightsMatchContrib (g : WorkGraph) : Prop :=
  ∀ e ∈ g.edges, e.weight = edgeContribSum e.contrib

def nodeIdsUnique (g : WorkGraph) : Prop :=
  (g.nodes.map (fun n => n.id)).Nodup

/--
  Entrywise positive B under alpha.
  The Prop is 0 < (1 - alpha) * A_ij + alpha / n for each node pair.
-/
def entryPositive (g : WorkGraph) : Prop :=
  ∀ n1 ∈ g.nodes, ∀ n2 ∈ g.nodes,
    0 < (1 - alpha) * matrixA g n1.id n2.id + alpha / (g.nodes.length : Rat)

def dampedMatrix (s : SchedulaState) : Prop :=
  1 ≤ s.graph.nodes.length ∧
    s.damping = alpha ∧
    weightsNonneg s.graph ∧
    estimatesNonneg s ∧
    edgeWeightsMatchContrib s.graph ∧
    nodeIdsUnique s.graph ∧
    entryPositive s.graph

/-
  Perron-Frobenius conditions on the damped matrix.
  Nonnegative, entrywise positive, and uniqueness up to a positive
  rational scale. Existence is the hypothesis slot on the state.
-/

def positiveOnNodes (g : WorkGraph) (v : NodeId → Rat) : Prop :=
  ∀ n ∈ g.nodes, 0 < v n.id

def applyB (g : WorkGraph) (v : NodeId → Rat) (i : NodeId) : Rat :=
  g.nodes.foldl (fun acc n => acc + matrixB g i n.id * v n.id) 0

def isPositiveEigenvector (g : WorkGraph) (v : NodeId → Rat) (lam : Rat) : Prop :=
  positiveOnNodes g v ∧
    ∀ n ∈ g.nodes, applyB g v n.id = lam * v n.id

def perronUniqueness (g : WorkGraph) : Prop :=
  ∀ v w : NodeId → Rat, ∀ lam : Rat,
    isPositiveEigenvector g v lam →
      isPositiveEigenvector g w lam →
        ∃ c : Rat, 0 < c ∧ ∀ n ∈ g.nodes, v n.id = c * w n.id

def bNonnegative (g : WorkGraph) : Prop :=
  ∀ n1 ∈ g.nodes, ∀ n2 ∈ g.nodes, 0 ≤ matrixB g n1.id n2.id

def perronFrobeniusConditions (s : SchedulaState) : Prop :=
  bNonnegative s.graph ∧
    entryPositive s.graph ∧
    perronUniqueness s.graph ∧
    s.hasPositiveEigenvector

/-
  Midpoint score order. Higher score first. Tie break is the lower NodeId.
  ruleChangedAfterData set true breaks conformance.
-/

def decisionRuleName : String := "midpoint score"

def listIndex (ids : List NodeId) (target : NodeId) : Option Nat :=
  match ids with
  | [] => none
  | head :: tail =>
      if head == target then
        some 0
      else
        match listIndex tail target with
        | none => none
        | some k => some (k + 1)

def listedBefore (ids : List NodeId) (a b : NodeId) : Prop :=
  ∃ i j, listIndex ids a = some i ∧ listIndex ids b = some j ∧ i < j

/-- Strict score order. topRank is above a finite score. Ties are not strict. -/
def strictScoreOrder (higher lower : Score) : Prop :=
  match higher, lower with
  | .topRank, .finite _ => (0 : Rat) < 1
  | .finite x, .finite y => y < x
  | _, _ => (0 : Rat) < 0

def monotoneScore (s : SchedulaState) : Prop :=
  ∀ c1 c2, c1 ∈ s.candidates → c2 ∈ s.candidates →
    strictScoreOrder (scoreOf c2) (scoreOf c1) →
      listedBefore s.claimedOrder c2.node c1.node

def totalOrder (s : SchedulaState) : Prop :=
  ∀ c1 c2, c1 ∈ s.candidates → c2 ∈ s.candidates →
    c1.node = c2.node ∨
      listedBefore s.claimedOrder c1.node c2.node ∨
        listedBefore s.claimedOrder c2.node c1.node

def stableOrder (s : SchedulaState) : Prop :=
  s.ruleChangedAfterData = false ∧
    s.decisionRuleVersion = decisionRuleNat ∧
    ∀ c1 c2, c1 ∈ s.candidates → c2 ∈ s.candidates →
      scoreOf c1 = scoreOf c2 →
        c1.node.val < c2.node.val →
          listedBefore s.claimedOrder c1.node c2.node

def noStoryPoints (s : SchedulaState) : Prop :=
  s.storyPointsUsed = false

def countsDisagree (r : LedgerRecord) : Prop :=
  r.providerCount ≠ r.harnessCount

def largerCount (r : LedgerRecord) : Nat :=
  max r.providerCount r.harnessCount

/-- When the counts differ, the record is flagged and the used count is the larger one. -/
def recordHonest (r : LedgerRecord) : Prop :=
  countsDisagree r → r.flagged = true ∧ r.usedCount = largerCount r

def ledgerHonest (s : SchedulaState) : Prop :=
  ∀ r ∈ s.ledger, recordHonest r

/-- newEstimate = (old * 4 + actual) / 5. -/
def linearPool (old actual : Rat) : Rat :=
  (old * (4 : Rat) + actual) / 5

/--
  If the estimate is not zero, the error ratio is actual divided by the estimate.
  If the estimate is zero, the ratio is undefined.
  A logarithm of that ratio is informative and is not computed.
-/
def errorRatioOf (estimate actual : Rat) : ErrorValue :=
  if estimate = 0 then
    ErrorValue.undefined
  else
    ErrorValue.ratio (actual / estimate)

def errorRatio (s : SchedulaState) : Prop :=
  s.estimator.loggedError = errorRatioOf s.estimator.estimate s.estimator.actual ∧
    (s.estimator.estimate = 0 → s.estimator.loggedError = ErrorValue.undefined) ∧
    (s.estimator.estimate ≠ 0 →
      s.estimator.loggedError = ErrorValue.ratio (s.estimator.actual / s.estimator.estimate))

/-- k is 4 and version is 1 for spec version 0.1.0. The posted value is the pool. -/
def estimatorRule (s : SchedulaState) : Prop :=
  s.estimator.k = 4 ∧
    s.estimator.version = decisionRuleNat ∧
    s.estimator.newEstimate = linearPool s.estimator.estimate s.estimator.actual ∧
    errorRatio s

/-- The five views, computed from the graph. Not a list conformance ignores. -/
def derivedViews (g : WorkGraph) : List ViewKind :=
  let _nodeCount := g.nodes.length
  [ ViewKind.kanban
  , ViewKind.gantt
  , ViewKind.mermaid
  , ViewKind.ranked
  , ViewKind.calibration
  ]

def estimatesLabeled (s : SchedulaState) : Prop :=
  s.estimatesLabeledFlag = true

def viewsDerived (s : SchedulaState) : Prop :=
  s.viewsEditedSeparately = false ∧
    s.views = derivedViews s.graph ∧
    estimatesLabeled s

def cocomoIsNotSchedule (s : SchedulaState) : Prop :=
  s.usesCocomoAsSchedule = false

def notShipped (s : SchedulaState) : Prop :=
  s.shippedService = false ∧ cocomoIsNotSchedule s

/-- The three planning edge kinds. depends on, enables, and competes for the same resource. -/
def edgeKindAllowed (k : EdgeKind) : Prop :=
  k = EdgeKind.dependsOn ∨ k = EdgeKind.enables ∨ k = EdgeKind.competesForResource

/-- A node that two or more other nodes depend on. -/
def isSharedPrerequisite (g : WorkGraph) (p : NodeId) : Prop :=
  ∃ a b : NodeId, a ≠ b ∧ a ≠ p ∧ b ≠ p ∧
    (∃ e ∈ g.edges, e.kind = EdgeKind.dependsOn ∧ e.src = a ∧ e.dst = p) ∧
    (∃ e ∈ g.edges, e.kind = EdgeKind.dependsOn ∧ e.src = b ∧ e.dst = p)

def hasSharedPrerequisite (g : WorkGraph) : Prop :=
  ∃ p : NodeId, isSharedPrerequisite g p

/-- An enables edge must not reverse a depends on edge. That pair would be a directed cycle. -/
def noEnableReversesDepend (g : WorkGraph) : Prop :=
  ∀ e1 ∈ g.edges, ∀ e2 ∈ g.edges,
    e1.kind = EdgeKind.enables →
      e2.kind = EdgeKind.dependsOn →
        ¬ (e1.src = e2.dst ∧ e1.dst = e2.src)

/-- A competes edge runs from the lower node identity to the higher node identity. -/
def competesLowToHigh (g : WorkGraph) : Prop :=
  ∀ e ∈ g.edges, e.kind = EdgeKind.competesForResource → e.src.val < e.dst.val

/-- No second magic. Specification 0011 remains the owner of the .sstt format. -/
def secondSsttMagic : Option String := none

/--
  Clause 4.1. It is a directed acyclic graph because it is a graph with no
  directed cycle. It is not a tree because it has shared prerequisites, and
  a tree has no shared prerequisite.
  The cycle ban is specification 0011 Clause 4.4. This encoding stores no
  second magic and no second edge layout.
-/
def graphClause (s : SchedulaState) : Prop :=
  workGraphHasNoDirectedCycle s.graph ∧
    hasSharedPrerequisite s.graph ∧
    (∀ e ∈ s.graph.edges, edgeKindAllowed e.kind) ∧
    noEnableReversesDepend s.graph ∧
    competesLowToHigh s.graph ∧
    (∀ n ∈ s.graph.nodes, 0 ≤ n.costEstimate ∧ 0 ≤ n.valueEstimate ∧ n.owner ≠ "") ∧
    secondSsttMagic = none

/--
  Clause 4.2. The ranking is the principal eigenvector of the damped
  nonnegative matrix, with the Perron-Frobenius conditions. Existence over
  the reals is not claimed. Uniqueness is up to a positive rational scale.
-/
def rankingClause (s : SchedulaState) : Prop :=
  dampedMatrix s ∧ perronFrobeniusConditions s

/-- Cost and benefit intervals are closed and the midpoints are zero or greater. -/
def intervalsRankable (s : SchedulaState) : Prop :=
  ∀ c ∈ s.candidates,
    0 ≤ mid c.cost ∧ 0 ≤ mid c.benefit ∧
      c.cost.lo ≤ c.cost.hi ∧ c.benefit.lo ≤ c.benefit.hi

/--
  Clause 4.3. Cost and benefit are intervals. The midpoint score rule is
  fixed before the data. Monotone, total, and stable stay inside this one conjunct.
-/
def decisionClause (s : SchedulaState) : Prop :=
  intervalsRankable s ∧ monotoneScore s ∧ totalOrder s ∧ stableOrder s

/--
  Clause 4.4. Seven named dimensions, each with a unit, a source, and the
  one seventh weight rule. A zero weight does not satisfy the strict inequality.
-/
def dimensionClause (s : SchedulaState) : Prop :=
  (∀ e ∈ s.graph.edges,
      e.weight = weightFromAssessment s.assessment ∧
      (∀ d : Dimension, e.contrib d = dimensionShareOf s.assessment d) ∧
      0 < e.weight ∧
      (∀ d : Dimension, 0 ≤ Assessment.get s.assessment d)) ∧
    s.graph.edges ≠ [] ∧
    dimensions.length = 7 ∧
    dimensionFacts.length = 7 ∧
    (∀ d : Dimension, dimensionShare d = share)

/--
  Clause 4.5. Estimates name input, output, and cached tokens and money.
  Story points do not conform. Wall time and operator minutes are separate fields.
-/
def estimateClause (s : SchedulaState) : Prop :=
  s.storyPointsUsed = false ∧
    s.tokenEstimates ≠ [] ∧
    ∀ e ∈ s.tokenEstimates,
      0 < e.tokensIn ∧
        0 ≤ e.tokensOut ∧
        0 ≤ e.tokensCached ∧
        0 ≤ e.money ∧
        0 ≤ e.wallTime ∧
        0 ≤ e.operatorMinutes ∧
        e.model ≠ "" ∧
        e.config ≠ ""

/--
  Clause 4.6. The ledger is on surmount-1. On a count disagreement the row
  is flagged and the used count is the larger number.
-/
def ledgerClause (s : SchedulaState) : Prop :=
  s.ledgerHost = ledgerHostName ∧
    s.ledger ≠ [] ∧
    ∀ r ∈ s.ledger,
      recordHonest r ∧
        0 ≤ r.tokensIn ∧
        0 ≤ r.tokensOut ∧
        0 ≤ r.tokensCached ∧
        0 ≤ r.money ∧
        0 ≤ r.wallTime

/--
  Clause 4.7. After a node finishes, the recorded error is the rational
  ratio and the linear pool update is fixed and versioned.
-/
def updateClause (s : SchedulaState) : Prop :=
  estimatorRule s ∧ ∃ n ∈ s.graph.nodes, n.status = Status.done

/-- A benchmark row names tokens, money, time, and a pass rate. -/
def benchComplete (b : BenchRow) : Prop :=
  0 ≤ b.tokens ∧ 0 ≤ b.money ∧ 0 ≤ b.time ∧
    0 ≤ b.passRate ∧ b.passRate ≤ 1 ∧ b.config ≠ ""

/--
  Clause 4.8. The same ledger benchmarks model configurations. An empty
  benchmark list fails this conjunct.
-/
def benchmarkClause (s : SchedulaState) : Prop :=
  s.benchmarks ≠ [] ∧
    ∀ b ∈ s.benchmarks, benchComplete b ∧ ∃ r ∈ s.ledger, r.config = b.config

/--
  Clause 4.9. Node cost estimates equal structuralCost of the Lean measure.
  Nix only pins and packages. This is not a Boolean field.
-/
def specEstimateClause (s : SchedulaState) : Prop :=
  (∀ n ∈ s.graph.nodes, n.costEstimate = structuralCost s.leanMeasure) ∧
    s.leanMeasure.clauseCount = 11 ∧
    s.leanMeasure.conformanceCount = 11 ∧
    0 < s.leanMeasure.encodedLineCount ∧
    0 < s.leanMeasure.proofObligationCount

/-- Relation to 0015: a conforming session bus is not claimed. -/
def sessionBusProgramClaimed : Bool := false

/-- Relation to 0016: a conforming hierarchical subagent program is not claimed. -/
def hierarchicalSubagentProgramClaimed : Bool := false

/--
  Clause 4.10. Kanban, Gantt, Mermaid, ranked list, and calibration are
  derived from the one stored graph. No network listener is stated by not
  claiming a session bus program.
-/
def viewsClause (s : SchedulaState) : Prop :=
  (∀ k : ViewKind, k ∈ derivedViews s.graph) ∧
    s.views = derivedViews s.graph ∧
    s.viewsEditedSeparately = false ∧
    sessionBusProgramClaimed = false ∧
    hierarchicalSubagentProgramClaimed = false

/-- Each candidate carries a closed interval. The midpoint is half the sum of the ends. -/
def carriesClosedInterval (c : Candidate) : Prop :=
  c.cost.lo ≤ c.cost.hi ∧
    c.benefit.lo ≤ c.benefit.hi ∧
    mid c.cost = (c.cost.lo + c.cost.hi) / 2 ∧
    mid c.benefit = (c.benefit.lo + c.benefit.hi) / 2

/--
  Clause 4.11. COCOMO is not a real cost. Estimates carry intervals.
  A conforming Schedula is not claimed. ShippedSchedula has no inhabitant.
-/
def honestyClause (s : SchedulaState) : Prop :=
  (∀ c ∈ s.candidates, carriesClosedInterval c) ∧
    s.candidates ≠ [] ∧
    s.usesCocomoAsSchedule = false ∧
    s.estimatesLabeledFlag = true ∧
    s.shippedService = false ∧
    conformingSchedulaClaimed = false ∧
    (ShippedSchedula → False)

/--
  Eleven conjuncts, one for each of Clause 4.1 through Clause 4.11.
  None is the constant True. Monotone, total, and stable sit inside decisionClause.
  An empty benchmark list fails benchmarkClause.
-/
def requiredConformance (s : SchedulaState) : Prop :=
  graphClause s ∧
    rankingClause s ∧
    decisionClause s ∧
    dimensionClause s ∧
    estimateClause s ∧
    ledgerClause s ∧
    updateClause s ∧
    benchmarkClause s ∧
    specEstimateClause s ∧
    viewsClause s ∧
    honestyClause s

/-
  Data for a later proof. Not theorems.
  exampleChain: node 0 depends toward node 1. One edge. Two node chain.
  exampleLoop: those two nodes each depend on the other. Two node loop.
-/

def zeroContrib : Dimension → Rat := fun _ => 0

def chainNode0 : PlanNode where
  id := ⟨0⟩
  costEstimate := 1
  valueEstimate := 1
  status := Status.opened
  owner := "a"
  evidence := []

def chainNode1 : PlanNode where
  id := ⟨1⟩
  costEstimate := 1
  valueEstimate := 1
  status := Status.opened
  owner := "b"
  evidence := []

def chainEdge : PlanEdge where
  src := ⟨0⟩
  dst := ⟨1⟩
  kind := EdgeKind.dependsOn
  weight := 0
  contrib := zeroContrib

def loopEdgeBack : PlanEdge where
  src := ⟨1⟩
  dst := ⟨0⟩
  kind := EdgeKind.dependsOn
  weight := 0
  contrib := zeroContrib

def exampleChain : WorkGraph where
  nodes := [chainNode0, chainNode1]
  edges := [chainEdge]

def exampleLoop : WorkGraph where
  nodes := [chainNode0, chainNode1]
  edges := [chainEdge, loopEdgeBack]

def chainWitnessWalk : List NodeId := [⟨0⟩, ⟨1⟩]

def loopWitnessWalk : List NodeId := [⟨0⟩, ⟨1⟩, ⟨0⟩]

/-
  Shared prerequisite witness. Node 0 is required by node 1 and by node 2.
  Clause 4.1: it is not a tree because it has shared prerequisites, and a
  tree has no shared prerequisite. Both edges use the one seventh weight
  rule with assessment value one sixth, so each weight is one sixth, not zero.
-/

def oneSixth : Rat := (1 : Rat) / 6

def sixthAssessment : Assessment where
  productValue := oneSixth
  revenue := oneSixth
  riskReduction := oneSixth
  unblocking := oneSixth
  operatorTime := oneSixth
  computeTokens := oneSixth
  calendarTime := oneSixth

/-- Each dimension contributes one forty second. Seven of those sum to one sixth. -/
def sixthContrib : Dimension → Rat := fun _ => (1 : Rat) / 42

def prereqNode : PlanNode where
  id := ⟨0⟩
  costEstimate := 321
  valueEstimate := 1
  status := Status.done
  owner := "a"
  evidence := ["0017_Schedula.md"]

def leftNode : PlanNode where
  id := ⟨1⟩
  costEstimate := 321
  valueEstimate := 1
  status := Status.opened
  owner := "b"
  evidence := ["0017_Schedula.md"]

def rightNode : PlanNode where
  id := ⟨2⟩
  costEstimate := 321
  valueEstimate := 1
  status := Status.opened
  owner := "c"
  evidence := ["0017_Schedula.md"]

def leftDepends : PlanEdge where
  src := ⟨1⟩
  dst := ⟨0⟩
  kind := EdgeKind.dependsOn
  weight := (1 : Rat) / 6
  contrib := sixthContrib

def rightDepends : PlanEdge where
  src := ⟨2⟩
  dst := ⟨0⟩
  kind := EdgeKind.dependsOn
  weight := (1 : Rat) / 6
  contrib := sixthContrib

def sharedPrereqGraph : WorkGraph where
  nodes := [prereqNode, leftNode, rightNode]
  edges := [leftDepends, rightDepends]

end SchedulaSpec
