# Schedula

> v0.1.0 - 20261026
>
> The contract for an automated project manager that plans where Surmount spends its time from evidence

## 1. Scope

This document specifies Schedula, the Surmount Systems Scientific Scheduling Service. Schedula is the contract for an automated project manager that plans where Surmount spends its time from evidence. The contract covers the work graph, ranking, cost and benefit, the seven dimensions, estimates, the ledger, the update of estimates, the benchmark, estimates taken from specifications, the service and its views, and honesty about those estimates.

This specification is number 0017. The file name is `0017_Schedula.md`.

Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) and Semantic Versioning 2.0.0 (SemVer). The local path for SemVer is [ref/semver](ref/semver). First publication of this specification is version 0.1.0 dated 20261026. No earlier shipped version of this specification is claimed.

[0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md) remains the owner of the `.sstt` format. This document does not define a second magic or a second edge layout.

A conforming Schedula is not claimed.

This document does not claim a conforming session bus (specification 0015, [0015_Session_Bus.md](0015_Session_Bus.md)) or a conforming hierarchical subagent program (specification 0016, [0016_Hierarchical_Subagents.md](0016_Hierarchical_Subagents.md)).

fargo has no assigned number. The Carbonado Network Protocol has no assigned number. This document does not assign number 0017 to fargo or to Carbonado, and this document does not create a file for either.

Concise American Technical English is specified in [0005_CATE.md](0005_CATE.md). CATE is specification 0005. CATE is not this specification.

### 1.1 Name

The name Schedula comes from the Latin schedula, a small sheet of paper. That Latin word is the root of the English word schedule. In this specification Schedula is the Surmount Systems Scientific Scheduling Service.

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to proofs checked by machine. It is not a form rule under [0000_spec.md](0000_spec.md).

The numbered markdown is the contract humans read. The specification is also encoded in Lean as declarations of what must be true. Proofs live in a separate module. Lean proofs are not the specification. Formal Vibefication, as specified in [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md), asks for that split. `lean/SchedulaSpec.lean`, the sibling `0017_Schedula.lean`, and `lean/Proofs_0017.lean` are not this specification.

1. The numbered markdown is the contract humans read.
2. `lean/SchedulaSpec.lean` encodes this specification as declarations of what must be true.
3. Proofs live in a separate module.
4. The sibling line encoding is `0017_Schedula.lean`.
5. `lean/Proofs_0017.lean` is the separate module named for proofs of that sibling line encoding.
6. Lean proofs are not the specification.
7. `lean/SchedulaSpec.lean`, `0017_Schedula.lean`, and `lean/Proofs_0017.lean` are not this specification.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: [ref/rfc2119](ref/rfc2119).
2. Semantic Versioning 2.0.0 (SemVer). Local path: [ref/semver](ref/semver).
3. Surmount specification [0005_CATE.md](0005_CATE.md).
4. Surmount specification [0008_Formal_Vibefication.md](0008_Formal_Vibefication.md).
5. Surmount specification [0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md).
6. Surmount specification [0015_Session_Bus.md](0015_Session_Bus.md).
7. Surmount specification [0016_Hierarchical_Subagents.md](0016_Hierarchical_Subagents.md).

## 3. Terms

1. The work graph means the directed graph Schedula uses for planning. It is built on the encoded graph of specification 0011. Clause 4.1 states its properties.
2. A shared prerequisite means a node that two or more other nodes depend on.
3. A directed acyclic graph means a directed graph with no directed cycle. In this specification the work graph is a directed acyclic graph. It is not a tree, because a tree has no shared prerequisite.
4. An estimate means a predicted cost or a predicted benefit for a node, written as a closed interval of rational numbers. An estimate is not a measured actual.
5. A ledger record means a stored row for a node that names tokens (input, output, and cached), money, the time a clock on the wall measures, the model, and the configuration.
6. A model configuration means the named model and the named settings a job used, so two runs can be compared.
7. A view means a presentation derived from the stored work graph. A view is not a second store.

## 4. Requirements

The keywords MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 4.1 Work graph

Schedula models work as a directed graph with no directed cycle, built on the encoded graph of [0011_Surmount_Systems_Tech_Tree.md](0011_Surmount_Systems_Tech_Tree.md). Clause 4.4 of that specification requires a graph with no directed cycle. This work graph follows those words. Specification 0011 remains the owner of the `.sstt` format. This document SHALL NOT define a second magic or a second edge layout.

