/-
  Barrel for sibling line encodings at the repository root.

  Lake TOML cannot list quoted module names that start with a digit.
  This module imports each encoding so `lake build SpecEncodings`
  typechecks them. The encoding files keep the markdown basename with
  `.lean` in place of `.md`. Proofs stay in `lean/Proofs_NNNN.lean`.
-/

import «0000_spec»
import «0001_DOGE»
import «0002_Systems_Lean»
import «0003_beastdb»
import «0004_SSSSS»
import «0005_CATE»
import «0006_RSI»
import «0007_CI»
import «0008_Formal_Vibefication»
import «0009_Unlicense»
import «0010_Surmount_Systems»
import «0011_Surmount_Systems_Tech_Tree»
import «0012_Majestic_Memex»
