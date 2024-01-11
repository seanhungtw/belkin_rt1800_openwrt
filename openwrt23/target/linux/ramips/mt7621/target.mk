#
# Copyright (C) 2009 OpenWrt.org
#

#
##2024/01/08 Sean.Hung k52349@gmail.com, porting from 
#Original discusstion by MeIsReallyBa
#	https://forum.openwrt.org/t/use-mtk-sdk-hwnat-driver-to-replace-hw-flow-offload/128120
#Source:
#	https://github.com/padavanonly/openwrt/tree/master/target/linux/ramips
#
# 2024/01/08
# added mod-ramips_hnat & swconfig
#

SUBTARGET:=mt7621
BOARDNAME:=MT7621 based boards
FEATURES+=nand ramdisk rtc usb minor
CPU_TYPE:=24kc
KERNELNAME:=vmlinux vmlinuz
# make Kernel/CopyImage use $LINUX_DIR/vmlinuz
IMAGES_DIR:=../../..

DEFAULT_PACKAGES += wpad-basic-mbedtls swconfig uboot-envtools kmod-ramips_hnat

define Target/Description
	Build firmware images for Ralink MT7621 based boards.
endef

