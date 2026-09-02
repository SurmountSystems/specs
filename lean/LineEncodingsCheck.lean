/-
  line_encodings_check - Lean entry point for isomorphism of numbered
  specification markdown lines and sibling NNNN_descriptive.lean encodings.

  Usage:
    line_encodings_check
  Environment: REPO_ROOT overrides the default discovery root (cwd).

  Exit 0 on success, 1 on drift, 2 on usage errors.
-/

import MdLine
import LineEncodings
import SpecProofs
import «0000_spec»
import «0001_DOGE»
import «0002_Systems_Lean»
import «0003_beastdb»
import «0004_SSSSS»
import «0005_CATE»
import «0006_RSI»
import «0007_CI»
import «0008_Formal_Vibefication»
import «0009_PDOSS»
import «0010_Surmount_Systems»
import «0011_Surmount_Systems_Tech_Tree»
import «0012_Majestic_Memex»
import «0013_Lean_Machine»

open LineEncodings

def usage : String :=
  "Usage: line_encodings_check\n" ++
  "\n" ++
  "Fail when a numbered specification markdown line has no Lean encoding\n" ++
  "or an encoding has no matching markdown line.\n" ++
  "Fail when a sibling NNNN_descriptive.lean contains include_str.\n" ++
  "The encoding must be explicit MdLine or String literals, one per\n" ++
  "physical markdown line. include_str is not a line encoding.\n" ++
  "Compiled encodedLines must still match the markdown bytes (LF lines).\n" ++
  "Fail when compiled encodedLines contain leftover unstack phrases in\n" ++
  "prose outside fenced code and inline code (Cate.leftoverUnstackPhrases,\n" ++
  "same scan as spec_check).\n" ++
  "Fail when comments in marked meaning spec encoding modules\n" ++
  "contain those leftover phrases.\n" ++
  "That leftover unstack check is a floor, not complete English.\n" ++
  "Environment: REPO_ROOT overrides the default discovery root.\n"

def resolveRepoRoot : IO System.FilePath := do
  match (← IO.getEnv "REPO_ROOT") with
  | some r => return ⟨r⟩
  | none => IO.currentDir

def ofSpec
    (specNumber : Nat)
    (specFileName siblingEncodingFileName proofModuleName : String)
    (markedAsSpecEncoding markedAsProof : Bool)
    (lines : Array MdLine) : EncodedSpec :=
  { specNumber
    specFileName
    siblingEncodingFileName
    proofModuleName
    markedAsSpecEncoding
    markedAsProof
    lines }

