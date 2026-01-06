# Deterministic Engine

## Overview

This project is a **deterministic computation engine** designed to demonstrate **low-level systems engineering**, **formal correctness**, and **modern toolchain integration**.

The engine is intentionally split across three languages, each chosen for a *specific engineering responsibility*:

* **Ada** — correctness, determinism, contracts, and safety
* **Zig** — low-level integration, memory control, and C ABI stability
* **Julia** — orchestration, numerical experimentation, and performance analysis

The result is a minimal but serious system that mirrors how real-world **critical cores**, **native libraries**, and **scientific front-ends** are built.

---

## What This Engine Does

At its core, the engine implements a **deterministic state machine** that evolves step-by-step according to strict invariants.

Characteristics:

* Fully deterministic execution
* Explicit state transitions
* No hidden runtime behavior
* No garbage collection
* No implicit memory allocation

Typical operations:

* Initialize a system state
* Advance the state by one deterministic step
* Validate invariants before and after each step
* Expose the engine through a stable C ABI

The engine is intentionally simple in scope but strict in correctness, making it suitable as:

* A simulation core
* A risk or rule evaluation engine
* A numerical or scientific backend
* A reference design for safe low-level systems

---

## Architecture

```
Julia (HPC / Orchestration)
        ↓ ccall
Zig (ABI / Memory / Build)
        ↓ C ABI
Ada (Deterministic Core)
```

---

### Ada — Deterministic Core

Ada implements the **entire domain logic**:

* State definitions
* Valid state invariants
* State transitions
* Contracts (`Pre`, `Post`, invariants)
* Optional concurrency using tasks or protected objects

Ada code is written under the assumption that:

* Every invariant matters
* Every invalid state is a bug
* Correctness is enforced by the language

Example responsibilities:

* Validate state consistency
* Perform deterministic updates
* Reject invalid transitions at runtime through contracts

---

### Zig — Low-Level Integration Layer

Zig acts as the **systems glue**:

* Exposes a clean C ABI
* Manages memory explicitly
* Owns the build process
* Provides predictable linking and cross-compilation

Zig does **not** contain business logic.
Its role is to make the Ada core safely and predictably consumable by external systems.

Responsibilities:

* `export fn` symbols
* Pointer-safe wrappers
* Memory allocation strategies
* Static or dynamic library generation

---

### Julia — Scientific Front-End

Julia is used as a **consumer**, not a controller.

Responsibilities:

* Calling the engine via `ccall`
* Running deterministic simulations
* Handling error conditions
* Benchmarking and performance analysis
* Numerical experimentation and visualization

Julia allows rapid exploration while relying on the native engine for correctness and speed.

---

## Error Handling and Contracts

Correctness is enforced through **Ada contracts** (`Pre`, `Post`, and invariants).

If a contract is violated:

* The Ada core raises an exception
* The exception does **not** cross language boundaries
* The ABI layer translates the failure into an explicit error condition
* No undefined behavior is allowed
* The final consumer (Julia) decides how to handle the failure

This design guarantees:

* Deterministic failure modes
* No hidden control flow
* No silent state corruption
* Clear responsibility boundaries

Invalid state transitions are treated as **programmer errors**, not recoverable runtime events.

---

## Project Goals

This project is intentionally designed to demonstrate:

* Formal thinking in systems programming
* Mastery of multiple abstraction layers
* Understanding of ABI boundaries
* Clear separation of responsibilities between languages
* Engineering discipline over convenience

It is **not** intended to be a framework or a product.
It is a **technical statement**.

---

## Repository Structure

```
engine/
├── ada/        # Deterministic core (Ada)
├── zig/        # ABI layer and build system (Zig)
├── julia/      # Orchestration and analysis (Julia)
├── include/    # Public C headers
└── README.md
```

---

## Build and Usage (High-Level)

1. Build the native engine using Zig
2. Produce a shared or static library
3. Load the library from Julia using `ccall`
4. Run deterministic simulations or analyses

Detailed build instructions are intentionally kept minimal to focus on architecture and design.

---

## Design Philosophy

* Correctness over convenience
* Explicit over implicit
* Determinism over performance hacks
* Engineering clarity over abstraction layers

This project reflects how **serious systems are designed**, not how demos are usually written.