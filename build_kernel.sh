#!/bin/bash
# Kernel version suffix: KSUN (KernelSU-Next) or SKSU (SukiSU-Ultra).
# Leave empty for a plain version, e.g. 6.6.129.
KERNEL_NAME="${KERNEL_NAME:-}"
INFO_FILE="kernel/kernel_device_modules-6.6/kernel/configs/mt6768_overlay.config"

if [ -n "$KERNEL_NAME" ]; then
    sed -i '/^CONFIG_LOCALVERSION=/d' "$INFO_FILE"
    printf 'CONFIG_LOCALVERSION="-%s"\n' "$KERNEL_NAME" >> "$INFO_FILE"
fi

cd kernel-6.6

echo ""
	echo -e "Host Arch: `uname -m`"
	echo -e "Host Kernel: `uname -r`"
	echo -e "Host gnumake: `make -v | grep -e "GNU Make"`"
	echo ""
	echo -e "Linux version: `make kernelversion`"
	echo -e "Kernel builder user: `whoami`"
	echo -e "Kernel builder host: `hostname`"
	echo -e "Build date: `date`"
	echo ""

 sleep 5
cd ..

cd kernel
python kernel_device_modules-6.6/scripts/gen_build_config.py --kernel-defconfig mediatek-bazel_defconfig --kernel-defconfig-overlays "mt6768_overlay.config S96818AA1.config S96818AA1_debug.config kernelsu.config" --kernel-build-config-overlays "" -m user -o ../out/target/product/a05m/obj/KERNEL_OBJ/build.config


export DEVICE_MODULES_DIR="kernel_device_modules-6.6"
export BUILD_CONFIG="../out/target/product/a05m/obj/KERNEL_OBJ/build.config"
export OUT_DIR="../out/target/product/a05m/obj/KLEAF_OBJ"
export DIST_DIR="../out/target/product/a05m/obj/KLEAF_OBJ/dist"
export DEFCONFIG_OVERLAYS="mt6768_overlay.config S96818AA1.config S96818AA1_debug.config"
export PROJECT="mgk_64_k66"
export MODE="user"
export SANDBOX="0"

./kernel_device_modules-6.6/build.sh

cd ..

ANYKERNEL_DIR="$(pwd)/AnyKernel3"
ANYKERNEL_FILE="$(pwd)/AnyKernel3/anykernel.sh"
KERNEL_IMAGE="$(pwd)/out/target/product/a05m/obj/KLEAF_OBJ/dist/kernel_device_modules-6.6/mgk_64_k66_kernel_aarch64.user/Image"
ZIPNAME="a05m-6.6-kernel"
INFO_FILE="$(pwd)/kernel/kernel_device_modules-6.6/kernel/configs/mt6768_overlay.config"
KERNEL_VERSION_NAME=$(grep "CONFIG_LOCALVERSION=" "$INFO_FILE" | sed -n 's/.*CONFIG_LOCALVERSION="\([^"]*\)".*/\1/p')
KERNEL_LABEL="${KERNEL_NAME:-${KERNEL_VERSION_NAME#-}}"
[ -n "$KERNEL_LABEL" ] || KERNEL_LABEL="kernel"

if [ "$KERNEL_LABEL" = "kernel" ]; then
    KERNEL_STRING="a05m-kernel"
else
    KERNEL_STRING="a05m-${KERNEL_LABEL}-kernel"
fi
sed -i "s/kernel.string=.*/kernel.string=\"${KERNEL_STRING}\"/" "$ANYKERNEL_FILE"

set -e

if [ ! -f "$KERNEL_IMAGE" ]; then
    echo "Error: Kernel image '$KERNEL_IMAGE' not found!"
    exit 1
fi

if [ ! -d "$ANYKERNEL_DIR" ]; then
    echo "Error: Directory '$ANYKERNEL_DIR' not found!"
    exit 1
fi

echo "Kernel image and AnyKernel3 directory found"

mv "$KERNEL_IMAGE" "$ANYKERNEL_DIR/"
TIMESTAMP=$(date +"(%Y.%m.%d.%H.%M.%S)")
if [ "$KERNEL_LABEL" = "kernel" ]; then
    FINAL_ZIP_NAME="${ZIPNAME}-${TIMESTAMP}.zip"
else
    FINAL_ZIP_NAME="${ZIPNAME}-${KERNEL_LABEL}-${TIMESTAMP}.zip"
fi
echo "Creating zip file: $FINAL_ZIP_NAME"

if command -v zip >/dev/null 2>&1; then
    (cd "$ANYKERNEL_DIR" && zip -r9 "../$FINAL_ZIP_NAME" ./*)
else
    python3 -c "
import os, zipfile
with zipfile.ZipFile('$FINAL_ZIP_NAME', 'w', zipfile.ZIP_DEFLATED) as zf:
    for root, dirs, files in os.walk('$ANYKERNEL_DIR'):
        for f in files:
            full = os.path.join(root, f)
            rel = os.path.relpath(full, '$ANYKERNEL_DIR')
            zf.write(full, rel)
"
fi

echo " "
echo "✅ Done! Flashable zip created successfully"
echo "File: $FINAL_ZIP_NAME"
