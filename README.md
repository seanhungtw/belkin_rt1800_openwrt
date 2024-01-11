- (C) 2024 Sean.Hung <https://github.com/seanhungtw/belkin_rt1800_openwrt_23052>
- Extraordinary is you improve yourself do every day

# belkin_rt1800_openwrt
A note for how to build a openwrt image for RT1800 with MTK HNAT (23.05 only)

CPU: MT7621

Wi-Fi chip: MT7915D (DBDC)

Refer:

https://openwrt.org/docs/guide-developer/toolchain/beginners-build-guide

## Get the code
```
git clone https://git.openwrt.org/openwrt/openwrt.git # or https://github.com/openwrt/openwrt.git
cd openwrt
git checkout v23.05.2
git checkout -b rt1800_23052
```
### Overwirte the code in the belkin_rt1800_openwrt/openwrt23
just copy and paste, don't delete existed files in 23.05.2

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

- Can't use DSA switch, rollback to swconfig (because we need to use MTK 7530 driver)
- wifi interface name is hardcoded in the dts, currently only support "phy0-ap0", "phy1-ap0", "phy0-ap1", "phy1-ap1", "phy0-sta0", "phy1-sta0"

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

## Notes of MTK board customization

### default /etc/config/network & eth nterface name (both openwrt 22 & 23)

you can configure interface name, mac here:
```
#file :target/linux/ramips/mt7621/base-files/etc/board.d/02_network

#for example
ucidef_set_interfaces_lan_wan "lan1, lan2, ..." "wan"
lan_mac="00:11:22:33:44:55"
wan_mac="00:11:22:33:44:56"
```
then it goes to the original Openwrt code to generate default /etc/config/network file:
```
package/base-files/files/bin/config_generate
```
### default wireless config flow
default the /etc/config wireless is empty, when system init, it will call 
```
/etc/init.d/network
```
then the netwaork script will call
```
/sbin/wifi
```
the wifi script will include any file in the /lib/wifi

take rt1800 as example:
```
/lib/wifi/mac80211.sh
```
if the driver works, the ifname will be created in the following path:
```
root@OpenWrt:/# ls /sys/class/ieee80211/
phy0  phy1
```
the mac80211.sh will generate the /etc/config/wireless file according to phy0  phy1 data above
