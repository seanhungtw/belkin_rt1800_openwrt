# belkin_rt1800_openwrt_23052
A note for how to build a openwrt 23.05.2 image for RT1800

#Get the code
git clone https://git.openwrt.org/openwrt/openwrt.git
git checkout v23.05.2
git checkout -b rt1800_23052

#update feeds
./scripts/feeds update -a
./scripts/feeds install -a

#menuconfig
make menuconfig

#build the image
make defconfig
make