def compiledEncodings : Array EncodedSpec :=
  #[
    ofSpec «0000_spec».specNumber «0000_spec».specFileName
      «0000_spec».siblingEncodingFileName «0000_spec».proofModuleName
      «0000_spec».markedAsSpecEncoding «0000_spec».markedAsProof
      «0000_spec».encodedLines,
    ofSpec «0001_DOGE».specNumber «0001_DOGE».specFileName
      «0001_DOGE».siblingEncodingFileName «0001_DOGE».proofModuleName
      «0001_DOGE».markedAsSpecEncoding «0001_DOGE».markedAsProof
      «0001_DOGE».encodedLines,
    ofSpec «0002_Systems_Lean».specNumber «0002_Systems_Lean».specFileName
      «0002_Systems_Lean».siblingEncodingFileName «0002_Systems_Lean».proofModuleName
      «0002_Systems_Lean».markedAsSpecEncoding «0002_Systems_Lean».markedAsProof
      «0002_Systems_Lean».encodedLines,
    ofSpec «0003_beastdb».specNumber «0003_beastdb».specFileName
      «0003_beastdb».siblingEncodingFileName «0003_beastdb».proofModuleName
      «0003_beastdb».markedAsSpecEncoding «0003_beastdb».markedAsProof
      «0003_beastdb».encodedLines,
    ofSpec «0004_SSSSS».specNumber «0004_SSSSS».specFileName
      «0004_SSSSS».siblingEncodingFileName «0004_SSSSS».proofModuleName
      «0004_SSSSS».markedAsSpecEncoding «0004_SSSSS».markedAsProof
      «0004_SSSSS».encodedLines,
    ofSpec «0005_CATE».specNumber «0005_CATE».specFileName
      «0005_CATE».siblingEncodingFileName «0005_CATE».proofModuleName
      «0005_CATE».markedAsSpecEncoding «0005_CATE».markedAsProof
      «0005_CATE».encodedLines,
    ofSpec «0006_RSI».specNumber «0006_RSI».specFileName
      «0006_RSI».siblingEncodingFileName «0006_RSI».proofModuleName
      «0006_RSI».markedAsSpecEncoding «0006_RSI».markedAsProof
      «0006_RSI».encodedLines,
    ofSpec «0007_CI».specNumber «0007_CI».specFileName
      «0007_CI».siblingEncodingFileName «0007_CI».proofModuleName
      «0007_CI».markedAsSpecEncoding «0007_CI».markedAsProof
      «0007_CI».encodedLines,
    ofSpec «0008_Formal_Vibefication».specNumber «0008_Formal_Vibefication».specFileName
      «0008_Formal_Vibefication».siblingEncodingFileName «0008_Formal_Vibefication».proofModuleName
      «0008_Formal_Vibefication».markedAsSpecEncoding «0008_Formal_Vibefication».markedAsProof
      «0008_Formal_Vibefication».encodedLines,
    ofSpec «0009_PDOSS».specNumber «0009_PDOSS».specFileName
      «0009_PDOSS».siblingEncodingFileName «0009_PDOSS».proofModuleName
      «0009_PDOSS».markedAsSpecEncoding «0009_PDOSS».markedAsProof
      «0009_PDOSS».encodedLines,
    ofSpec «0010_Surmount_Systems».specNumber «0010_Surmount_Systems».specFileName
      «0010_Surmount_Systems».siblingEncodingFileName «0010_Surmount_Systems».proofModuleName
      «0010_Surmount_Systems».markedAsSpecEncoding «0010_Surmount_Systems».markedAsProof
      «0010_Surmount_Systems».encodedLines,
    ofSpec «0011_Surmount_Systems_Tech_Tree».specNumber «0011_Surmount_Systems_Tech_Tree».specFileName
      «0011_Surmount_Systems_Tech_Tree».siblingEncodingFileName
      «0011_Surmount_Systems_Tech_Tree».proofModuleName
      «0011_Surmount_Systems_Tech_Tree».markedAsSpecEncoding
      «0011_Surmount_Systems_Tech_Tree».markedAsProof
      «0011_Surmount_Systems_Tech_Tree».encodedLines,
    ofSpec «0012_Majestic_Memex».specNumber «0012_Majestic_Memex».specFileName
      «0012_Majestic_Memex».siblingEncodingFileName
      «0012_Majestic_Memex».proofModuleName
      «0012_Majestic_Memex».markedAsSpecEncoding
      «0012_Majestic_Memex».markedAsProof
      «0012_Majestic_Memex».encodedLines,
    ofSpec «0013_Lean_Machine».specNumber «0013_Lean_Machine».specFileName
      «0013_Lean_Machine».siblingEncodingFileName
      «0013_Lean_Machine».proofModuleName
      «0013_Lean_Machine».markedAsSpecEncoding
      «0013_Lean_Machine».markedAsProof
      «0013_Lean_Machine».encodedLines
  ]

def main (args : List String) : IO UInt32 := do
  if args.contains "-h" || args.contains "--help" then
    IO.println usage
    return 0
  if !args.isEmpty then
    IO.eprintln usage
    return 2
  if !SpecProofs.encodingsNotMashed then
    IO.eprintln "line_encodings_check: sibling encodings are mashed with proofs"
    return 1
  let repo ← resolveRepoRoot
  let findings ← checkRepo repo compiledEncodings
  if findings.isEmpty then
    IO.println s!"line_encodings_check: {compiledEncodings.size} sibling encodings match"
    return 0
  for f in findings do
    IO.eprintln (Finding.format f)
  IO.eprintln s!"line_encodings_check: {findings.size} finding(s)"
  return 1
