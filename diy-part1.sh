#!/bin/bash
#
# 修改个性化信息
# date=`date +%Y.%m.%d`
# sed -i 's/OpenWrt/OpenWrt Build '$date' By Dream./g' package/lean/default-settings/files/zzz-default-settings
# sed -i 's/%D %V, %C/%D %V, '$date' By Dream./g' package/base-files/files/etc/banner
#
# 修改luci显示cpu型号方式
# sed -i 's/pcdata(boardinfo.model/pcdata(boardinfo.system/g' package/lean/autocore/files/x86/index.htm
#
# 修改内核版本,版本修改为:5.4
sed -i 's/KERNEL_PATCHVER:=\([0-9]\+\.[0-9]\+\)/KERNEL_PATCHVER:=5.4/g' target/linux/x86/Makefile
#
# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
# sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings
#
#
# 有些时候差python环境
# sudo apt-get update && sudo apt-get install python3-venv
#
exit 0