1. The work graph SHALL be a graph with no directed cycle.
2. Node properties for planning SHALL be the cost estimate, the value estimate, the status, the owner, and the evidence links.
3. The cost estimate SHALL be the expected cost interval in Clause 4.3. The value estimate SHALL be the expected benefit interval in Clause 4.3.
4. The status SHALL be one of open, active, done, or dropped. A status outside that list does not conform.
5. The owner SHALL be the recorded name of the party responsible for the node.
6. Evidence links SHALL be references to the records that support the node. They are not a second edge layout.
7. The edge kinds a planner needs SHALL be depends on, enables, and competes with for the same resource.
8. A depends on edge SHALL go from the node that depends to the node it needs.
9. An enables edge SHALL go from the node that enables to the node that becomes possible. An enables edge SHALL NOT reverse a depends on edge between the same pair, because that pair would be a directed cycle.
10. A competes with edge means the two nodes compete for the same resource. It SHALL be one directed edge, from the lower node identity to the higher node identity in the fixed order of Clause 4.2. It SHALL NOT be stored as two opposite edges, because two opposite edges are a directed cycle.
11. If an edge set would contain a directed cycle, that graph does not conform.
12. The work graph SHALL have at least one shared prerequisite. The graph has shared prerequisites and is a directed acyclic graph and not a tree.
13. It is a directed acyclic graph because it is a graph with no directed cycle. It is not a tree because it has shared prerequisites, and a tree has no shared prerequisite.
14. Node identity SHALL be the position in the fixed order of Clause 4.2. A lower position is the lower identity.

### 4.2 Ranking by eigenvector

The ranking is the principal eigenvector of a weighted matrix over the work graph, in the sense of eigenvector centrality. The matrix is zero or greater in every entry before damping, and the damped matrix B is positive in every entry. Clause 6 records the open question on real number existence.

1. The finite node list SHALL be indexed in a fixed order. Let n be the node count.
2. Let A be the matrix whose entry from i to j is the weight of the edges from i to j, or zero when there is no edge. When more than one edge runs from i to j, that entry SHALL be the sum of those weights.
3. Weights come from the seven dimensions in Clause 4.4 and are zero or greater.
4. Version 0.1.0 fixes a damping constant alpha equal to one fifth.
5. For n at least 1, the damped matrix B has, in every entry, (1 - alpha) times the matching entry of A, plus alpha divided by n.
6. Alpha equal to one fifth means one minus alpha is four fifths, which is positive. Each entry of A is zero or greater, so (1 - alpha) times that entry is zero or greater. For n at least 1, alpha divided by n is positive. The sum of those two rationals is positive.
7. Every entry of B is positive, and every entry of B is zero or greater. Positive entries give the nodes one positive class of nodes, so that a unique positive principal eigenvector exists when one exists.
8. When n is 0, there is no matrix B and there is no ranking.
9. A damping term of this kind is the same idea as PageRank.
10. PageRank and eigenvector centrality are informative prior art and are not a normative pin under `ref/` unless a later worker adds a real publisher pin. This document does not invent a mirror or a URL for that prior art.
11. The Perron-Frobenius conditions that determine the ranking are these: B is zero or greater in every entry, B is positive in every entry, and a positive eigenvector is unique up to a positive scale when one exists.
12. This document does not claim that a complete ordered field in the Lean prelude supplies that eigenvector.
13. The prelude defines rational numbers and does not define the real numbers.
14. Existence over the reals is not claimed.
15. The Lean encoding states these conditions.
16. When a positive eigenvector exists, the report SHALL order nodes by the matching entry from high to low. A positive scale does not change that order. Break a tie by node identity from low to high, so the lower identity ranks above the higher identity.
17. When no positive eigenvector exists, Clause 4.2 does not produce an order. Clause 4.3 does not wait on that eigenvector.

### 4.3 Cost benefit analysis

Each candidate task has an expected cost and an expected benefit. The decision rule is named midpoint score. The rule is defined before any data is seen.

