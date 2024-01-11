ccflags-y=-Werror
#2014/1/8 Sean.Hung added for igonre case fallthrough compile error
ccflags-y+=-Wno-implicit-fallthrough

obj-$(CONFIG_NET_MEDIATEK_HNAT)         += mtkhnat.o
mtkhnat-objs := hnat.o hnat_nf_hook.o hnat_debugfs.o hnat_mcast.o
