/-
  line_encodings_check - Lean entry point for isomorphism of numbered
  specification markdown lines and sibling Spec_NNNN.lean encodings.

  Usage:
    line_encodings_check
  Environment: REPO_ROOT overrides the default discovery root (cwd).

  Exit 0 on success, 1 on drift, 2 on usage errors.
-/

import MdLine
import LineEncodings
import SpecProofs
import Spec_0000
import Spec_0001
import Spec_0002
import Spec_0003
import Spec_0004
import Spec_0005
import Spec_0006
import Spec_0007
import Spec_0008
import Spec_0010

open LineEncodings

def usage : String :=
  "Usage: line_encodings_check\n" ++
  "\n" ++
  "Fail when a numbered specification markdown line has no Lean encoding\n" ++
  "or an encoding has no matching markdown line.\n" ++
  "Fail when a sibling Spec_NNNN.lean contains include_str.\n" ++
  "The encoding must be explicit MdLine or String literals, one per\n" ++
  "physical markdown line. include_str is not a line encoding.\n" ++
  "Compiled encodedLines must still match the markdown bytes (LF lines).\n" ++
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
    ofSpec Spec_0000.specNumber Spec_0000.specFileName
      Spec_0000.siblingEncodingFileName Spec_0000.proofModuleName
      Spec_0000.markedAsSpecEncoding Spec_0000.markedAsProof
      Spec_0000.encodedLines,
    ofSpec Spec_0001.specNumber Spec_0001.specFileName
      Spec_0001.siblingEncodingFileName Spec_0001.proofModuleName
      Spec_0001.markedAsSpecEncoding Spec_0001.markedAsProof
      Spec_0001.encodedLines,
    ofSpec Spec_0002.specNumber Spec_0002.specFileName
      Spec_0002.siblingEncodingFileName Spec_0002.proofModuleName
      Spec_0002.markedAsSpecEncoding Spec_0002.markedAsProof
      Spec_0002.encodedLines,
    ofSpec Spec_0003.specNumber Spec_0003.specFileName
      Spec_0003.siblingEncodingFileName Spec_0003.proofModuleName
      Spec_0003.markedAsSpecEncoding Spec_0003.markedAsProof
      Spec_0003.encodedLines,
    ofSpec Spec_0004.specNumber Spec_0004.specFileName
      Spec_0004.siblingEncodingFileName Spec_0004.proofModuleName
      Spec_0004.markedAsSpecEncoding Spec_0004.markedAsProof
      Spec_0004.encodedLines,
    ofSpec Spec_0005.specNumber Spec_0005.specFileName
      Spec_0005.siblingEncodingFileName Spec_0005.proofModuleName
      Spec_0005.markedAsSpecEncoding Spec_0005.markedAsProof
      Spec_0005.encodedLines,
    ofSpec Spec_0006.specNumber Spec_0006.specFileName
      Spec_0006.siblingEncodingFileName Spec_0006.proofModuleName
      Spec_0006.markedAsSpecEncoding Spec_0006.markedAsProof
      Spec_0006.encodedLines,
    ofSpec Spec_0007.specNumber Spec_0007.specFileName
      Spec_0007.siblingEncodingFileName Spec_0007.proofModuleName
      Spec_0007.markedAsSpecEncoding Spec_0007.markedAsProof
      Spec_0007.encodedLines,
    ofSpec Spec_0008.specNumber Spec_0008.specFileName
      Spec_0008.siblingEncodingFileName Spec_0008.proofModuleName
      Spec_0008.markedAsSpecEncoding Spec_0008.markedAsProof
      Spec_0008.encodedLines,
    ofSpec Spec_0010.specNumber Spec_0010.specFileName
      Spec_0010.siblingEncodingFileName Spec_0010.proofModuleName
      Spec_0010.markedAsSpecEncoding Spec_0010.markedAsProof
      Spec_0010.encodedLines
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
