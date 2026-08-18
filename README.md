Samsung A05 (A055F/M), One UI 7, Android 15, 6.6 Kernel Source
- KernelSU-Next Included
- SukiSU-Ultra with SUSFS Included

build requirement?
- know how to operate & use linux CLI
- some knowledge about kernel building
- pc/laptop/device/VM running ubuntu or debian with at least 2 cores & 4GB ram allocated 

how to build?
- clone this repo
- run the workfow or use act for run it locally

Build is gonna take around 1 hour depend on your hardware configuration

After finish it would automatically compressed into a05m-6.6-kernel-*****.zip

you need to flash it from custom recovery (TWRP, etc)

Download the latest manager for [KernelSU Next](https://github.com/KernelSU-Next/KernelSU-Next/actions/workflows/build-manager.yml?query=branch%3Adev+is%3Asuccess), for SukiSU Ultra the manager will be at the assets of the release

thanks [Theman-Fromfar](https://github.com/Theman-Fromfar/a05m-kernel-6.6) for the kernel repo