1. Each of expected cost and expected benefit SHALL be a closed interval of rational numbers, with the low end less than or equal to the high end.
2. The midpoint SHALL be half the sum of the ends.
3. The cost midpoint MUST be zero or greater, and the benefit midpoint MUST be zero or greater. A negative cost midpoint does not conform. A negative benefit midpoint does not conform, because a cheaper task could then receive a lower ratio and the comparison below would reverse.
4. The decision rule is defined before any data is seen and MUST NOT be changed after the data is seen.
5. Version 0.1.0 defines the rule as follows, and the name of the rule is midpoint score.
6. When the cost midpoint is positive, the score SHALL be the benefit midpoint divided by the cost midpoint.
7. When the cost midpoint is zero and the benefit midpoint is positive, that candidate is in the top class and ranks above every candidate with a positive cost midpoint. Inside the top class, order by benefit midpoint from high to low.
8. When both midpoints are zero, the score SHALL be zero.
9. Order by the top class first, then by score from high to low.
10. When that key ties, the task with the lower cost midpoint ranks above the other if the cost midpoints differ. When the cost midpoints are also equal, the task with the higher benefit midpoint ranks above the other if the benefit midpoints differ.
11. When both midpoints are equal, break the tie by node identity from low to high, so the lower identity ranks above the higher identity.
12. If task A has a cost midpoint less than or equal to task B, and a benefit midpoint greater than or equal to task B, and A and B are not equal on both midpoints, then A never ranks lower than B.
13. The ordering of conforming candidates is total and stable: the same inputs always produce the same order.

### 4.4 Net assessment across dimensions

The assessment is a vector of seven numbers. A report shows every dimension. The edge weight used by Clause 4.2 is the sum of seven shares. Clause 6 asks the operator whether to keep this list and these shares.

1. Product value. The unit is a rational score from recorded acceptance evidence. The source is the numbered specification and the operator's acceptance of a landed result. It adds to benefit.
2. Revenue for Surmount. The unit is rational money. The source is a recorded payment or a recorded contract amount. It adds to benefit.
3. Risk reduction. The unit is a rational score from a recorded risk note. The source is that note. It adds to benefit.
4. Unblocking other work. The unit is a count of successor nodes this node enables. The source is the work graph. It adds to benefit.
5. Operator time. The unit is operator minutes. The source is a record the operator or the harness wrote. It adds to cost.
6. Compute and tokens. The unit is token counts (input, output, and cached) and rational money. The source is the ledger in Clause 4.6. It adds to cost.
7. Calendar time. The unit is the time a clock on the wall measures. The source is the ledger. It adds to cost.

The assessment is a vector of these seven numbers, never a single collapsed factor, and a report MUST show every dimension.

For compute and tokens, the vector number is the recorded rational money, and the report still shows the input token count, the output token count, and the cached token count. Those counts are not added to the money. For each other dimension, the vector number is the rational named by that dimension's unit. A count is used as a rational. A duration is the rational stored in the ledger.

Each vector number that enters an edge weight MUST be zero or greater.

Version 0.1.0 sets each dimension's share of an edge weight to one seventh.

Each share equals that dimension's vector number times one seventh. The edge weight is the sum of the seven shares. The seven coefficients are each one seventh, and those seven coefficients sum to one. Version 0.1.0 does not convert these units into one unit before that sum. The edge weight sums the seven shares and stays zero or greater. It is not benefit minus cost. Clause 4.3 compares benefit with cost.

Version 0.1.0 stores the expected cost interval and the expected benefit interval for Clause 4.3. It stores the seven dimension numbers for this clause. It does not define a rule that sets the intervals equal to a sum of those numbers.

This list and these shares are a 0.1.0 starting point.

### 4.5 Estimates in tokens, not points

The primary estimate for AI work is tokens and money. Story points do not conform. Only measured evidence counts.

1. The primary estimate for AI work SHALL be tokens (input, output, and cached) and money for each model configuration.
2. The time a clock on the wall measures, and operator minutes, are separate measured dimensions in Clause 4.4.
3. Story points are not allowed. A record that uses story points does not conform.
4. AI changed what work costs, so a task that used to take months can take hours, and only measured evidence counts.
5. An unmeasured guess SHALL NOT be treated as evidence.

### 4.6 Granular cost and token accounting

Every agent session, job, and tool call that does work for a node records a ledger row for that node. The ledger's host is `surmount-1`. The service is not built. The place each provider's usage report comes from is not pinned. Clause 6 records that fact.

1. The row SHALL record tokens (input, output, and cached), money, the time a clock on the wall measures, the model, and the configuration, attributed to that node.
2. Records come from the provider's own usage report and SHALL be checked against an independent count kept by the harness.
3. When the two counts disagree, the record SHALL flag the disagreement and SHALL use the larger number until the gap is explained.
4. A kept ledger SHALL live on `surmount-1`.

