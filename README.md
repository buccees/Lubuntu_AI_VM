# Portable Lubuntu AI VM — Project Summary

## Purpose

This project documents the creation of a portable Lubuntu virtual machine that can be stored on removable storage and used from a Windows computer without installing Linux directly onto the host.

The longer-term goal is to use this portable Linux environment as a foundation for a custom, portable AI workstation.

## Environment

- Host: Windows library computer
- Administrative access: unavailable
- Physical storage: 28 GB USB flash drive
- USB filesystem: NTFS
- Linux distribution: Lubuntu 26.04.1 Desktop AMD64
- Installer: `lubuntu-26.04.1-desktop-amd64.iso`
- Virtualization: QEMU for Windows
- QEMU executable: `qemu-system-x86_64.exe`
- Virtual disk: `LubuntuVM.img`
- Virtual disk format: raw
- Virtual disk size: 12 GiB
- QEMU RAM used: 3 GiB
- QEMU virtual CPUs: 2
- CPU acceleration: TCG/software emulation

## Why QEMU

The host computer does not permit booting another operating system from USB and does not provide administrative access for installing virtualization software.

QEMU can be run directly from removable storage, allowing the emulator, its DLLs, the Lubuntu ISO, and the virtual hard disk to remain together.

This is a portable virtual machine, not a bootable USB Linux installation.

## USB Layout

```
E:\
├── QEMU\
│   ├── qemu-system-x86_64.exe
│   └── required QEMU DLLs
├── lubuntu-26.04.1-desktop-amd64.iso
└── LubuntuVM.img
```

## Virtual Disk Creation

The virtual disk was created with:

```
qemu-img.exe create -f raw "E:\LubuntuVM.img" 12G
```

Windows verified the resulting file as:

```
12,884,901,888 bytes
```

This confirms the 12 GiB virtual hard disk exists on the USB.

## Known-Good QEMU Command

The working configuration reached the Lubuntu graphical Try/Install screen:

```
qemu-system-x86_64.exe -accel tcg -m 3G -smp 2 -vga std -global isa-fdc.fdtypeA=none -global isa-fdc.fdtypeB=none -drive file="E:\LubuntuVM.img",format=raw,if=ide -cdrom "E:\lubuntu-26.04.1-desktop-amd64.iso" -boot order=d
```

The `fdtypeA=none` and `fdtypeB=none` options disable the unused virtual floppy drives and avoid the earlier `fd0` I/O errors.

A GTK warning about loading a pixbuf from the icon theme may appear. It did not prevent QEMU from starting.

## Installation

The Lubuntu graphical environment was reached successfully.

The **Install Lubuntu** button was opened and the installation was started on the 12 GiB virtual disk using the **Full Install** option, with the intent of installing the complete Lubuntu desktop environment and included software rather than a minimal installation.

The installation progressed through at least 90%. During installation, the display briefly went black at several points while the installer continued progressing. The installer also displayed a contextual process stage.

At 90%, the installation had already written most of the system to the virtual disk. If the session ends before 100%, the existing image should be preserved and tested before considering reinstallation.

## Partial Installation Recovery

If the library session ends before installation completes, preserve `E:\LubuntuVM.img`.

The Lubuntu installer does not normally provide a general resume-from-partial-installation function. Instead of automatically deleting the image and reinstalling, inspect the existing image first.

Recovery procedure:

1. Preserve the existing `LubuntuVM.img`.
2. Inspect its partition table and filesystems.
3. Determine whether Linux installation files and boot information were created.
4. Attempt to boot the existing image directly.
5. Reinstall only when inspection shows the image cannot be used.

The first direct-boot test should use the existing image **without attaching the Lubuntu ISO**:

```
qemu-system-x86_64.exe -accel tcg -m 3G -smp 2 -vga std -global isa-fdc.fdtypeA=none -global isa-fdc.fdtypeB=none -drive file="E:\LubuntuVM.img",format=raw,if=ide -boot order=c
```

This tells QEMU to boot from the virtual hard disk rather than returning to the installer ISO.

## Portable SSD Plan

After QEMU is shut down, the complete environment can be copied to a larger portable SSD.

Preserve at minimum:

- The entire `QEMU\` directory
- `lubuntu-26.04.1-desktop-amd64.iso`
- `LubuntuVM.img`

Do not copy `LubuntuVM.img` while QEMU is actively writing to it. Shut down the VM first.

The SSD then acts as the portable container for the virtual computer.

## Custom AI Direction

Once the Lubuntu VM is working, it can become a portable AI development environment.

Potential components include:

- Python
- Git
- PyTorch
- Transformers
- llama.cpp
- Local language models
- Local AI interfaces
- RAG/document retrieval
- Knowledge bases
- Custom AI scripts and agents
- AI projects and repositories

Possible organization inside Lubuntu:

```
/home/user/AI/
├── models/
├── projects/
├── knowledge/
├── conversations/
└── scripts/
```

The VM image can contain the operating system, software configuration, AI applications, projects, and settings together.

## Performance

The current configuration is deliberately modest:

```
3 GiB RAM
2 virtual CPUs
TCG software emulation
```

It is intended to establish the portable environment first. Larger AI models will require more resources.

On a more capable host, QEMU can be given additional RAM and CPU resources without rebuilding the entire VM.

## Current Status

### Completed

- QEMU Windows files obtained
- Required QEMU DLLs present
- Lubuntu 26.04.1 ISO present
- 12 GiB virtual disk created
- Virtual disk verified
- QEMU launched without administrator installation
- Lubuntu graphical boot environment reached
- Lubuntu installer launched
- **Full Install** selected
- Installation progressed to at least 90%
- Floppy devices disabled in the working QEMU command

### In Progress

- Complete Lubuntu installation
- Verify the installed virtual disk
- Boot the installed system without the installer ISO

### Next Milestone

1. Complete installation if the session remains available.
2. Shut down Lubuntu cleanly.
3. Preserve `LubuntuVM.img`.
4. Boot QEMU without the ISO.
5. Verify the installed system boots from the virtual disk.
6. If the installation was interrupted, inspect and attempt to boot the existing image before reinstalling.
7. Copy the complete environment to a larger portable SSD.
8. Begin building the custom AI environment.

## Architecture

```
Portable SSD
    │
    ├── QEMU
    │
    ├── Lubuntu installer ISO
    │
    └── LubuntuVM.img
             │
             └── Lubuntu + custom AI environment
```

The SSD is the portable container, `LubuntuVM.img` is the virtual computer's hard drive, QEMU supplies the virtual hardware, and Lubuntu supplies the Linux operating system.
