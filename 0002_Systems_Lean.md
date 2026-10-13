# Systems Lean

> v0.1.0 - 20260831
>
> Language and compiler substrate for Surmount high assurance components

## 1. Scope

This document specifies Systems Lean, the language and compiler substrate required by Surmount high assurance components, including the Surmount Systems Smart Symbolic Supercompiler specified in `0004_SSSSS.md`.

Systems Lean is Lean 4 extended with linear and affine ownership and the minimum Quantitative Type Theory (QTT) multiplicities needed for freestanding systems programming. Its freestanding compiler product is named Slake.

This document is the contract that humans read. It does not contain Lean theorem statements. Selected checkable claims have a companion Lean model under `lean/` (see Clause 1.2). That model is not this specification.

### 1.1 Status of this document

1. This document is normative for Systems Lean, Slake, the freestanding product wire, hygiene rules for novel Systems Lean and Slake source trees, and the stack targeting requirements stated herein.
2. Versioning of this document SHALL follow [0000_spec.md](0000_spec.md) (the Surmount spec spec) and Semantic Versioning 2.0.0 (SemVer). Local path for SemVer: `ref/semver`.

### 1.2 Spec and proof (informative)

This subsection is informative. It records how this specification relates to machine checked proofs. It is not a form rule under `0000_spec.md`.

In languages with dependent types, a specification (what must be true) and a proof (how a model establishes those claims) are separable artifacts. Formal Vibefication, as specified in `0008_Formal_Vibefication.md`, requires that the specification also be encoded in Lean as declarations of what must be true, and that proofs of those declarations live in separate Lean modules. Numbered markdown remains the contract humans read. It is not a substitute for those encodings. Lean proofs are not the specification.

1. The numbered markdown at the repository root is the contract implementers and reviewers read.
2. Companion Lean modules under `lean/` (the Systems Lean meaning model, distinct from the `spec_check` form checker) encode selected claims such as the multiplicity set, erasure of multiplicity 0, the freestanding product wire, residual honesty, CompCert verified compilation as a required validation step, bootstrapping a Slake compiler that fully typechecks as a required validation step, the novel language set, hygiene including product tree `ref/` directory names, stack targeting, this document's identity as specification 0002, the fact that the Smart Symbolic Supercompiler is specified in `0004_SSSSS.md` (not 0003), the fact that beastdb is specified in `0003_beastdb.md`, the fact that Recursive Self Improvement is specified in `0006_RSI.md`, the Safe judgments `SafeMem`, `SafeThr`, `SafeLayout`, `SafeKernel`, and `SafeCompCert`, the fact that `SafeCompCert` implies `SafeKernel` and that the converse is false, Reject versus Fault versus Step, `TyperSound` and `PanicFreeAOT` as named encodings whose companion fragment implications are proved while the product `typer` and the product `AOT` path still lag, `PanicFree` as a separate conjunct from `SafeMem`, `UniqueBlock` without a default reference count header, the five passing modes, heap use of omega as an owner as a refusal distinct from Trivial `CopyBits`, the profiles `HostedLinuxLibc`, `LibcOnly`, `FargoLlvm`, and `FreestandingKernel`, the separation of hosted, freestanding, product clean, bare metal, and `no_std`, correspondence before isomorphism, Cons fixtures that are false, the lock catalog names and a linear `LockToken`, `LockFree` as neither the absence of a `Mutex` nor compare and swap, proved ACID and tries that do not use locks as owned by `0003_beastdb.md`, `ObjectCow` distinct from `PageCow` and from `BorrowOrOwned`, `PosixFork` on a private mapping as `PageCow`, Secret, `DontFork`, `WipeOnConsume`, `SafeCt` off by default, and Fargo gates A through F as prove obligations rather than a specification number.
3. Those modules encode selected claims and prove facts about the model. They do not replace this document. This document does not replace those modules. Mixing spec encodings with their proofs in one mash that hides the split is nonconforming under `0008_Formal_Vibefication.md`; encodings live in `lean/SystemsLeanSpec.lean` and proofs live in the Systems Lean proofs module under `lean/`.
4. Mechanical form of this file (ASCII, tabs, RFC 2119 citation, spelling, and related rules in `0000_spec.md`) remains the job of Lean `spec_check`. Spec encodings of meaning MUST NOT be treated as a second markdown form checker.

## 2. Normative references

The following documents are indispensable for the application of this specification. For undated references, the latest edition applies.

This specifications repository's `ref/` holds 0000 Clause 12 citation pins of this repository (RFC 2119, SemVer, and the Form 2 artifacts used by other numbered specifications). Lean 4, Idris 2, CompCert, and Rust are not pinned under this specifications repository's `ref/`. Those publishers maintain canonical git, so a Form 2 copy here would be dishonest, and this document does not add Form 1 git submodules to this repository. Their Form 1 pins live in the Systems Lean product tree under that tree's own `ref/` directory. Clause 4.3 names the real directories.

### 2.1 Pins in this specifications repository (0000 Clause 12)

1. RFC 2119, Key words for use in RFCs to Indicate Requirement Levels, March 1997. Local path: `ref/rfc2119`.
2. Surmount specification `0000_spec.md` (the form rules that govern this document).
3. Semantic Versioning 2.0.0 (SemVer). Local path: `ref/semver`.

### 2.2 Pins in the Systems Lean product tree

The Systems Lean product tree is the implementation home for Systems Lean and Slake. That product tree is `/home/hunter/Projects/ai/iso`. Lean 4, CompCert, Idris 2, and Rust are already git submodules there. Form 1 pins named in this clause are directories in that product tree, not in this specifications repository. This specifications repository MUST NOT copy those four trees into this repository's `ref/`.

1. Lean 4 compiler source. Publisher git: https://github.com/leanprover/lean4.git . Form 1 pin in the product tree: `ref/lean4`. Developer docs in that pin: `ref/lean4/doc/`. The Lean 4 language reference is a separate publisher work, published at [Lean 4 Language Reference](https://lean-lang.org/doc/reference/latest/) (accessed: 2026-08-24). The product tree's `ref/lean4/README.md` and `ref/lean4/doc/dev/ffi.md` link that reference. This document does not claim the language reference is a second Form 1 directory under the product tree `ref/`.
2. Idris 2 Quantitative Type Theory documentation. Publisher git: https://github.com/idris-lang/Idris2.git . Form 1 pin in the product tree: `ref/Idris2`. Local QTT and multiplicity text in that pin: `ref/Idris2/docs/source/tutorial/multiplicities.rst` (multiplicities 0, 1, and unrestricted) and `ref/Idris2/docs/source/implementation/overview.rst` (core TT based on quantitative type theory). Published HTML: [Idris 2 documentation](https://idris2.readthedocs.io/en/latest/) (accessed: 2026-08-24). Those Idris documents cite Atkey and McBride, Quantitative Type Theory, https://bentnib.org/quantitative-type-theory.html ; that paper is not a Form 1 pin under the product tree `ref/`.
3. CompCert, the formally verified C compiler. Publisher git: https://github.com/AbsInt/CompCert.git . Form 1 pin in the product tree: `ref/CompCert`. README in that pin: `ref/CompCert/README.md`. Local doc surface: `ref/CompCert/doc/` (including `ccomp.1`). User's manual: [CompCert user's manual](https://compcert.org/man/) (accessed: 2026-08-24). CompCert is not Unlicense; see Clause 4.3 item 2.
4. Rust (layout and ABI reference for the optional LLVM path). Publisher git: https://github.com/rust-lang/rust.git . Form 1 pin in the product tree: `ref/rust`.

Multiplicities 0, 1, and omega remain defined in Clause 3 so this document states the Systems Lean restriction in one place. Idris 2 documents unrestricted (unlimited) as the third grade; this document names that grade omega and treats multiplicity 1 as linear or affine.

## 3. Definitions

### 3.1 Systems Lean

Lean 4 with linear and affine ownership and Quantitative Type Theory multiplicities restricted to 0, 1, and omega as defined in this clause.

### 3.2 Slake

The compiler written in Systems Lean that emits freestanding products.

### 3.3 Freestanding product wire

The binary or C source emitted by Slake that contains no managed Lean runtime and performs no garbage collection.

### 3.4 Multiplicity 0

Erased at compile time. A multiplicity 0 quantity MUST NOT appear in the freestanding product.

### 3.5 Multiplicity 1

Linear or affine use: exactly once or at most once.

### 3.6 Multiplicity omega

Unrestricted use. In this ASCII document the name is the word omega, not a Greek letter.

### 3.7 Residual

A named, tracked fact that prevents a product from being fully freestanding. Residual honesty means such a fact is explicit. Silence about a remaining managed runtime, garbage collector, or other blocker is nonconforming. Residual honesty does not replace CompCert verified compilation (Clause 4.2 item 6) or a bootstrapped Slake that fully typechecks (Clause 4.2 item 7).

### 3.8 Requirement keywords

The key words MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL in this document are to be interpreted as described in RFC 2119.

