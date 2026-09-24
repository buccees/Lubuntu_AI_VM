@echo off
cd /d "%~dp0QEMU"
qemu-system-x86_64.exe -accel tcg -m 3G -smp 2 -vga std -global isa-fdc.fdtypeA=none -global isa-fdc.fdtypeB=none -drive file="%~dp0LubuntuVM.img",format=raw,if=ide -boot order=c
