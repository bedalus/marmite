    echo -e "Making crespo zImage\n"
    export PATH=$PATH:/opt/toolchain_crespo/bin/
    export ARCH=arm
    export SUBARCH=arm
    export CROSS_COMPILE=arm-cortex_a8-linux-gnueabi-

make herring_defconfig
make -j7

# copy zImage
cp -f arch/arm/boot/zImage ../marmite/kernel/
ls -l ../marmite/kernel/zImage

# copy modules
find ./ -type f -name '*.ko' -exec cp -f {} ../marmite/system/lib/modules/ \;

cd ../marmite
zip -r -9 marmite_vN.zip * > /dev/null
mv marmite_vN.zip ../

echo "Press enter to build cm kernel"
read enterkey
cd ../samsung

git apply cm_ioctrl.patch

make -j7

# copy zImage
cp -f arch/arm/boot/zImage ../marmite/kernel/
ls -l ../marmite/kernel/zImage

# copy modules
find ./ -type f -name '*.ko' -exec cp -f {} ../marmite/system/lib/modules/ \;

cd ../marmite
zip -r -9 marmite_vNcm.zip * > /dev/null
mv marmite_vNcm.zip ../

cd ../samsung
git apply -R cm_ioctrl.patch