### 3.9 CompCert verified compilation

Compilation of the freestanding C emit by CompCert (`ccomp`) such that the generated assembly is the CompCert verified compilation of that C. This is a core validation step that the emit was compiled correctly. It is not a speed claim and it is not comparison language.

### 3.10 Slake that fully typechecks

A bootstrapped Slake compiler that typechecks the Systems Lean and Slake sources it is bootstrapped from, including theorems. A named subset of modules is not enough. Emitting freestanding C without that typecheck is not enough.


### 3.11 `SafeMem`

`SafeMem` means all of the following hold:

1. There is no use after free and no double free.
2. There is no access out of bounds.
3. There is no read of owned storage that has not been initialized.
4. There is no free while another owner of that block remains in that process.
5. There is no loan that outlives its owner or its frame, including an interior loan of a field or a slice on that block.
6. There is no `CopyHandle` of an `OwnerHandle` unless an alias protocol allows it (Clause 3.27).
7. There is no write into an `ObjectCow` object or a `PageCow` object while that object is not unique (Clause 3.39 and Clause 3.40).

`SafeMem` does not imply `PanicFree` (Clause 3.23).

### 3.12 `SafeThr`

`SafeThr` means there is no data race on a location that is not atomic, and atomic operations follow the order the program writes.

### 3.13 `SafeLayout`

`SafeLayout` means layout compatibility (`LayoutCompat`) holds for the program. Where a Fargo gate applies, virtual table compatibility (`VTableCompat`) and binary interface compatibility (`AbiCompat`) are further conjuncts. A claim of LLVM fragment compatibility (`IrFragCompat`) is not claimed proved in this clause (Clause 6.4).

### 3.14 `KernelModelOk`

`KernelModelOk` means the kernel model accepts the program. It is a conjunct of `SafeKernel`. It is not CompCert refinement. It is not a proof of mainline Linux.

### 3.15 `SafeKernel`

`SafeKernel` of a program means `SafeMem`, `SafeThr`, `SafeLayout`, and `KernelModelOk` all hold for that program. This judgment is not named `SafeLinux`. This document does not claim that mainline Linux is proved.

### 3.16 `CompCertFragment`

`CompCertFragment` is the fragment of C that excludes a listed set of undefined behavior. It is the fragment CompCert (`ccomp`) compiles when `SafeCompCert` holds. The first fragment is sequential unique C. Official CompCert does not prove threads. The constructor `container_of` is outside this fragment (Clause 3.34). An inline assembly island is outside this fragment. Treating full ISO C as an isomorphism is not a completion condition. Clashes other than the Clause 5 list stay residual until Clause 6.4 says they are fixtures (Clause 6.4).

### 3.17 `CompCertRefines`

`CompCertRefines` means the generated assembly is the CompCert refinement of that sequential unique C. It ties Clause 3.9 to `CompCertFragment`. It is not claimed done (Clause 6.3).

### 3.18 `SafeCompCert`

`SafeCompCert` of a program means `SafeKernel` of that program, `CompCertFragment`, and `CompCertRefines` all hold. `SafeCompCert` implies `SafeKernel`. The converse is False (Clause 4.5 and Clause 5).

### 3.19 Reject

Reject means the `typer` refuses the program before emit. Reject is what a product shows. Reject is not a Fault.

### 3.20 Fault

Fault means an illegal state of Step. Fault belongs to the specification of execution. The emitted binary is not a sanitizer that discovers Fault at run time in place of Reject.

### 3.21 Step

Step is the operational semantics. Reaching a Fault is a statement about Step. Step is not the emitted ELF.

### 3.22 `TyperSound`

`TyperSound` is the named implication that if the `typer` accepts a program, execution under Step does not reach a Fault. The name is required. The companion fragment implication on `TyperFragment` is proved in the Systems Lean proofs module. The product `typer` is not done. Full product `TyperSound` still lags (Clause 6.4). Systems Lean remains not ready for use.

### 3.23 `PanicFree`

`PanicFree` of a program means a typed path has no reachable panic, unwrap, expect, failing assertion, typed access out of bounds, overflow that panics, or abort. `PanicFree` does not mean allocation never fails. `PanicFree` does not mean a hardware fault never happens. `SafeMem` does not imply `PanicFree`. `PanicFree` is a separate conjunct from `TyperSound`.

### 3.24 `PanicFreeAOT`

`PanicFreeAOT` is the named implication that if `PanicFree` holds of a program, execution does not reach a panic. The name is required. The companion fragment implication on `PanicFreeFragment` is proved in the Systems Lean proofs module. The product `AOT` path is not done. Full product `PanicFreeAOT` still lags (Clause 6.4). `PanicFreeAOT` is not `TyperSound`. Systems Lean remains not ready for use.

### 3.25 Bits

Bits are values with no identity and no `destructor`. `CopyBits` of Bits does not create an owner. A natural number, a Boolean, a numeric machine word, and a structure whose fields are only Bits are Bits. A handle is not Bits.

### 3.26 `UniqueBlock`

`UniqueBlock` is a judgment of one process identifier and one block. The process identifier is an argument of the judgment. It is not a header field and it is not a reference count. `UniqueBlock` means the owner set of that block in that process has size one. Loans MAY still exist. `UniqueBlock` says nothing about any other process. A `UniqueBlock` has no default reference count header (Clause 4.5). An `OwnerHandle` is a handle typed as an owner. A `LoanHandle` is a handle typed as a loan. Neither handle is Bits (Clause 3.25).

Sharing that a crate already records in a header is that crate alias protocol, obtained by correspondence. It is not the default `malloc` path. This document does not invent a ghost owner count as a substitute for that header. An exact owner count on a header type is a later tool and is not claimed here (Clause 6.4).

### 3.27 Alias protocol

An alias protocol is how a heap block whose owner set in a process has size at least two is allowed to die. The constructors named for that protocol are a crate header that already counts references (`Arc` or `Rc` as that crate defines them), `MutexOwns`, and `JoinBeforeFree`. The default protocol is none. The default block is `UniqueBlock` only. `CopyHandle` of an `OwnerHandle` with no alias protocol is Reject, and that clash is False (Clause 4.5 item 3).

### 3.28 Passing modes

The five passing modes are `CopyBits`, `MoveOwner`, `LoanShared`, `LoanMut`, and `CopyHandle`. No other passing mode is permitted (Clause 4.5).

1. `CopyBits` copies Bits and does not create an owner.
2. `MoveOwner` transfers the owner and the source does not remain an owner.
3. `LoanShared` is a shared loan and does not free the block. Shared loans of ranges MAY overlap.
4. `LoanMut` is an exclusive loan and does not free the block. A `LoanMut` of a whole object conflicts with any loan of a field of that object. Exclusive loans of ranges are disjoint.
5. `CopyHandle` copies an owning handle and creates an extra owner. Without an alias protocol that extra owner is Reject (Clause 3.27).

Framing is the passing mode on each pointer or file descriptor in a function type: move, loan, or `CopyHandle`. If the `callee` type does not state one of those modes, the `callee` MAY stash the pointer. `UniqueBlock` does not survive that stash. Two reads of a unique pointer are not an owner set of size two. A loan of a field is a range loan on the same block, not a new block. A free while any interior loan on that block is live is Reject.

### 3.29 Multiplicities, grades, and omega as an owner

Systems Lean keeps Quantitative Type Theory multiplicities 0, 1, and omega as defined in Clause 3.4, Clause 3.5, and Clause 3.6. No other multiplicity is permitted (Clause 4.1 item 1). Grade names used with the Safe judgments map onto those multiplicities and onto passing modes as follows.

1. Erased means gone at run time and matches multiplicity 0. An erased quantity does not appear in the freestanding product (Clause 3.4).
2. Once means consumed once, local to the function, and matches a multiplicity 1 use. Once does not imply `UniqueBlock`.
3. Trivial means `CopyBits` of Bits only (Clause 3.25 and Clause 3.28). Trivial is the only Safe case of many uses that resemble omega.
4. Heap use of omega as an owner is Reject. That Reject is not the Trivial case. The two claims are not the same claim. Language level omega, when a text mentions it, applies only to Bits. It does not apply to a heap `OwnerHandle` (Clause 4.5).

In this ASCII document the multiplicity name remains the word omega, not a Greek letter (Clause 3.6).

### 3.30 Profiles

1. `HostedLinuxLibc` means ISO hosted emit that is product clean (Clause 3.31), with `libc` and Linux in the trusted computing base, and with an entry point named `main`. Sequential unique C on this profile aims at `SafeCompCert`. Threads and `atomics` on this profile are `SafeKernel` and are not by themselves `SafeCompCert`. This profile is additional. It is not the freestanding product wire (Clause 3.3). Clause 4.5 item 6 does not allow that profile to replace the wire.
2. `LibcOnly` means the trusted computing base includes `libc` and the user syntax contains no raw system call.
3. `FargoLlvm` means elevation of a Rust crate through LLVM IR, with layout compatibility and Rust trait object tables. The name does not assign fargo a specification number (Clause 3.47).
4. `FreestandingKernel` means ISO freestanding emit that is product clean, with no hosted `libc` in the trusted computing base, and with a kernel or firmware entry. It is not bare metal by itself. It is not the Rust attribute `no_std`.

