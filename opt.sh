#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: opt.sh
# Description: OpenWrt for make N1 (Before Update feeds)
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

mkdir opt
git clone https://github.com/unifreq/openwrt_packit opt/openwrt_packit
#kpath='https://github.com/ophub/kernel/releases/download/kernel_flippy/'
kpath='https://github.com/breakings/OpenWrt/releases/download/kernel_stable/'
kout='opt/openwrt_packit'
kversion='5.15.158'
krelease='89+o'
wget  --no-check-certificate -c -q $kpath$kversion'.tar.gz' -O $kout'/'$kversion'.tar.gz'
tar -xvf $kout'/'$kversion'.tar.gz' -C $kout
mv $kout'/'$kversion $kout'/kernel'

firmware="mk_rk3328_l1pro.sh"
file1='opt/openwrt_packit/make.env'
file2='opt/openwrt_packit/'$firmware
file3='opt/openwrt_packit/public_funcs'
file4='opt/openwrt_packit/files/openwrt-update-rockchip'
kernel=$(ls opt/*/k*/boot*|cut -d'-' -f2-4|cut -d'.' -f1-3)
kernel='KERNEL_VERSION="'$kernel'"'
sed -i 'N;10i'$kernel $file1
sed -i 'N;10iKERNEL_PKG_HOME="\${PWD\}\/kernel"' $file1
sed -i 'N;10iWHOAMI="VAIO"' $file1
sed -i '/1296mhz.dtb/a\ramdisk_addr_r=0x06000000' $file2
sed -i '/1296mhz.dtb/a\kernel_addr_r=0x02000000' $file2
sed -i '/cd \$TGT_ROOT/a\sqmshcn' $file2
sed -i "s|sqmshcn|sed -i '/exit 0/i\/usr\/share\/sysmonitor\/sysapp.sh firstrun' ./etc/rc.local|" $file2
sed -i s/'adjust_docker_config'/'#adjust_docker_config'/ $file2
sed -i s/'adjust_openssl_config'/'#adjust_openssl_config'/ $file2
sed -i s/'adjust_qbittorrent_config'/'#adjust_qbittorrent_config'/ $file2
sed -i s/'adjust_getty_config'/'#adjust_getty_config'/ $file2
sed -i s/'adjust_samba_config'/'#adjust_samba_config'/ $file2
sed -i s/'adjust_nfs_config "mmcblk2p4"'/'#adjust_nfs_config "mmcblk2p4"'/ $file2
sed -i s/'adjust_openssh_config'/'#adjust_openssh_config'/ $file2
sed -i s/'adjust_openclash_config'/'#adjust_openclash_config'/ $file2
sed -i s/'use_xrayplug_replace_v2rayplug'/'#use_xrayplug_replace_v2rayplug'/ $file2
sed -i s/'adjust_turboacc_config'/'#adjust_turboacc_config'/ $file2
sed -i s/'adjust_ntfs_config'/'#adjust_ntfs_config'/ $file2
sed -i s/'adjust_mosdns_config'/'#adjust_mosdns_config'/ $file2
sed -i s/'patch_admin_status_index_html'/'#patch_admin_status_index_html'/ $file2
sed -i s/'openwrt-armvirt-64-default-rootfs.tar.gz'/'openwrt-armsr-armv8-generic-rootfs.tar.gz'/ $file3
m=$(sed -n '/crontabs/=' $file4)
coremark='sed -i '$m'd '$file4
$coremark
$coremark
$coremark
