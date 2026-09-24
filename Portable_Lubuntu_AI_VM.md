# Portable Lubuntu AI VM — Project Summary

## Purpose
This document records the current working state of the portable Lubuntu VM experiment so the setup can be reproduced and resumed without administrative access.

## Project Goal
Build a portable Lubuntu environment that can run from removable storage through QEMU, then develop it into a portable custom AI environment.

## Current Working State
The Lubuntu installation is complete and boots successfully from the persistent virtual disk without the installer ISO.
The VM disk is E:\LubuntuVM.img.
The portable QEMU directory is E:\QEMU\.
The QEMU directory contains the matching executable and supporting DLLs required by the working setup, including libgnutls-30.dll.
The working launcher is qemu-system-x86_64.exe. The original Windows GUI executable is preserved as qemu-system-x86_64w.exe.
The working qemu-system-x86_64.exe was restored from that original matching executable. A separate standalone QEMU executable was tested during recovery but was not retained because it did not match the existing DLL set.

## Normal Startup
Open Command Prompt and run:

    E:
    cd \QEMU
    qemu-system-x86_64.exe -accel tcg -m 3G -smp 2 -vga std -global isa-fdc.fdtypeA=none -global isa-fdc.fdtypeB=none -drive file="E:\LubuntuVM.img",format=raw,if=ide -boot order=c

This is the persistent startup procedure for the current setup. Changes made inside Lubuntu are stored in LubuntuVM.img, so the VM installation persists between launches.

## Important Startup Rules
- Do not recreate or delete LubuntuVM.img.
- Do not attach the installer ISO during normal startup.
- Keep the matching QEMU executable and DLLs together in QEMU\.
- Do not replace the working QEMU executable with an unrelated standalone build unless the entire matching QEMU bundle is also replaced.
- The command assumes the removable drive is assigned E:.
- If Windows assigns the removable drive another letter, update the drive letter in the command.

## Installer Configuration
The known-good installer configuration remains available if a deliberate reinstall is ever required:

    qemu-system-x86_64.exe -accel tcg -m 3G -smp 2 -vga std -global isa-fdc.fdtypeA=none -global isa-fdc.fdtypeB=none -drive file="E:\LubuntuVM.img",format=raw,if=ide -cdrom "E:\lubuntu-26.04.1-desktop-amd64.iso" -boot order=d

This command is not for normal startup.

## Installation History
- QEMU was configured for TCG/software emulation.
- VM configuration: 3 GB RAM, 2 virtual CPUs, standard VGA.
- Floppy drives were explicitly disabled after floppy I/O errors appeared.
- A 12 GiB raw virtual disk was created as LubuntuVM.img.
- Lubuntu was installed using the full installation option.
- The installation completed successfully.
- The system was subsequently booted without the ISO.
- The Lubuntu desktop was reached successfully.
- The QEMU executable later became a 0-byte file and was removed.
- The original matching QEMU Windows executable and DLL bundle were still present in E:\QEMU\.
- The original executable was restored and the VM successfully launched again.
- The VM image was later expanded from 12 GiB to 20 GiB.
- The Lubuntu partition and filesystem were expanded to use the additional virtual disk space.
- The current setup remains intact and persistent.

## Portable File Layout
    E:\
    ├── QEMU\
    │   ├── qemu-system-x86_64.exe
    │   ├── qemu-system-x86_64w.exe
    │   ├── QEMU DLL files
    │   ├── lib\
    │   └── share\
    ├── LubuntuVM.img
    └── lubuntu-26.04.1-desktop-amd64.iso

## Portable AI Storage Plan
A second removable USB/SSD will be used as dedicated AI and project storage, separate from the Lubuntu VM disk.

Planned structure:

    AI_USB\
    ├── Models\
    │   ├── OpenAI\
    │   │   └── gpt-oss-20b\
    │   └── Google\
    │       └── Gemma\
    ├── Runtime\
    │   └── AI-Controller\
    ├── Projects\
    ├── Conversations\
    ├── Datasets\
    └── Backups\

The storage drive should keep large model files and project data outside the 20 GiB Lubuntu virtual disk. The VM will eventually mount or otherwise access this storage separately.

## Multi-Model Local AI Plan
The long-term AI environment will support two local open-weight model families:

- OpenAI gpt-oss, initially targeting gpt-oss-20b.
- Google Gemma as the local Google model family.

OpenAI states that gpt-oss models are open-weight models intended to run on infrastructure controlled by the user. gpt-oss-20b is designed for local inference and requires approximately 16 GB of memory for its published configuration. The models are available under the Apache 2.0 license and can be used with local runtimes such as Ollama and llama.cpp.

The current VM has only 3 GB RAM, so the gpt-oss-20b model should not be installed for execution inside the VM until the hardware/runtime architecture is adjusted. The model files can still be stored on the separate AI USB.

## AI-to-AI Controller
The project will eventually include a local controller that can communicate with both model families.

The controller will provide a common interface for:
- Sending the same problem to both models.
- Passing one model's response to the other for critique.
- Allowing the models to exchange multiple rounds of analysis.
- Combining or presenting their responses to the user.
- Assigning different roles such as coding, research, review, or planning.
- Keeping conversations and project context on the portable storage.

Target architecture:

    User
      |
      v
    AI Controller
      |----------------------|
      v                      v
    OpenAI gpt-oss        Google Gemma
      |                      |
      |<------ AI-to-AI ---->|
      |                      |
      +----------+-----------+
                 |
                 v
          Combined response

The controller should be designed so the model execution layer can later run inside the VM, on the host machine, or in a hybrid configuration depending on available RAM, CPU, GPU, and portability constraints.

The goal is not merely to install two unrelated local chat programs. The goal is to create a portable multi-model AI workspace in which the models can collaborate with one another through a controlled local interface.

## Development Phase
1. Move the environment to larger portable SSD storage.
2. Confirm the VM still boots from the new location.
3. Configure Lubuntu for development.
4. Establish the development and tooling workflow.
5. Prepare the separate AI USB/SSD and portable storage structure.
6. Install the local AI runtime/controller.
7. Add a compatible Google Gemma model.
8. Add OpenAI gpt-oss-20b when the execution hardware can support it.
9. Build the AI-to-AI communication and review layer.
10. Add persistent conversations, projects, datasets, and configuration.
11. Test portable operation on compatible machines without administrative installation.
12. Document the resulting portable workflow so it can be reproduced on other compatible machines without administrative access.

## Portability Objective
The environment is intended to remain portable and usable on compatible machines without requiring administrative installation.
The removable storage can eventually be moved to a larger portable SSD. Before moving it, Lubuntu should be shut down cleanly and the complete QEMU directory and VM image should be copied.

The separate AI storage should remain independent from the VM image so the models and project data can be moved or upgraded without rebuilding Lubuntu.

## Recovery Principle
If QEMU stops launching, troubleshoot the QEMU executable and its matching DLL bundle first.
The persistent VM disk is independent of the QEMU executable. A QEMU launcher problem does not mean the Lubuntu installation needs to be recreated.
Always protect LubuntuVM.img before attempting repairs to QEMU.