### 3.31 Words that are not synonyms

Hosted, ISO freestanding, product clean, bare metal, and the Rust attribute `no_std` are not synonyms.

1. Hosted means the program runs with an operating system and a C library, in the hosted form of C.
2. Freestanding means the freestanding form of ISO C. That word is a term of art and this document keeps it. The freestanding product wire (Clause 3.3) is product clean and is distinct from hosted emit. This document does not add a pin of the C standard under `ref/` (Clause 6.4).
3. Product clean means the emit has no managed Lean runtime and no managed Idris runtime.
4. Bare metal means there is no operating system.
5. `no_std` is a Rust attribute. It is not ISO freestanding, it is not product clean, and it is not bare metal.

### 3.32 Correspondence

Correspondence is a map from judgments on a named fragment to Safe judgments, together with a map back. One map sends a Rust judgment to a Safe judgment or to no judgment. The other map sends a Safe judgment back. Both maps are partial until a gate says otherwise. An isomorphism on a fragment is the further claim that both maps are total on that fragment and compose to identity. Correspondence MUST be in place before any isomorphism claim. Until that theorem exists, text MUST say correspondence of judgments on the fragment and MUST NOT call the maps an isomorphism (Clause 4.5 item 9). Curry-Howard in this clause means a correspondence of rules. It does not mean a finished category isomorphism. A test of the maps is not that theorem.

A language behavior that the source language leaves undefined, leaves to the implementation, or gets silently wrong is Reject, a named Fault, or a named trusted island. Those maps are correspondence. They are not an isomorphism until the identity condition holds. Full ISO C and full ISO C++ as `isomorphisms` are not completion conditions (Clause 6.4).

### 3.33 Cons

Cons of a set of judgments means that set does not prove False from its own constructors and axioms. A clash of two constructors that cannot both hold is False in the companion Lean proofs, not a comment. A clash that would be a vulnerability is Reject or a failed Cons fixture. Cons does not mean every true statement has a proof. It means the claims this document writes do not contradict one another. The fixtures that are False are named in Clause 4.5 item 3 and Clause 5. A fixture that exists only as a test and does not record False does not meet that item.

### 3.34 container_of

The constructor `container_of` recovers a containing object from an interior field using a documented offset and an identifier of that containing object. It is a `SafeKernel` constructor. Silent recovery, with no documented offset and no identifier, is Reject on a `SafeCompCert` claim. `CompCertFragment` together with `container_of` is False (Clause 4.5 item 3). The containing object is an ordinary data object. The word is not an agent layer.

### 3.35 Lock catalog

Phase 0 of the lock catalog is the following names plus a linear `LockToken` (Clause 3.36). Encoding the whole catalog as proved is not required and is not claimed done.

1. `Mutex` is an exclusive lock that owns its payload. Taking the lock yields a `LoanMut` of that payload paired with a `LockToken`. Releasing the lock consumes both and restores the `Mutex`. `Mutex` does not admit shared readers.
2. `RwLock` admits many `LoanShared` or one `LoanMut`, and not both at once. A write is permitted only when no reader token and no writer token remain.
3. Semaphore is a counter of linear permits.
4. Permit is the linear token a Semaphore grants. A Permit is not an owner of a heap block.
5. `Condvar` is a wait queue attached to a `Mutex`. Waiting consumes a `LockToken` and later returns a new `LockToken`. The type does not by itself solve a missed wake up.
6. Barrier collects a fixed number of linear arrival tickets and then releases them. Using one ticket twice is Reject.
7. Once initializes a block exactly once. The first writer receives `LoanMut`. Later readers receive `LoanShared`. A second writer is Reject.
8. `AffineUnlock` means dropping the guard releases the lock. Forgetting a live `LockToken` is Reject unless a documented leak island applies. This name is not a finished proof.
9. A try of the lock (`trylock`) returns a result. It does not panic because the lock is busy.
10. A recursive `mutex` is named and is off unless a profile turns it on.
11. Lock poisoning is named. This clause does not claim a poisoning proof.
12. `SeqLock`, `Futex`, and `LockOrder` are not given constructors in this clause (Clause 6.4).

What a linear `LockToken` changes is that the token cannot be copied, that `Mutex` owns the payload, that `RwLock` is many shared loans or one exclusive loan, and that an `ObjectCow` or `PageCow` write that does not copy when the object is shared is Reject. What it does not provide is absence of deadlock, absence of `livelock`, fairness, or a correct scheduler.

### 3.36 `LockToken`

`LockToken` is a linear proof that this thread holds one identified lock. The grade is Once (Clause 3.29). `CopyHandle` of a `LockToken` is Reject. Unlock consumes the `LockToken`. A second unlock is Reject. A missing unlock of a live `LockToken` is Reject. `LockToken` does not prove that deadlock is absent (Clause 4.5).

### 3.37 `LockFree`

`LockFree` is the claim that an implementation matches a sequential specification under a named sharing mode, that an operation does not leave an inconsistent state, and that the operation does not block other parties that mode allows. `LockFree` is not the absence of a `Mutex`. `LockFree` is not compare and swap. `LockFree` is not an atomic transaction and it is not the four transaction words in Clause 3.38. A progress model for `LockFree` is not claimed written (Clause 6.4). A structure that frees a node and calls itself `LockFree` with no named reclamation protocol is not accepted as `LockFree` (Clause 6.4).

### 3.38 ACID words and specification 0003

Atomicity, consistency, isolation, and durability are four words for a transaction. They are not compare and swap. They are not a hardware atomic. They are not a `Mutex`. They are not `LockFree`. Isolation takes a named level. This document does not choose that level for beastdb. Specification `0003_beastdb.md` Clause 3.6 owns proved ACID for beastdb. Clause 3.7 of that specification owns tries that do not use locks. This document does not move those theorems here and does not restate them as theorems of Systems Lean (Clause 4.5). The single writer, multiple reader default of beastdb stays in that specification.

### 3.39 `ObjectCow`

`ObjectCow` is a heap object protocol. A share does not copy bytes. A write when the owner set has size greater than one copies the payload to a new `UniqueBlock`. A write into the shared object while it is not unique is Reject. `ObjectCow` is the protocol that matches a mutating copy of a shared heap object. It is not `PageCow`. It is not `BorrowOrOwned`. It is not `PosixFork` (Clause 3.42).

### 3.40 `PageCow`

`PageCow` is a page table protocol. A shared physical page is protected against writes, and the first store copies that page. The first grain is 4096 bytes. Larger pages are not specified in this clause (Clause 6.4). `PosixFork` on a private mapping is `PageCow` (Clause 3.42). A write into a `PageCow` page while it is not unique is Reject.

### 3.41 `BorrowOrOwned`

`BorrowOrOwned` is either a loan or an owned copy. It is the Fargo name for the Rust standard library `enum` that holds one of those two. `BorrowOrOwned` is not `ObjectCow`. `BorrowOrOwned` is not `PageCow`. `PosixFork` is not `BorrowOrOwned`.

### 3.42 `PosixFork`

`PosixFork` is the POSIX fork operation that creates another process. `ForkJoin` joins threads inside one process. `PosixFork` is not `ForkJoin`. `PosixFork` is not `ObjectCow` and is not `BorrowOrOwned`. On a private mapping, and on anonymous heap pages, `PosixFork` is `PageCow`. File descriptors are duplicated and are not `PageCow`. A mapping that stays shared across the two processes stays shared. A program whose blocks are unique only rejects `PosixFork` (Clause 4.5). `PosixFork` while a Secret with `DontFork` is live is Reject (Clause 3.43 and Clause 3.44). A pin of an address does not survive `PosixFork`. Rules for `ForkJoin` beyond this distinction are residual (Clause 6.4).

### 3.43 Secret

Secret means the bytes are not copied by `CopyHandle` or by `CopyBits` into a sink that is not Secret. `ObjectCow` of a Secret is Reject. `PageCow` of a Secret is Reject. Those two clashes are False (Clause 4.5 item 3). `DontFork` is the default while a Secret block is live (Clause 3.44). `WipeOnConsume` applies to Secret (Clause 3.45). A reference counted crate pointer whose payload is key material is Reject unless an explicit protocol says those bytes are not secret. That includes an `Arc` of key material. Keys are an `OwnerHandle` or a pinned `UniqueBlock`.

### 3.44 `DontFork`

`DontFork` means `PosixFork` is Reject while this block is live in the forking process.

### 3.45 `WipeOnConsume`

`WipeOnConsume` means the payload bytes are set to zero before the owner dies. A Secret MUST use `WipeOnConsume` (Clause 4.5 item 11).

