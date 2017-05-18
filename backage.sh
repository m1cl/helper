#!/bin/bash

for pkg in $(pacman -Q | cut -d' ' -f1); do
    if [$pkg != "amdgpu-pro-libdrm 17.10.401251-2" -a $pkg != "lib32-amdgpu-pro-opencl 17.10.401251-2"]; then 
        pacman -S $pkg
    fi
done
