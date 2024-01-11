- (C) 2024 Sean.Hung <https://github.com/seanhungtw/belkin_rt1800_openwrt_23052>

# belkin_rt1800_openwrt
A note for how to build a openwrt image for RT1800

CPU: MT7621

Wi-Fi chip: MT7615D (DBDC)

Refer:

https://openwrt.org/docs/guide-developer/toolchain/beginners-build-guide

## Get the code
```
git clone https://git.openwrt.org/openwrt/openwrt.git # or https://github.com/openwrt/openwrt.git
cd openwrt
git checkout v23.05.2
git checkout -b rt1800_23052
```
### update feeds
```
./scripts/feeds update -a
./scripts/feeds install -a
```
### menuconfig
```
make menuconfig
#Select MediaTek Ralink MIPS => MT7621 based boards => Belkin RT1800

make defconfig
```
### build the image
```
make -j$thread
```
### Known issues

- MTK hardware nat may not working on Linux kernel  5.15.137
- The WAN to LAN speed can reach about 890~900 Mbps, but it will cost a lot of CPU power
- Some sone have try to porting mtk hnat to 5.10 (but 23.05 is using DSA, so it might have problems)
- https://forum.openwrt.org/t/use-mtk-sdk-hwnat-driver-to-replace-hw-flow-offload/128120

## Troble shooting

### git issue

you may want to set some git config to avoid git error

```
git config -l
git config --global http.postBuffer 1048576000
git config --global https.postBuffer 1048576000
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999
```

### compile openwrt in WLS2

you need to disable windows PATH: or it will meet build errors
```
~/openwrt$ cat /etc/wsl.conf

[interop]

enabled = false

appendWindowsPath = false
```