### 4.7 Estimates that keep improving

After each node finishes, Schedula compares the estimate with the measured cost and updates its estimator. The update rule is named linear pool. Clause 6 asks the operator whether to keep k equal to 4.

1. The recorded error metric SHALL be the rational ratio of actual to estimate when the estimate is not zero.
2. When the estimate is zero, the ratio is undefined and the record says so.
3. The ratio and the update apply to each recorded quantity: input tokens, output tokens, cached tokens, and money.
4. The logarithm of that ratio is an informative reading. It is not a computed real number, because the pinned Lean prelude does not define the real numbers.
5. Calibration SHALL be reported over time.
6. The estimator's update rule is fixed before use, carries a version, and changes only by a new specification version.
7. Version 0.1.0 names the rule linear pool with k equal to 4.
8. The new estimate equals (old estimate times 4 plus actual) divided by (4 plus 1).

### 4.8 Benchmark of model configurations

The same ledger is a benchmark. The operator can choose configurations from evidence.

1. Two nodes are comparable when the report uses the same structural measures from Clause 4.9 for both.
2. For comparable nodes, a report SHALL show tokens, money, the time a clock on the wall measures, and pass rate for each model configuration.
3. Pass rate SHALL be the count of passing runs divided by the count of runs, when the count of runs is not zero. When the count of runs is zero, the pass rate is undefined and the report says so.

### 4.9 Estimates from formal specs

An estimate for a node is derived from its numbered specification and its Lean encodings. The measures are structural. They are not a guess. The symbolic tool is not built. Clause 6 records that fact.

1. An estimate for a node SHALL be derived from its numbered specification and its Lean encodings.
2. The measures SHALL include clause count, conformance conjunct count, encoded line count, and proof obligation count, and MAY include similar structural measures.
3. Symbolic tools written in Lean 4 compute these measures.
4. Nix is used only for pinning and packaging.
5. This does not contradict specification 0006, [0006_RSI.md](0006_RSI.md). A chat reminder is not a durable tool, and check policy is not a new Python or shell script.

### 4.10 Task tracking service

Schedula runs as a service on `surmount-1` that stores nodes, status, and the ledger, and offers views derived from that store. The service, the views, and the ledger are not built. Clause 6 records that fact.

1. The service SHALL store nodes, status, and the ledger on `surmount-1`.
2. The views SHALL be a kanban board, a Gantt chart, a Mermaid diagram of the graph, a ranked list, and a calibration report.
3. All views SHALL be derived from the same stored graph and SHALL NOT be edited as a separate store.
4. Relation to specification 0015: the service MUST NOT open a network listener, and it does not claim a conforming session bus.
5. Relation to specification 0016: the service MAY attribute a ledger row to work that specification calls a coordinator or a specialist, and it does not claim a conforming hierarchical subagent program.

### 4.11 Honesty

COCOMO stays fun and is not a real cost or schedule, as [0005_CATE.md](0005_CATE.md) Clause 4.11 item 2 says. That item says COCOMO is fun and is not a real cost or schedule. Schedula's own estimates are labeled as estimates with intervals. A conforming Schedula is not claimed.

1. Authors SHALL NOT treat COCOMO as a real cost or schedule.
2. Schedula's own estimates SHALL be labeled as estimates with intervals.
3. A conforming Schedula is not claimed.

## 5. Required Conformance

Required conformance to this specification holds if and only if every item in this list holds. The list has 11 items, one for each of Clause 4.1 through Clause 4.11.

1. The work graph is a graph with no directed cycle in the words of specification 0011 Clause 4.4, it is built on that encoded graph, it uses the planning properties and the edge kinds in Clause 4.1, it has shared prerequisites, and it is a directed acyclic graph and not a tree (Clause 4.1).
2. The ranking is defined as the principal eigenvector of the damped matrix B in Clause 4.2, with alpha equal to one fifth and with the Perron-Frobenius conditions stated in that clause, and existence over the reals is not claimed (Clause 4.2).
3. The midpoint score rule in Clause 4.3 is defined before any data is seen and MUST NOT be changed after the data is seen, and the ordering is total and stable (Clause 4.3).
4. The seven dimensions in Clause 4.4 are shown in every report, and version 0.1.0 sets each dimension's share of an edge weight to one seventh (Clause 4.4).
5. The primary estimate is tokens (input, output, and cached) and money, story points do not conform, and an unmeasured guess is not evidence (Clause 4.5).
6. A ledger record attributes tokens, money, the time a clock on the wall measures, the model, and the configuration to a node, flags a count disagreement, and uses the larger number until the gap is explained (Clause 4.6).
7. After a node finishes, the error record and the linear pool update with k equal to 4 in Clause 4.7 hold (Clause 4.7).
8. For comparable nodes, a report shows tokens, money, the time a clock on the wall measures, and pass rate for each model configuration (Clause 4.8).
9. An estimate is derived from the structural measures in Clause 4.9, symbolic tools written in Lean 4 compute those measures, and Nix is used only for pinning and packaging (Clause 4.9).
10. The service does not open a network listener, the views in Clause 4.10 are derived from the same stored graph, and this document does not claim a conforming session bus or a conforming hierarchical subagent program (Clause 4.10).
11. COCOMO is fun and is not a real cost or schedule, estimates are labeled as estimates with intervals, and a conforming Schedula is not claimed (Clause 4.11).

