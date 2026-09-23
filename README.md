# Portable Lubuntu AI VM

A portable Lubuntu virtual machine running from removable storage through QEMU, with the long-term goal of building a portable custom AI environment.

## Project Goal

Create a self-contained Linux environment that can be carried on removable storage and developed into a custom AI workstation.

## Current Status

The Lubuntu VM has been created and the full Lubuntu installation has been started.

The installation reached approximately **90%** during the current session.

## Tomorrow — Handoff

**Do not start a new installation yet.**

1. Preserve the existing `LubuntuVM.img`.
2. Start QEMU using the existing virtual disk.
3. First attempt to boot the installed system **without the ISO**.
4. If it does not boot, inspect the existing virtual disk before reinstalling.
5. Only reinstall if the existing installation is unusable.
6. Once Lubuntu boots successfully, copy the complete VM environment to the portable SSD.
7. Then begin setting up the custom AI environment.

### Direct Boot Command

Use this to test the existing virtual disk without the installer ISO:

```cmd
qemu-system-x86_64.exe -accel tcg -m 3G -smp 2 -vga std -global isa-fdc.fdtypeA=none -global isa-fdc.fdtypeB=none -drive file="E:\LubuntuVM.img",format=raw,if=ide -boot order=c
```

## Working Installer Command

If the ISO is needed again, this is the known-good configuration:

```cmd
qemu-system-x86_64.exe -accel tcg -m 3G -smp 2 -vga std -global isa-fdc.fdtypeA=none -global isa-fdc.fdtypeB=none -drive file="E:\LubuntuVM.img",format=raw,if=ide -cdrom "E:\lubuntu-26.04.1-desktop-amd64.iso" -boot order=d
```

## Files

- `QEMU\` — portable QEMU executable and required DLLs
- `lubuntu-26.04.1-desktop-amd64.iso` — Lubuntu installer
- `LubuntuVM.img` — virtual hard disk containing the Lubuntu installation

## Long-Term Plan

After the base VM is confirmed working:

- Move the environment to a larger portable SSD.
- Configure Lubuntu for development.
- Add local AI tools and models.
- Build the custom AI environment inside the VM.
