# VIGIL Development Environment Plan for Portable Lubuntu

This document defines the planned development environment for building and testing **VIGIL (Visual Intelligence & Geographic Information Layer)** inside the portable Lubuntu AI VM.

The guiding principle is:

> **Do not turn Lubuntu into an AI playground first. Turn it into a VIGIL engineering workstation that happens to have a local AI subsystem.**

## 1. Architecture

The intended relationship is:

```
Portable Lubuntu VM
        │
        ├── VIGIL development environment
        │
        ├── VIGIL test / simulation lab
        │
        └── Local AI subsystem
                │
                ├── AI runtimes
                └── Local models
```

VIGIL remains the primary software system. Local AI services are supporting capabilities that VIGIL may call when appropriate.

The VIGIL architecture remains information-first:

```
Sensors / Authorized Data Sources
        ↓
Observations
        ↓
Detections
        ↓
Tracking
        ↓
Spatial / Temporal Fusion
        ↓
Spatial World Model
        ↓
Spatial / Environmental Services
        ↓
Relevance & Priority
        ↓
Attention / Presentation
        ↓
User
        ↓
Human Decision / Action
```

AI must not become the authority over the World Model or the human decision boundary.

---

## 2. Development Foundation

The base Lubuntu environment should include:

- Git
- GitHub CLI
- OpenSSH
- curl
- wget
- jq
- unzip / zip
- rsync
- tree
- htop or btop
- tmux
- build-essential
- GCC / G++
- Make
- CMake
- Ninja
- pkg-config
- Python 3
- pip

### Java / Gradle

VIGIL's Java/Gradle development environment should use:

- OpenJDK
- Gradle wrapper supplied by the VIGIL repository
- Java debugging tools
- JUnit support

The **Gradle wrapper remains canonical** for project builds rather than depending on an arbitrary globally installed Gradle version.

Canonical project operations should remain things such as:

```bash
./gradlew test
./gradlew build
```

The exact JDK/toolchain version should be taken from the VIGIL repository's Gradle configuration and CI configuration rather than guessed.

---

## 3. IDEs and Editors

### Primary: VS Code

VS Code should be the primary portable editor.

Useful extensions include:

- Java
- Gradle
- Git
- Markdown
- YAML
- JSON
- GitHub Actions
- C / C++
- Python

### Secondary: IntelliJ IDEA Community

IntelliJ IDEA Community should be available for deeper Java/Gradle navigation, refactoring, and debugging.

The command line remains authoritative for builds and tests so that development does not depend on a particular IDE.

---

## 4. Containers

Docker and Docker Compose should be available, but VIGIL should **not** be containerized immediately.

Containers are better used initially for supporting infrastructure such as:

- databases
- experimental AI services
- reproducible test environments
- sensor simulators
- integration-test services

VIGIL itself should remain straightforward to build and run directly during the early development stages.

---

## 5. Local AI Runtime

### Primary runtime: llama.cpp

llama.cpp should be the primary portable local inference runtime.

Reasons:

- broad CPU and GPU backend support
- quantized model support
- CPU/GPU hybrid inference
- portable deployment
- GGUF model ecosystem
- `llama-server` provides an OpenAI-compatible API

The goal is to make local AI a service that VIGIL can call rather than embedding one specific model directly into the VIGIL architecture.

### Secondary runtime: Ollama

Ollama can be installed as a convenience runtime for quick model testing and model management.

It should remain secondary rather than becoming a fundamental VIGIL dependency.

---

## 6. Local Model Strategy

Do **not** fill the portable drive with a large collection of unrelated models.

The initial model set should be deliberately small.

### Small general model

Start with one small model in approximately the **1–4B class** for:

- lightweight commands
- explanations
- simple VIGIL queries
- basic development assistance
- low-resource local inference

The exact model should be selected after the actual host hardware is known.

### Main reasoning / coding model

Add one larger **7–14B-class** reasoning/coding model when the physical host's RAM/VRAM and storage capacity justify it.

This should be the main local model for:

- deeper coding assistance
- architecture discussion
- log interpretation
- VIGIL development questions
- more complex reasoning tasks

The current QEMU configuration only provides **3 GB RAM and 2 virtual CPUs**, so a large local model should not be treated as a requirement for the current VM baseline.

### Embedding model

Add one dedicated embedding model for:

- semantic retrieval
- searching VIGIL documentation
- historical observations
- experiment records
- local knowledge bases
- future VIGIL memory/retrieval experiments

### Vision / multimodal model

Vision-language models should be added later.

They belong in the roadmap because VIGIL is intended to work with spatial information and eventually richer sensor inputs, but they should not be the first priority for the portable environment.

### Speech recognition and synthesis

Speech recognition and speech synthesis should also be added later.

The architecture should reserve these capabilities because VIGIL already includes work around:

- voice recognition
- speech synthesis
- response provenance
- voice failure handling
- explicit human confirmation at the interaction boundary

---

## 7. Databases

Start with:

