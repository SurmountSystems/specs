# Tool template (RSI)

Companion to `.agents/skills/rsi/SKILL.md`. Authority: `0006_RSI.md` Clauses 4.1 and 4.2, and `0000_spec.md` Clause 17.1. Prose: `0005_CATE.md`.

## Pick the tool that can state the theorem

| Job | Tool | Not |
|-----|------|-----|
| Form, leftover unstack, residual heading, registry, spelling on numbered specifications | Lean `spec_check` | bash or Python stuffed in Nix |
| CATE, RSI, Systems Lean, beastdb, or SSSSS meaning of selected clauses | Lean companion library plus its test executable | A second markdown linter |
| Trailing whitespace and tab indent across this repository | Pure Nix `checks.whitespace` | Moving that rule into Lean for symmetry |
| Encoding a numbered specification | Project skill `/surmount-specify` | A disposable chat pass |
| Isomorphism of numbered markdown lines and sibling `Spec_NNNN.lean` | Lean `line_encodings_check` over explicit `MdLine` or `String` literals | `include_str` of the markdown or a disposable job |
| Unique English words in Surmount authored markdown versus the CATE catalog | Lean `word_stats` writing and checking root `WORD_STATS.md` | A disposable count or a second catalog |
| Agent workflow a later session can run | Project skill under `.agents/skills/` | A reminder in chat |
| Tests that compile in a product tree that already requires a remote builder | That builder | A weaker local compile invented as proof |
| Proving companion Lean meaning models in this repository | Project skill `/lean4` (pack at `skills/lean4-skills`) | mathlib, `sorry`, or `lake build` as the only gate |

Discard a broken tool rather than keep it because it is familiar. If a stronger tool can state the theorem, use it.

## File names and homes

1. Lean checkers live under `lean/` with a flake check. No `sorry`. No mathlib.
2. Pure Nix checks live under `nix/` with `checks.` in `flake.nix`. Success is `writeText`. Failure is `throw`.
3. Project skills live under `.agents/skills/<name>/SKILL.md`. Not `~/.grok`. Not `.grok/skills/`.
4. Reports live under `~/.agents/reports/` on this machine. They are not git.
5. Names a tired human can parse. No plan step codes in paths.

## Proof order

1. Write or name the in-tree test for the contract in ordinary English.
2. Run it. Observe the fail.
3. Smallest product edit that makes that same test pass.
4. Re-run the same filter.
5. Reconcile a contract change with `0006_RSI.md` or the named specification in the same effort.

## Residual honesty

Write unpublished specifications, unassigned numbers, unpinned prior art, unimplemented requirements, and out of scope items in complete sentences. Silence is nonconforming. Do not claim a conforming product exists unless the operator says it exists.

## Gate

```
nix flake check "path:$PWD" --print-build-logs
```

No new Python or shell checkers that float free of Nix.
