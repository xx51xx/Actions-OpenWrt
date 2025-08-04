#!/bin/sh

# 定义 开启自启信息
mv -f /root/config/rc.local /etc/rc.local && chmod 0644 /etc/rc.local

# 设置空密码
mv -f /root/config/shadow /etc/shadow && chmod 0644 /etc/shadow

# 设置Shell终端显示
mv -f /root/config/banner /etc/banner && chmod 0644 /etc/banner

# 覆盖配置信息
cp -rf /root/config/* /etc/config

# 赋权
chmod -R 0644 /etc/config

# 设置系统名
uci set system.@system[0].hostname='OpenWRT'
sed -i "s/^DISTRIB_DESCRIPTION='LEDE'/DISTRIB_DESCRIPTION='OpenWRT '/" /etc/openwrt_release

# 修改默认主题
# sed -i "s|option mediaurlbase '/luci-static/bootstrap'|option mediaurlbase '/luci-static/bootstrap-light'|g" /etc/config/luci

# 删除无用文件
rm -rf /root/*
rm -rf /etc/uhttpd*
# rm -rf /etc/config/ddns

# 创建 home文件夹
mkdir /home && chmod 0755 /home

# 重启
reboot

exit 0
