# Portable Lubuntu AI VM

A portable Lubuntu virtual machine running from removable storage through QEMU, with the long-term goal of building a portable custom AI environment.

## Project Goal

Create a self-contained Linux environment that can be carried on removable storage and developed into a custom AI workstation.

## Current Status

The Lubuntu VM is installed and has been successfully booted from the existing virtual disk without the installer ISO.

The portable QEMU bundle is also working again. The original matching QEMU executable and DLL set are preserved in `QEMU\`.

## Starting Lubuntu

The VM is persistent: changes made inside Lubuntu are stored in `LubuntuVM.img`. The startup command below can be used again each time, as long as the portable drive keeps the same drive letter and the files remain in the same locations.

Open Command Prompt and run:

```cmd
E:
cd \QEMU
qemu-system-x86_64.exe -accel tcg -m 3G -smp 2 -vga std -global isa-fdc.fdtypeA=none -global isa-fdc.fdtypeB=none -drive file="E:\LubuntuVM.img",format=raw,if=ide -boot order=c
```

This boots the installed Lubuntu system directly from `LubuntuVM.img`. QEMU's x86 system emulator is launched with `qemu-system-x86_64` and accepts the disk image and boot options on the command line. citeturn0search0turn0search1

### Important

- Do **not** recreate or delete `LubuntuVM.img`.
- Do **not** attach the Lubuntu ISO when performing a normal startup.
- The portable QEMU directory contains the matching executable and DLLs needed by this setup.
- If Windows assigns the removable drive a different letter, update the drive letter in the command accordingly.

## Installer Command

The installer ISO is only needed if a future reinstall is deliberately required. The known-good installer configuration is:

```cmd
qemu-system-x86_64.exe -accel tcg -m 3G -smp 2 -vga std -global isa-fdc.fdtypeA=none -global isa-fdc.fdtypeB=none -drive file="E:\LubuntuVM.img",format=raw,if=ide -cdrom "E:\lubuntu-26.04.1-desktop-amd64.iso" -boot order=d
```

Do not use this command for normal startup.

## Files

- `QEMU\` — portable QEMU executable and required DLLs
- `lubuntu-26.04.1-desktop-amd64.iso` — Lubuntu installer
- `LubuntuVM.img` — persistent virtual hard disk containing the Lubuntu installation

## Long-Term Plan

After the base VM is confirmed working:

- Move the environment to a larger portable SSD.
- Configure Lubuntu for development.
- Add local AI tools and models.
- Build the custom AI environment inside the VM.