A conforming Schedula is not claimed.

This markdown file is not itself a running service.

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. Naming a file only in Scope is not the residual record. This clause is the residual record for this specification.

### 6.1 What remains unfinished

1. A conforming Schedula is not claimed.
2. The service, the views, and the ledger are not built.
3. Provider usage report sources are not pinned.
4. Eigenvector centrality and PageRank are informative prior art and are not pinned under `ref/` unless a worker adds a real publisher pin. This document does not invent a mirror.
5. The dimension list and the one seventh shares are a 0.1.0 starting point and need operator review.
6. The symbolic measure tool is not built.
7. fargo has no assigned number. Carbonado has no assigned number. This document does not create a file for either.
8. Specification 0015 and specification 0016 are cited and neither conforming program is claimed.
9. Real number existence for the principal eigenvector is not proved. The working path is rational theorems.

### 6.2 Question A, Clause 4.2

The question for Clause 4.2 of `0017_Schedula.md` is this: should this publication keep the sentence "Existence over the reals is not claimed." and leave real existence unproved, or should a later version construct the real numbers?

The current wording is "Existence over the reals is not claimed."

The choice matters because the ranking is defined as a principal eigenvector, and the pinned Lean prelude has no complete ordered field.

1. Option 1 is to keep the rational theorems and leave real existence unproved, which is the working path this document already takes.
2. Option 2 is to construct the reals inside the proof module without `mathlib`.
3. Option 3 is to allow `mathlib` only if `AGENTS.md` is changed.
4. For option 1 the worker leaves the rational statements.
5. For option 2 the worker would add a real construction in a later version, not in this publication.
6. For option 3 the worker does nothing until `AGENTS.md` changes, and this publication does not take option 3.

### 6.3 Question B, Clause 4.4

The question for Clause 4.4 of `0017_Schedula.md` is this: should version 0.1.0 keep equal shares of one seventh, or should the operator name seven other shares that sum to one for a later version?

The current wording is "Version 0.1.0 sets each dimension's share of an edge weight to one seventh."

The choice matters because the shares change which work ranks first.

1. Option 1 is to keep one seventh until the operator names other shares.
2. Option 2 is that the operator names seven shares that sum to one and a later version records them.
3. For option 1 the worker publishes one seventh.
4. For option 2 the worker does not invent shares in this version.

### 6.4 Question C, Clause 4.7

The question for Clause 4.7 of `0017_Schedula.md` is this: should version 0.1.0 keep k equal to 4, or should the operator name another positive integer for a later version?

The current wording is "Version 0.1.0 names the rule linear pool with k equal to 4."

The choice matters because k controls how fast the estimate moves after one measured actual.

1. Option 1 is to keep k equal to 4 for version 0.1.0.
2. Option 2 is that the operator names another positive integer and a later version records it.
3. For option 1 the worker publishes k equal to 4.
4. For option 2 the worker does not change k in this version.

## 7. Changelog

### 0.1.0 - 20261026

First publication of Schedula as numbered specification 0017 with file name `0017_Schedula.md`. Records the work graph with no directed cycle, ranking by the principal eigenvector, the midpoint score rule, seven dimensions with one seventh shares, estimates in tokens, the ledger, the linear pool update, the benchmark, estimates from formal specs, the task tracking service, and honesty about COCOMO. A conforming Schedula is not claimed.

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense as specified in [0009_PDOSS.md](0009_PDOSS.md). Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See [UNLICENSE.md](UNLICENSE.md) in this repository.