### 3.46 `SafeCt`

`SafeCt` means control flow and data access do not depend on Secret. `SafeCt` is off by default. A profile that wants `SafeCt` says so. Silence does not turn `SafeCt` on (Clause 4.5). A timing or cache model for `SafeCt` is not specified in this clause (Clause 6.4).

### 3.47 Fargo gates A through F

Fargo is the `SurmountSystems` cargo fork named fargo. This document does not assign fargo a specification number (Clause 6.2 item 2 and Clause 6.4). Gates A through F are obligations a correspondence MUST prove (Clause 3.32). They are not a specification number and they are not a numbered file.

1. Gate A. The syntax fragment contains no `unsafe` code, or `unsafe` code is isolated behind an `OwnerHandle` interface the Safe judgments can see.
2. Gate B. Every type from the Rust compiler (`rustc`) maps to Bits, an `OwnerHandle`, a `LoanHandle`, or Reject.
3. Gate C. Each function passing mode maps to one of the five passing modes in Clause 3.28.
4. Gate D. Layout compatibility holds for every type that crosses a binary interface or is stored in a structure Fargo emits.
5. Gate E. Virtual table compatibility holds for every trait object Fargo emits.
6. Gate F. Product clean emit, as C or as LLVM IR, contains no managed Lean runtime and no managed Idris runtime.

A crate that meets Gate A and does not meet Gate D, Gate E, and Gate F is not Safe (Clause 4.5 item 9). This clause does not make Fargo run cargo. This document states what a gate MUST prove. Elevation of these gates in the fargo fork is not claimed implemented (Clause 6.4).

### 3.48 Emit split

The emit split is which compiler runs. CompCert (`ccomp`) applies when `SafeCompCert` holds, on sequential unique C. LLVM or `cc` applies when only `SafeKernel` holds, including `atomics`, device registers, explicit packed vector operations, and assembly islands. The LLVM or `cc` path is not proved by CompCert. CompCert does not prove layout compatibility against `rustc`. That layout obligation is the LLVM and Fargo path. The primary emission target of Slake stays freestanding, runtimeless C (Clause 4.2 item 2). `HostedLinuxLibc` is an additional profile (Clause 3.30). It is not a silent replacement of that primary target. Clause 4.5 item 4 does not allow silence to make CompCert optional. Clause 4.2 item 6 stays in force for the freestanding C emit (Clause 4.5 item 4).

## 4. Core requirements

### 4.1 Language core

1. Systems Lean MUST support only the three Quantitative Type Theory multiplicities 0, 1, and omega defined in Clause 3. No other multiplicity is permitted.
2. Multiplicity 1 MUST enforce linear or affine resource discipline (exactly once or at most once).
3. Any definition intended for the freestanding product wire MUST NOT require managed heap allocation that needs a runtime, MUST NOT require garbage collection, and MUST NOT require residual Lean runtime services.

### 4.2 Compiler product (Slake)

1. The compiler named in this specification MUST be written in Systems Lean.
2. The primary emission target of Slake MUST be freestanding, runtimeless C.
3. A secondary LLVM IR emission path MAY be provided later for use with the Rust ecosystem. That path is optional and is not required for conformance.
4. The freestanding product wire MUST contain no managed Lean runtime and MUST NOT perform garbage collection.
5. The compiler MUST maintain residual honesty: any residual that prevents a fully freestanding product MUST be explicitly named and tracked.
6. CompCert verified compilation (Clause 3.9) is a REQUIRED core validation step. The freestanding C emit MUST be compiled with CompCert (`ccomp`) as high assurance evidence that the emit was compiled correctly. Naming a residual MUST NOT substitute for this step. This document does not claim CompCert is pinned under this specifications repository's `ref/`. The Form 1 pin lives in the Systems Lean product tree at `ref/CompCert`.
7. Bootstrapping a Slake compiler that fully typechecks (Clause 3.10) is a REQUIRED core validation step. A conforming Slake MUST typecheck the Systems Lean and Slake sources it is bootstrapped from, including theorems. Naming a residual MUST NOT substitute for this step. A claim that the freestanding product hosts itself from generated C is a distinct claim and does not satisfy this step by itself.

### 4.3 Repository and hygiene rules

These rules apply to novel Systems Lean and Slake source trees (product repositories). They are distinct from the citation pins of this specifications repository under `0000_spec.md` Clause 12. This specifications repository's `ref/` holds external specifications this repository cites as 0000 Clause 12 pins. The Systems Lean product tree's `ref/` is where Lean 4, Idris 2, CompCert, Rust, and similar upstream language and compiler trees live as Form 1 git submodules. This document does not claim that Lean 4, Idris 2, CompCert, or Rust are pinned under this specifications repository's `ref/`.

