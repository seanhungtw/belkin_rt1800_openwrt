# belkin_rt1800_openwrt_23052
A note for how to build a openwrt 23.05.2 image for RT1800

CPU: MT7621

Wi-Fi chip: MT7615D (DBDC)

Refer:

https://openwrt.org/docs/guide-developer/toolchain/beginners-build-guide

#=====Get the code=====

git clone https://git.openwrt.org/openwrt/openwrt.git

cd openwrt

git checkout v23.05.2

git checkout -b rt1800_23052

#====update feeds=====

./scripts/feeds update -a

./scripts/feeds install -a

#====menuconfig=====

make menuconfig

#Select MediaTek Ralink MIPS => MT7621 based boards => Belkin RT1800

make defconfig

#====build the image=====

make

#====know issues====

#MTK hardware nat may not working on Linux kernel  5.15.137
