Samsung A05 (A055F/M), One UI 7, Android 15, 6.6 Kernel Source
- KernelSU-Next Included
- SukiSU-Ultra Included

build requirement?
- know how to operate & use linux CLI
- some knowledge about kernel building
- pc/laptop/device/VM running ubuntu or debian with at least 2 cores & 4GB ram allocated 

how to build?
- clone this repo
- download the toolchain from samsung open source here https://opensource.samsung.com/uploadSearch?searchValue=toolchain or here https://drive.google.com/file/d/1vsQfRgdNHlD0md9tF7j5fpkL_17whzbH/view?usp=sharing
- extract toolchain.tar.gz on the root of the kernel source
- bash build_kernel.sh

First build is gonna take around 1-5 hours depend on your hardware configuration

After finish it would automatically compressed into a05m-6.6-kernel-*****.zip

you need to flash it from custom recovery (TWRP, etc)

Download the latest manager for [SukiSU](https://github.com/SukiSU-Ultra/SukiSU-Ultra/actions/workflows/build-manager.yml?query=branch%3Amain+is%3Asuccess) or [KernelSU Next](https://github.com/KernelSU-Next/KernelSU-Next/actions/workflows/build-manager.yml?query=branch%3Adev+is%3Asuccess)

thanks [Theman-Fromfar](https://github.com/Theman-Fromfar/a05m-kernel-6.6) for the kernel repo