- SQLite

Add later:

- PostgreSQL
- PostGIS

PostGIS should eventually be evaluated because VIGIL is fundamentally spatial and will benefit from mature spatial database capabilities.

---

## 8. Spatial Development Laboratory

Python should serve as the experimental/laboratory environment while Java remains part of the production VIGIL architecture.

Install or make available:

- Python 3
- NumPy
- SciPy
- pandas
- matplotlib
- Jupyter
- GDAL
- PROJ
- GeoJSON tooling
- GeoPandas
- Shapely
- additional raster/geospatial tools as VIGIL requirements become clearer

Python is primarily for:

- experiments
- data analysis
- spatial prototyping
- visualization
- model evaluation
- sensor-data exploration
- benchmarks

---

## 9. VIGIL Laboratory Directory

Create a dedicated laboratory workspace:

```
~/vigil-lab/
├── models/
├── datasets/
├── sensor-sim/
├── recordings/
├── replay/
├── benchmarks/
├── notebooks/
├── experiments/
└── logs/
```

This keeps experimental data separate from the main VIGIL source tree.

---

## 10. Lubuntu / Removable Drive Layout

The intended portable drive layout is:

```
E:\
├── QEMU\
├── LubuntuVM.img
└── AI\
    ├── models\
    │   ├── small\
    │   ├── reasoning\
    │   ├── vision\
    │   └── embeddings\
    ├── runtimes\
    │   ├── llama.cpp\
    │   └── ollama\
    └── projects\
        └── VIGIL\
```

Inside Lubuntu:

```
~/VIGIL/
~/vigil-lab/
~/ai-models/
~/ai-runtime/
~/datasets/
```

The removable drive becomes the portable boundary for the development environment while the VM provides the Linux development platform.

---

## 11. Installation Stages

### Stage 1 — Development Foundation

Install and configure:

- Git
- GitHub CLI
- OpenJDK
- VIGIL Gradle wrapper support
- GCC / G++
- CMake
- Ninja
- Python
- VS Code
- IntelliJ IDEA Community
- Docker
- standard Unix development utilities

### Stage 2 — VIGIL Laboratory

Add:

- Jupyter
- NumPy
- SciPy
- pandas
- matplotlib
- SQLite
- PostgreSQL
- spatial tooling
- benchmark tooling
- sensor simulation/replay tooling

### Stage 3 — Local AI

Add:

- llama.cpp
- Ollama
- GGUF model storage
- one small local model
- one main reasoning/coding model when hardware allows
- one embedding model

### Stage 4 — VIGIL Interaction

Add and test:

- speech recognition
- speech synthesis
- vision/multimodal models
- multimodal test data
- AI/VIGIL API boundaries
- human-confirmation behavior
- provenance and failure handling

---

## 12. Hardware Reality

The current portable VM is a development baseline, not the final local-AI hardware configuration.

Current documented QEMU startup resources are:

- 3 GB RAM
- 2 virtual CPUs
- software TCG acceleration

That is sufficient to establish the Linux development environment and work on VIGIL, but it places strong limits on useful local model inference.

The long-term plan is to move the environment to a larger portable SSD and, where available, take advantage of stronger physical host CPU/GPU resources.

Model selection should therefore remain hardware-aware rather than locking the project to oversized models too early.

---

## 13. VIGIL / AI Boundary

The most important architectural rule is:

> **Local AI assists VIGIL; local AI does not become VIGIL's authority.**

AI-generated information should enter the VIGIL pipeline through explicit interfaces.

Important properties include:

- provenance
- confidence
- uncertainty
- freshness
- source identification
- explicit boundaries between observations and authoritative world state
- human confirmation where required

The authoritative World Model must remain protected from uncontrolled AI mutation.

---

## 14. Near-Term Goal

The immediate objective is not to build a complete local AI platform.

The immediate objective is to create a **portable VIGIL engineering workstation** capable of:

1. building VIGIL,
2. testing VIGIL,
3. simulating inputs,
4. replaying observations,
5. analyzing spatial data,
6. running small local AI models,
7. experimenting with AI/VIGIL interfaces,
8. preserving provenance and human confirmation boundaries,
9. remaining portable across compatible Windows systems.

The AI subsystem can then grow as the hardware, VIGIL architecture, and model requirements mature.

---

## 15. Future Direction

Once the basic environment is stable, the next engineering pass should determine:

- VIGIL's exact Java/JDK requirements
- Gradle/toolchain requirements
- CI-matching development packages
- physical host RAM and GPU capabilities
- appropriate model sizes
- local inference benchmarks
- model/API boundaries
- sensor simulation architecture
- spatial database requirements
- speech and vision integration requirements

The portable Lubuntu environment should evolve alongside VIGIL rather than becoming a separate project with incompatible assumptions.

---

## Core Principle

**Lubuntu is the portable engineering platform.**

**VIGIL is the system being engineered.**

**Local AI is a supporting subsystem.**

That separation should remain intact as the project grows.