1. Novel Systems Lean and Slake source MUST be released under the Unlicense.
2. Upstream reference trees MUST live under a clearly separated `ref/` directory of that product tree, MUST use these directory names, and MUST retain their original licenses:
	1. `ref/Idris2` for Idris 2 (publisher git https://github.com/idris-lang/Idris2.git).
	2. `ref/lean4` for Lean 4 (publisher git https://github.com/leanprover/lean4.git).
	3. `ref/CompCert` for CompCert (publisher git https://github.com/AbsInt/CompCert.git). CompCert is not Unlicense.
	4. `ref/rust` for Rust (publisher git https://github.com/rust-lang/rust.git).
	Agent skill packs MUST NOT be placed under that product tree's `ref/`; they live under `skills/` when present.
3. Novel work MUST be expressed in at most three languages: Idris 2, Lean 4 (including Systems Lean), and pure Nix flakes.
4. Shell scripts that float free of Nix MUST NOT be used for novel product paths. Pure Nix is REQUIRED for build and packaging of novel components.

### 4.4 Relationship to the Surmount stack

1. Systems Lean is the REQUIRED implementation language for the core of beastdb (specified in `0003_beastdb.md`), the Lean Machine formalization layer, components of the Smart Symbolic Supercompiler specified in `0004_SSSSS.md` that are safety critical, and future high assurance rewrites under the FixOS vision. Application and neurosymbolic integration for SSSSS live in `0004_SSSSS.md`. Lean Machine is specified in `0013_Lean_Machine.md`.
2. All such components MUST be able to target the freestanding Slake path.
3. Recursive Self Improvement is specified in `0006_RSI.md`. That document is practice for Surmount specifications and agents. It is not a compiler requirement of this document.


### 4.5 Safe judgments

1. `SafeCompCert` of a program MUST imply `SafeKernel` of that program (Clause 3.18).
2. The converse MUST be False. `SafeKernel` of a program MUST NOT be treated as `SafeCompCert` of that program. The judgment MUST NOT be named `SafeLinux`. This document MUST NOT claim that mainline Linux is proved (Clause 3.15).
3. Each named Cons fixture MUST be False in the companion Lean proofs and MUST be Reject in a product that claims the Safe judgments. The fixtures are `UniqueBlock` together with `CopyHandle` of that owner and no alias protocol, Secret together with `ObjectCow`, Secret together with `PageCow`, `CompCertFragment` together with `container_of`, and `PanicFree` together with a reachable unwrap. A comment is not enough. A test that does not record the clash as False is not enough. A proof hole written as `sorry` MUST NOT be counted as success (Clause 3.33).
4. On any path that claims a Safe judgment, CompCert (`ccomp`) MUST be applied only when `SafeCompCert` holds, and that application MUST start with sequential unique C (Clause 3.16 and Clause 3.48). Clause 4.2 item 6 remains in force for the freestanding C emit: that emit MUST be compiled with CompCert (`ccomp`), and naming a residual MUST NOT substitute for that step. This item MUST NOT be read as making CompCert optional.
5. When only `SafeKernel` holds, LLVM or `cc` MAY be used. That path MUST NOT be called proved by CompCert (Clause 3.48). Clause 4.2 item 3 remains optional and is not required for conformance.
6. The primary emission target of Slake MUST remain freestanding, runtimeless C (Clause 4.2 item 2). `HostedLinuxLibc` MUST be an additional profile and MUST NOT replace that primary target or the freestanding product wire (Clause 3.3, Clause 3.30, and Clause 3.31).
7. Systems Lean MUST keep only the multiplicities 0, 1, and omega (Clause 4.1 item 1 and Clause 3.29). Heap use of omega as an owner MUST be Reject. Many uses of Bits that are Trivial, meaning `CopyBits`, MUST NOT be described as that Reject. The two claims MUST NOT be collapsed. `UniqueBlock` MUST be indexed by a process identifier and a block. That identifier MUST NOT be a reference count. A `UniqueBlock` MUST NOT carry a default reference count header. Sharing MUST be the alias protocol of a crate header that already counts references, not a ghost owner count invented by this document (Clause 3.26 and Clause 3.27).
8. Every passing mode MUST be one of `CopyBits`, `MoveOwner`, `LoanShared`, `LoanMut`, or `CopyHandle` (Clause 3.28). No sixth passing mode is permitted.
9. Fargo gates A through F MUST be read as obligations on a correspondence (Clause 3.47). They MUST NOT be read as a specification number. fargo MUST NOT be given a specification number by this document (Clause 6.2 item 2). A crate that has completed only Gate A MUST NOT be called Safe. If a note names a crate gate, it MUST name the highest completed gate. A proof hole written as `sorry` on Gate D, Gate E, or Gate F MUST NOT be described as success. Correspondence MUST be stated before any isomorphism claim. Until both maps are total on that fragment and compose to identity, text MUST say correspondence of judgments on the fragment and MUST NOT call the maps an isomorphism (Clause 3.32).
10. The names `TyperSound` and `PanicFreeAOT` MUST exist (Clause 3.22 and Clause 3.24). Companion fragment implications MAY be proved while the product `typer` and the product `AOT` path still lag (Clause 6.4). A lagging product proof MUST NOT be presented as done. A proof hole written as `sorry` MUST NOT be counted as success.
11. On a private mapping, and on anonymous heap pages, `PosixFork` MUST be `PageCow` and MUST NOT be `ObjectCow` or `BorrowOrOwned` (Clause 3.42). A program whose blocks are unique only MUST Reject `PosixFork`. `DontFork` MUST be the default for a live Secret, and `PosixFork` while that Secret is live MUST be Reject (Clause 3.43 and Clause 3.44). `SafeCt` MUST be off unless a profile explicitly turns it on (Clause 3.46). A Secret MUST use `WipeOnConsume` before the owner dies (Clause 3.45).
12. `LockToken` MUST be linear (Clause 3.36). `CopyHandle` of a `LockToken` MUST be Reject. A second unlock of one `LockToken` MUST be Reject. A missing unlock of a live `LockToken` MUST be Reject. `LockToken` MUST NOT be read as a proof that deadlock is absent. `LockFree` MUST NOT be defined as the absence of a `Mutex`, MUST NOT be defined as compare and swap, and MUST NOT be defined as `atomicity`, consistency, isolation, and durability (Clause 3.37 and Clause 3.38). Those four words MUST NOT be defined as compare and swap. Proved ACID for beastdb and tries that do not use locks MUST remain in `0003_beastdb.md` and MUST NOT be restated as theorems of this document.


## 5. Conformance

A Systems Lean implementation or Slake product conforms to this specification if and only if all of the following hold:

1. It restricts Quantitative Type Theory multiplicities to 0, 1, and omega as defined in Clause 3.
2. It emits freestanding products free of managed Lean runtime and garbage collection, or it names and tracks every residual that prevents a fully freestanding product (Clause 4.2 item 5). Residual honesty in this item applies to the freestanding product wire. It does not excuse a missing CompCert validation step or a missing Slake bootstrap typecheck.
3. It places novel source under the Unlicense and keeps upstream trees under that product tree's `ref/` with the directory names in Clause 4.3 and with original licenses (Clause 4.3 items 1 and 2).
4. It uses only the three permitted languages for novel work (Clause 4.3 item 3) and does not use shell scripts that float free of Nix for novel product paths (Clause 4.3 item 4).
5. Named high assurance components that claim conformance to Clause 4.4 can target the freestanding Slake path.
6. CompCert verified compilation of the freestanding C emit has been performed (Clause 4.2 item 6).
7. A bootstrapped Slake compiler fully typechecks the Systems Lean and Slake sources it is bootstrapped from (Clause 4.2 item 7).
8. Where it claims `SafeCompCert` for a program, it also meets `SafeKernel` for that program (Clause 4.5 item 1).
9. It does not treat `SafeKernel` as sufficient for `SafeCompCert`. That converse is False (Clause 4.5 item 2).
10. It rejects the named Cons clashes, and those clashes are False: `UniqueBlock` together with `CopyHandle` of that owner and no alias protocol; Secret together with `ObjectCow`; Secret together with `PageCow`; `CompCertFragment` together with `container_of`; `PanicFree` together with a reachable unwrap (Clause 4.5 item 3).
11. On any path that claims a Safe judgment, it applies CompCert (`ccomp`) only when `SafeCompCert` holds, starting with sequential unique C (Clause 4.5 item 4). Clause 5 item 6 still requires CompCert verified compilation of the freestanding C emit and is not weakened by this item.
12. Where it uses LLVM or `cc` because only `SafeKernel` holds, it does not call that path proved by CompCert (Clause 4.5 item 5).
13. It keeps freestanding, runtimeless C as the primary Slake emit, and it does not replace that emit or the freestanding product wire with `HostedLinuxLibc` (Clause 4.5 item 6). `HostedLinuxLibc` MAY exist only as an additional profile.
14. It keeps multiplicities 0, 1, and omega, it rejects heap use of omega as an owner, it does not describe Trivial `CopyBits` of Bits as that rejection, and a `UniqueBlock` has no default reference count header (Clause 4.5 item 7). Clause 5 item 1 is not weakened by this item.
15. Every passing mode it accepts is one of the five named in Clause 3.28 (Clause 4.5 item 8).
16. It does not treat Fargo gates A through F as a specification number, it does not call a Gate A only crate Safe, and it does not call judgment maps an isomorphism before both maps are total on the named fragment and compose to identity (Clause 4.5 item 9).
17. The companion encoding names `TyperSound` and `PanicFreeAOT` (Clause 4.5 item 10). Companion fragment implications on `TyperFragment` and `PanicFreeFragment` are proved. This item does not require the product `typer` or the product `AOT` path to be finished.
18. It treats `PosixFork` on a private mapping as `PageCow` and not as `ObjectCow`, it rejects `PosixFork` for a program whose blocks are unique only, it defaults a live Secret to `DontFork`, it wipes a Secret before the owner dies, and it leaves `SafeCt` off unless a profile turns `SafeCt` on (Clause 4.5 item 11).
19. It treats `LockToken` as linear, it does not define `LockFree` as the absence of a `Mutex` or as compare and swap, it does not define `atomicity`, consistency, isolation, and durability as compare and swap, and it leaves proved ACID for beastdb and tries that do not use locks in `0003_beastdb.md` (Clause 4.5 item 12).

Optional LLVM IR emission (Clause 4.2 item 3) is not required for conformance. Where that path, or `cc`, is used because only `SafeKernel` holds, it is not proved by CompCert (Clause 5 item 12).

## 6. Residual

This section is normative for residual honesty of this document. Silence about an unpublished specification, an unassigned number, an unimplemented requirement, or an out of scope item named in this document is nonconforming for this specification as a document. A parenthetical planned file name in Scope is not the residual record.

### 6.1 Product tree and language pins

1. Systems Lean and Slake work is ongoing and is not ready for use. This document MUST NOT be read as claiming that Systems Lean or Slake never started or do not exist.
2. The Systems Lean product tree that already holds Lean 4, CompCert, Idris 2, and Rust as git submodules is `/home/hunter/Projects/ai/iso`. This specifications repository MUST NOT copy those four trees into this repository's `ref/`. Existing pins of this repository remain. New pins are added when the cited artifact is present.
3. Recursive Self Improvement is specified in `0006_RSI.md`. That document is practice for Surmount specifications and agents. It is not a compiler requirement of this document.

### 6.2 Unassigned names

1. Lean Machine is specified in `0013_Lean_Machine.md`. That document is specification 0013. Application and neurosymbolic integration live in `0004_SSSSS.md`.
2. fargo, Carbonado, and SSSP are not specified here and have no assigned numbers.

### 6.3 Product requirements that are not ready for use

CompCert verified compilation of the freestanding C emit and a bootstrapped Slake compiler that fully typechecks are required validation steps. They are not claimed done. Byte identity of emit is required for a conforming product and is not claimed true.


### 6.4 Safe judgments that are not claimed done

This subsection records Safe judgment work that this document names and does not claim is done. It does not retire Clause 6.1, Clause 6.2, or Clause 6.3. Systems Lean and Slake remain ongoing and are not ready for use. The Safe judgments are not a claim that a `SafeC` package is ready for use. This document MUST NOT be read as claiming that Systems Lean or Slake never started or do not exist (Clause 6.1 item 1).

1. Encodings of these claims belong in `lean/SystemsLeanSpec.lean` and proofs belong in the Systems Lean proofs module under `lean/`. A mash of those modules is nonconforming (Clause 1.2 item 3). This prose is not those proofs. Companion proofs that the Clause 5 fixtures are False are not claimed done by this prose. A theorem closed with `sorry` MUST NOT be counted as success. Systems Lean and Slake remain not ready for use.
2. CompCert verified compilation of the freestanding C emit remains a REQUIRED validation step and is not claimed done (Clause 6.3). The `SafeCompCert` path does not retire that obligation and does not retire the bootstrapped Slake typecheck. Byte identity of emit remains REQUIRED for a conforming product and is not claimed true (Clause 6.3).
3. This document uses freestanding as the ISO C term of art. It does not add a Form 1 pin or a Form 2 pin of the C standard under this repository's `ref/`.
4. fargo remains unnumbered (Clause 6.2 item 2). Gates A through F do not assign fargo a number. This document does not create a numbered file for fargo and does not create a numbered file for `SafeC`.
5. The v28 `SafeC` lake package is not in this specifications repository. This document does not create a numbered `SafeC` file. This document does not decide whether that package lives in a new repository or as a module under the Systems Lean product tree.
6. The v28 `SafeC` package directory layout, including the lake file, the `toolchain` pin, the package README, `TCB`.md, the package changelog, and the inner Lean modules named in v28 section 14, is not a tree in this specifications repository. This document does not create those paths.
7. This document does not edit the Systems Lean product tree at `/home/hunter/Projects/ai/iso`. Implementation of the v28 `SafeC` package there stays out of scope until the operator expands scope. This specifications repository still MUST NOT copy Lean 4, CompCert, Idris 2, or Rust into this repository's `ref/` (Clause 6.1 item 2).
8. Companion fragment proofs of the `TyperSound` implication on `TyperFragment` and of the `PanicFreeAOT` implication on `PanicFreeFragment` are proved in the Systems Lean proofs module. The names stay required (Clause 3.22, Clause 3.24, and Clause 4.5 item 10). The product `typer` and the product `AOT` path still lag. Full product implications are not claimed done. If a later product proof does not hold, this item remains the record that the product proofs lag. A proof hole MUST NOT be counted as success. Systems Lean remains not ready for use.
9. The v28 toolbox has no cap of two constructs. A missing model means the model is not written yet, not that the language is smaller by silence. Regions, an arena, capabilities such as a file descriptor and a `LockToken`, dependent lengths, `MaybeUninit`, Send and Sync, `PanicFree`, a CompCert subset, and optional CHERI or `MTE` hardware tags are not finished models in this document.
10. The v28 first `allocator` is `malloc` and free as `UniqueBlock` in the calling process, with no reference count field. Typed callers MAY treat a `glibc` return as that `UniqueBlock`. An `untyped` second pointer is outside Safe. This document does not claim that `glibc` `malloc` is proved.
11. An exact owner count on a v28 header type is a later tool and is not the default `malloc` path.
12. The v28 map mode catalog is not a present theorem here. Shared maps, private maps, anonymous maps, file backed maps, `memfd`, and two mappings of one object in one process are named and are not specified as done. Later map work that is not claimed includes huge pages, device and memory mapped I/O, `DMA` and an `IOMMU`, `sendfile` and splice, `userfaultfd`, and `io_uring` with registered buffers. A block reachable from two threads in one process is not the same word as two virtual mappings of one physical page.
13. Wild Child, the v28 planned Systems Lean typed linker, is not implemented in this repository. Until it exists, cc, `ld`, `lld`, and the upstream Wild linker stay in the trusted computing base and do not preserve `UniqueBlock`. Incremental linking is a later Wild goal and is not a v28 `SafeC` phase. This document does not implement a linker.
14. Explicit v28 packed vector operations (the v28 SIMD topic) are not yet a catalog in this document. They are not automatic packed vector operations and they are not an atomic location.
15. A v28 `ZeroView`, whose layout in memory is exactly the buffer bytes, is not a finished requirement here. Endian, a relative pointer, a generation or schema tag, and a checksum remain to be written. `Unmap` while that view is live is Reject when the requirement is written.
16. v28 `CompCertTSO` is research and is not the default compiler. Official CompCert does not prove threads. This document does not claim that a `CompCertTSO` validation step is done. This item does not make `CompCertTSO` into Clause 4.2 item 6.
17. The v28 choice among the Linux kernel memory model, a C++ memory model fragment, and a custom fragment is not closed. `LKMM` remains residual labor. Atomic order beyond the `SafeThr` sentence is not a finished model.
18. v28 `allocators` after `malloc`, namely an arena, a bump `allocator`, a slab, a buddy `allocator`, a page `allocator`, and kernel allocation, are not present theories. Later they share one interface: allocation introduces a `UniqueBlock` and free consumes it. This document does not freeze one `allocator` theory.
19. v28 Fargo elevation of gates A through F is not implemented in the fargo fork. Proofs of gates D through F MAY lag. Unsafe code, unions, and Drop glue that Fargo cannot encode stay residual for each crate. Aeneas, Charon, and `Hax` are the preferred extractors for safe fragments, and this specifications repository does not implement those extractors. A proof hole is not a record that a gate succeeded. fargo stays unnumbered (Clause 6.2 item 2).
20. v28 `SeqLock`, `Futex`, and `LockOrder` stay residual. A `SeqLock` proof MAY lag. `Futex` remains inside the `HostedLinuxLibc` trusted computing base until a kernel `workstream` implements it, and that `workstream` is not claimed done. Lock order and `lockdep` are not claimed. The phase 0 lock names plus a linear `LockToken` are not implemented in this specifications repository. A proof hole is not success.
21. A progress model for the v28 `LockFree` claim is not written. Wait free proofs and obstruction free proofs are not claimed done. `RwLock` fairness is not claimed. `LockFree` is not the absence of `Mutex`.
22. v28 layout compatibility, virtual table compatibility, binary interface compatibility, and LLVM fragment compatibility, including a pinned Linux x86_64 data layout string, are not finished requirements beyond the `SafeLayout` sentence. The pin file named Layout.lean is package layout and is not created in this specifications repository. A partial proof is not success. The whole LLVM language reference is not a completion condition.
23. The v28 `atomics` catalog is not a finished requirement list here. Consume ordering is not specified. Weaker memory orders come later and are not claimed. `TSX` and hardware transactional memory stay residual. They are not an atomic transaction and they are not beastdb ACID. Compare and swap stays a technique and is not `LockFree`.
24. The v28 durability calls write, `pwrite`, `fsync`, `fdatasync`, `msync`, and O_DIRECT are not requirements in this document yet, and that call list is not `atomicity`, consistency, isolation, and durability. Specification 0003 remains the owner of durability for beastdb. A write ahead log attached to beastdb is not specified here.
25. v28 `LibcSL` and v28 `KernelSL` are rewrite `workstreams` and are not claimed done. This document does not invent a public product repository for either name. The first `LibcSL` surface names `memcpy`, `memset`, `malloc`, and free, in that order, and that surface is not done work here. The first `KernelSL` slice is startup, exit, and a documented system call slice. `PageCow` for POSIX fork is not in that first slice. A `futex` as an atomic on process shared memory, or on a word the kernel owns, is not a proved theorem. Firmware interrupt handling is later. A page cache is not read copy update. `Untyped` `glibc` allocation is not `UniqueBlock`.
26. v28 phased delivery of a `SafeC` package, including phases 0, 1, 2, 3, 4, 5, C, P, F, L, K, W, and B, is not claimed done in this repository. A trusted base note per profile is not a file in this tree. The package done condition that its README say `SafeC` v26 is not the version line of specification 0002. The prompt file itself is v28. A lake build of that package is not a build of this specifications repository. A proof hole is not success.
27. Classic v28 undefined behavior and language quirks for C, for C++, and for Rust are not yet a Fault catalog here. They stay correspondence until an isomorphism gate holds. Full ISO C and full ISO C++ as `isomorphisms` are not completion conditions. C undefined behavior that CompCert does not model stays residual, or stays `SafeKernel` only, and the island is named. An open emit or behavior delta is recorded and is not dropped.
28. Reproducing an existing artifact by writing rules is not a specification number. The v28 name `sleanify` has no specification number, is not a shipped skill pack, and names the operator loop that ingests an implementation, writes rules, runs Cons, reconciles deltas, and emits a `SafeC` or Slake rewrite. Lean Machine remains specification 0013 and is not a `SafeC` module. This document is not the Surmount product `roadmap`. FixOS remains the vision in Clause 4.4 and is not claimed shipped. The product name fit, and a file system built on beastdb, have no specification numbers and this document does not invent public repositories for them. `grok-oss` is not `SafeC`. The `gabriel` repository is out of `SafeC` scope. `bao-tree` is not FixOS and is not fit. The north star that names `sleanify`, `LibcSL`, `KernelSL`, Fargo, Wild Child, and beastdb is not a phase 0 done condition and is not a completion theorem.
29. Other v28 typing tools, including regions, capabilities, dependent lengths, and a separation logic argument that the `typer` matches Step, are not substitutes already proved in this document. The choice between iris-lean and a homegrown Step stays open. Hardware tagging is not a replacement for `UniqueBlock`.
30. Rules for v28 `ForkJoin` beyond the distinction from `PosixFork` are not specified here. Message passing of an owner or of bits across threads is not a finished channel.
31. A timing model, a cache model, or a page fault model for v28 `SafeCt` is not specified here. `SafeCt` stays off by default. This document does not claim that any later profile turns `SafeCt` on.
32. A v28 POSIX threads unlock on the `SafeKernel` side is not a proved constructor. Unlock without holding the lock is Reject when that constructor is claimed. CompCert does not prove that constructor.
33. v28 reclamation protocols, including hazard pointers, an epoch, a quiescent state, and read copy update, are not specified here. A `LockFree` claim that frees a node with no named reclamation protocol is not accepted as `LockFree`. That clash is now a Clause 5 Cons fixture proved False in the Systems Lean proofs module. That proof does not make Systems Lean or Slake ready for use.
34. Further v28 constructor clashes that were outside the five Clause 5 fixtures are Cons False in the Systems Lean proofs module. Those clashes include `CompCertFragment` together with an inline assembly island, a link face that exports `UniqueBlock` as bits, language level omega applied to a heap `OwnerHandle`, a unique only profile together with `PosixFork`, and `SafeMem` together with a data race on a cell that is not atomic. They are not comments. Those five proofs hold. A proof hole is not success. Those proofs do not make Systems Lean or Slake ready for use.
35. v28 pinned addresses, immortal device registers, arenas, file descriptors, and uninitialized owned storage are not fully modeled beyond the `SafeMem` sentences already stated. Bare metal is later and is not the `FreestandingKernel` profile this document requires now. Tracing garbage collection on product clean emit is not a goal. Upgrade without reboot is not specified here.
36. Pages larger than 4096 bytes for v28 `PageCow` are not specified here.
37. This document does not choose a canonical public GitHub organization for the systems-lean or beastdb repositories. Holy Lean, as named in specification 0013, is not a site vocabulary catalog, and this document does not adopt that v28 sentence. The public site at surmount.systems is not a clause of specification 0002.
38. Other type tools that prove no use after free or no undefined behavior, including tools named in v28 section 21, are not already proved substitutes for the Safe judgments in this document.
39. Closed meaning forks in v28 section 19, including repositories that exist and names with no public product repository yet, stay residual labor. This document does not invent a public product repository for a name that does not have one.
40. A trusted computing base note per profile (`TCB`.md in a `SafeC` package) is not a file in this specifications repository.
41. This document MUST NOT name a theorem `Perfect` or `ProvablyPerfect`. Those identifiers are banned as theorem names. A completion theorem is not that ban. Naming a theorem `Perfect` or `ProvablyPerfect` is Cons False in the Systems Lean proofs module. Systems Lean remains ongoing and is not ready for use.
42. The identifiers `AtomicCell` and `AtomicTxn` are named here and are not present theories. They stay residual. This document does not claim an atomic cell library is ready for use. Treating `AtomicCell`, `AtomicTxn`, `UsesLock`, and `LockHandled` as present theories is Cons False in the Systems Lean proofs module.
43. `Rust atomic types map to AtomicCell` plus methods, and that map is residual correspondence, not a finished isomorphism.
44. `CAS on UniqueBlock pointer Reject` is a named fixture and is proved False in the Systems Lean proofs module. That proof does not make Systems Lean or Slake ready for use.
45. `CAS on non-AtomicCell Reject` is a named fixture and is proved False in the Systems Lean proofs module. A data race on a cell that is not atomic is a different clash. That proof does not make Systems Lean or Slake ready for use.
46. The identifiers `UsesLock` and `LockHandled` are named here and are not present theories. Treating those identifiers as present theories is the same Cons False fixture as `AtomicCell` and `AtomicTxn` in item 42. `LockFree` MUST NOT mean that a `Mutex` is absent.
47. The `default trait object fat pointer fields` are size, align, drop, and methods, and that layout is residual correspondence, not an isomorphism. Clause 3.30 item 3 names Rust trait object tables and does not freeze those four fields as proved.
48. The `memcpy equation` is `CopyBits` of Bits, or a `LoanShared` source plus a `LoanMut` destination of the same length, and that equation is not a present theorem. Naming `memcpy` in the first `LibcSL` list is not that equation. Treating the `memcpy equation` as a present theorem is Cons False in the Systems Lean proofs module.
49. The identifier `LinkFace` is named here. A typed link input, and Cons on every export, stay residual and are not claimed proved. Treating a typed link input as proved is Cons False in the Systems Lean proofs module. Treating Cons on every export as proved is Cons False in the Systems Lean proofs module. A link face that exports `UniqueBlock` as bits is a different clash, and that clash is Cons False in the Systems Lean proofs module. Those names do not make Systems Lean or Slake ready for use.
50. beastdb `Props` are named here. Cons on those `Props` applies only when they attach, and Cons on those `Props` when they do not attach is proved False in the Systems Lean proofs module. Specification 0003 remains the owner of beastdb ACID. That proof does not make beastdb ready for use.
51. A `shift exponent out of range` is not yet a Fault catalog entry. Classic undefined behavior as a blanket residual is not that class.
52. The `sleanify observation list` is layout, aliasing, whether behavior is undefined, and side channel surface, and that list is not a shipped skill pack. Naming `sleanify` as an operator loop is not that list.
53. `Slake is not its own repository`. Clause 3.2 names Slake as the compiler written in Systems Lean and does not give Slake a second git tree in this specifications repository.
54. Linear and affine use in Clause 3.5 and Clause 4.1 item 2 MUST NOT be read as a proof of all undefined behavior. Those types stay correspondence until an isomorphism gate holds.

55. This document MUST name loans for framing, locks, file descriptors, and use after free as the four way use after free list. That coverage topic stays residual. A sentence that residual means no model yet MUST mean the model is not written yet, not that the language is smaller by silence.
56. A named Cons clash fixture MUST stay a `Bool` encoding set to false. That fixture is not a claim that every clash is listed. Treating the whole ISO C language as a finished completion condition MUST remain residual. The north star sentence that names `sleanify`, `LibcSL`, `KernelSL`, Fargo, Wild Child, and beastdb MUST NOT be read as a phase 0 done condition.
57. Linux kernel memory model barriers stay residual with that model. Copy on write at page grain for POSIX fork stays residual. Step and Fault remain specification objects until a `typer` matches Step. An exact owner count is later work and is not the default `malloc` path.
58. The identifiers `PhysPage` and `VirtBlock` are named here and are not present theories. Named `mmap` modes stay residual. `ThreadShared` is not `ProcessShared`. Those two words MUST stay distinct. Treating them as the same word is Cons False in the Systems Lean proofs module.
59. Until Wild Child exists, `ld`, `lld`, and the upstream Wild linker stay in the trusted computing base. This document MUST classify what can lock. Copy on write without a copy is named and is not a present theorem.
60. Wait free proofs and obstruction free proofs are not claimed done. The four ACID words stay in specification 0003. Shrinking the trusted computing base is a later goal and is not claimed done.
61. The identifiers `Block`, `Map`, `Site`, `Immortal`, `Pinned`, `MMIO`, `Arena`, and `Fd` are named here and are not present theories. A `Site` projects list is not a clause of this specifications repository.
62. The identifiers `Grade`, `Once`, omega as an owner, and `Frame` are named here. Bare metal later MUST NOT replace the `FreestandingKernel` profile this document requires now. The crate shapes `no_std`, Binary, and Library are named and are not claimed shipped.
63. A system call boundary is named and is not a proved theorem. Wild Child stays residual. Slake remains the compiler in Clause 3.2. The Slake row of the stack table is not a second repository. Fargo stays unnumbered. Fargo stack role and crate by crate elevation stay residual. The words Process, Parallelism, and Concurrency are named here and are not synonyms.
64. The identifiers `MessagePass`, `SWMR`, `MWMR`, `HwAtomic`, and `Ordering` are named here. A data race on a cell that is not atomic is Reject. C11 data race and C++ data race stay residual Fault classes.
65. The identifiers `Lock`, `Mutex`, `OnceLock`, and `Futex` are named here. `Once` and `OnceLock` stay residual. This document MUST record that every lock name is named. Linux once helpers and `smp` helpers stay residual correspondence and are not a present theorem.
66. Explicit packed vector operations remain the SIMD topic. Automatic packed vector operations are not a SIMD proof. Treating automatic packed vector operations as a SIMD proof is Cons False in the Systems Lean proofs module. The identifiers `HazardPointers`, `Epoch`, `QSBR`, `RCU`, and `ABA` are named here and are not present theories.
67. The identifiers `AlignedBuf`, `ValidView`, `Access`, and `RelPtr` are named here. `CheckBytes` and `ValidateArchive` stay residual correspondence.
68. `FixOS` remains the vision in Clause 4.4 and is not claimed shipped. The product name fit has no specification number. Store shape and labor for `FixOS`, fit, a file system, and Memex stay residual. The tree named `bao-tree` is not `FixOS` and is not fit.
69. An extra owner column is later work. Two reads are not a counted owner of two. An interior field is a range loan. The default `malloc` path has no refs field. `Allocator` models stay residual.
70. Gates A through F are named here. A crate that has completed only Gate A is not Safe. Treating that crate as Safe is Cons False in the Systems Lean proofs module. Proofs of gates D through F MAY lag. Fargo gates and copy on write lowering stay residual. fargo stays unnumbered.
71. The identifiers `Corresponds`, `toSafeC`, and `toRust` are named here. Rust `Box`, `Rc`, `Arc`, `Cow`, `Vec`, `Pin`, `Send`, and `Sync` stay residual correspondence. `ObjectCow`, `PageCow`, and `BorrowOrOwned` stay distinct.
72. `Cell`, `RefCell`, and `UnsafeCell` stay residual correspondence. Rust that Fargo cannot encode stays residual for each crate. ABI alignments stay residual. This document MUST name C representation padding first as the padding rule. This document MUST name not all of `rustc` as the `rustc` bound.
73. This document MUST name the Phase 0 pair. Phase 0 is not done in this specifications repository. A Phase 0 milestone is not a completion theorem.
74. Drop of a lock guard unlocking, and lock drop, stay residual constructors. Spin lock and condition variable are named here. Sequence lock is named. A sequence lock proof MAY lag. Lock order later stays residual. Structure modes stay residual.
75. Populate, locked, huge, and fixed map flags stay residual. Later map work is not claimed done. Product clean emit has no hidden heap. Interrupts and an interrupt model stay residual. Fork page copy on write is later.
76. Read copy update is not the page cache. The page cache is not read copy update. Treating the page cache as `RCU` is Cons False in the Systems Lean proofs module. `RCU` lookup is later. Uses are not identities. `glibc` allocation is not a proved `UniqueBlock`. `Crypto` key use stays residual.
77. Named pass fixtures stay residual: field loan then free, sequentially consistent fetch add, and arena end. Non-goals are bans. There is no early isomorphism theorem.
78. The two Safes remain `SafeKernel` and `SafeCompCert`. `Typer` versus Step stays residual. Linking stays residual until Wild Child exists. LLVM emit is not a CompCert proved path.
79. `IOMMU` and `DMA` stay residual. Capabilities stay residual. `CHERI` and `MTE` stay optional hardware tags. Hardware tagging does not replace `UniqueBlock`. Treating hardware tags as a `UniqueBlock` replacement is Cons False in the Systems Lean proofs module. Other holes need other types.
80. The product `grok-oss` is not the `SafeC` package. Treating `grok-oss` as `SafeC` is Cons False in the Systems Lean proofs module. That proof does not make Systems Lean or Slake ready for use.
81. Cons on Fargo rows and Cons on emit paths stay residual. A clash fails the build when Cons is wired. Heap omega as an owner is a refusal. Cons is not completeness.
82. Undefined behavior class maps, `fromC` and `fromLang`, use after free, invalid free, sequence point, following a null pointer, and pointer provenance stay residual Fault classes.
83. Iterator invalidation, this after lifetime, placement new lifetime, and `destructor` during unwind stay residual C++ Fault classes.
84. A proof sticker is not success. Reproduce by rules names the operator loop. A delta is first class. Reproduce step 1 and reproduce step 3 stay residual. A rewrite bar is not a specification number. Not constant time is not a `SafeCt` on switch.
85. Legal Lean and Holy Lean remain named components of specification 0013 without separate numbers. Companion encodings MUST treat glossary words as `inductive` types. Glossary words MUST NOT clash as if they were one constructor.
86. The v28 Grok Build prompt instructions, the `cache-bust` marker, and the END PROMPT line are prompt process. They MUST NOT be read as 0002 language law. Residual still names that prompt process.

## 7. Changelog

### 0.1.0 - 20260831

Current version line is 0.1.0 by operator order. Changelog history records that a 1.0.0 line existed. Application and neurosymbolic integration for SSSSS live in `0004_SSSSS.md`. Lean Machine is specified in `0013_Lean_Machine.md`.

This 0.1.0 entry also records clarifying clauses for Safe judgments. Definitions in Clause 3.11 through Clause 3.48 name `SafeMem`, `SafeThr`, `SafeLayout`, `KernelModelOk`, `SafeKernel`, `CompCertFragment`, `CompCertRefines`, `SafeCompCert`, Reject, Fault, Step, `TyperSound`, `PanicFree`, `PanicFreeAOT`, Bits, `UniqueBlock`, an alias protocol, five passing modes, grades mapped onto multiplicities 0, 1, and omega, four profiles, words that are not synonyms, correspondence before isomorphism, Cons, `container_of`, the lock catalog, `LockToken`, `LockFree`, the four transaction words, `ObjectCow`, `PageCow`, `BorrowOrOwned`, `PosixFork`, Secret, `DontFork`, `WipeOnConsume`, `SafeCt`, Fargo gates A through F, and the emit split. Those clauses keep Slake primary emit as freestanding C and keep `HostedLinuxLibc` additional.

Requirements in Clause 4.5 and conformance items in Clause 5 keep `SafeCompCert` implying `SafeKernel`, keep the converse false, keep the named Cons fixtures false, keep CompCert `ccomp` on a Safe path only when `SafeCompCert` holds, and keep an LLVM or `cc` path from being called proved by CompCert when only `SafeKernel` holds. The existing CompCert obligation for the freestanding C emit stays. Heap use of omega as an owner is a refusal, and that refusal is not the many uses of Bits. fargo stays unnumbered. Proved ACID for beastdb and tries that do not use locks stay in `0003_beastdb.md`. Clause 6.4 items 41 through 86 name sampled v28 topics that were silent, including banned theorem names `Perfect` and `ProvablyPerfect`, `AtomicCell`, `AtomicTxn`, `UsesLock`, `LockHandled`, `LinkFace`, beastdb `Props`, the `memcpy equation`, a `shift exponent out of range`, the `sleanify observation list`, that `Slake is not its own repository`, that `Rust atomic types map to AtomicCell`, the `default trait object fat pointer fields`, `CAS on UniqueBlock pointer Reject`, and `CAS on non-AtomicCell Reject`. Items 55 through 86 name the remaining silent coverage topics, including `framing, locks, FDs, and UAF`, `residual means no model yet`, `C representation padding first`, `not all of rustc`, `Linux once and smp helpers`, `every lock name is named`, the `Phase 0 pair`, `glossary as inductives`, and `glossary words do not clash`. Version remains 0.1.0. These sentences do not publish a new SemVer.

### 1.0.0 - 20260824

First publication. Defines Systems Lean as Lean 4 with linear and affine ownership and Quantitative Type Theory multiplicities 0, 1, and omega; names Slake as the freestanding compiler product; requires a freestanding product wire without managed Lean runtime or garbage collection; requires residual honesty; states Unlicense and language set hygiene for novel Systems Lean and Slake source trees; and requires named high assurance stack components to be able to target Slake.

This unpublished 1.0.0 also records: CompCert verified compilation of the freestanding C emit is a required core validation step, not comparison language; bootstrapping a Slake compiler that fully typechecks is a required core validation step; Lean 4, Idris 2, CompCert, and Rust Form 1 pins live in the Systems Lean product tree (`ref/lean4`, `ref/Idris2`, `ref/CompCert`, `ref/rust`) and are not pins of this specifications repository's `ref/`; the Smart Symbolic Supercompiler is specified in `0004_SSSSS.md` (not 0003, and not this document); beastdb is specified in `0003_beastdb.md`; Recursive Self Improvement is specified in `0006_RSI.md` and is not a compiler requirement of this document.

This specification is number 0002. The Smart Symbolic Supercompiler is specified in `0004_SSSSS.md` and is not this document. It is not specification 0003.

This unpublished 1.0.0 also records that hyphenated modifiers in prose were rephrased into ordinary English. Deleting the hyphen and leaving the same two words is not enough.

This unpublished 1.0.0 also records that citations of Keagan McLelland (Proof of Keags) research SHALL keep the publisher links on those pages (back linking).

No prior public release of this specification exists.

## 8. Copyright

This work is released into the public domain under the Unlicense as specified in `0009_PDOSS.md`. Anyone is free to copy, modify, publish, use, compile, sell, or distribute this specification, either in source code form or as a compiled binary, for any purpose, commercial or noncommercial, and by any means. See `UNLICENSE.md` in this repository. Novel Systems Lean source is likewise Unlicensed. Upstream components retain their original licenses.

## 9. Acknowledgments

Author: Hunter "cryptoquick" Beast.

This work is significantly inspired by the research and public talks of Keagan McLelland (Proof of Keags), particularly:

1. Formal Vibefication (2026-05-12) - https://proofofkeags.com/research/2026-05-12-formal-vibefication.html
2. Taking "Don't Trust. Verify." Seriously (2026-07-20) - https://proofofkeags.com/research/2026-07-20-taking-dont-trust-verify-seriously.html
3. Formal Verification of Bitcoin BitDevs talk (2026-07-14) - https://www.youtube.com/watch?v=E0VjopN2sgg

Those pages and that talk are research and presentation. They are not external specifications under `0000_spec.md` Clause 12. Citations of this work SHALL keep those publisher links (back linking).

The author first encountered a clear explanation of the Curry-Howard isomorphism through the work of Keagan McLelland.
