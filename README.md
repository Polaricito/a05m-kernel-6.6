Samsung A05 (A055F/M), One UI 7, Android 15, 6.6 Kernel Source
- KernelSU-Next Included

I recommend forking and building a new version with Actions in case of an update

build requirement?
- know how to operate & use linux CLI
- some knowledge about kernel building
- pc/laptop/device/VM running ubuntu or debian with at least 2 cores & 4GB ram allocated 

how to build?
- clone this repo
- download the toolchain from samsung open source [here (Samsung Web Page)](https://opensource.samsung.com/uploadSearch?searchValue=toolchain) or [here (Google Drive)](https://drive.google.com/file/d/1vsQfRgdNHlD0md9tF7j5fpkL_17whzbH/view?usp=sharing)
- extract toolchain.tar.gz on the root of the kernel source
- bash build_kernel.sh

First build is gonna take around 1-5 hours depend on your hardware configuration

After finish it would automatically compressed into a05m-6.6-kernel-*****.zip

you need to flash it from custom recovery (TWRP, etc)
