#!/bin/sh

# 赋权，防止无法执行脚本
chmod -R 0755 /root/*

# 扩容磁盘
chmod 0755 /root/soft/set_disk.sh && /root/soft/set_disk.sh

# 添加SWAP
cp /root/soft/create_swap.sh /etc/rc.d/SSS99_create_swap.sh && chmod 0755 /etc/rc.d/SSS99_create_swap.sh

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
sed -i 's/LEDE/OpenWRT/g' /etc/config/system

# 修改默认主题
# sed -i "s|option mediaurlbase '/luci-static/bootstrap'|option mediaurlbase '/luci-static/bootstrap-light'|g" /etc/config/luci


# 删除无用文件
rm -rf /root/*
rm -rf /etc/uhttpd*
# rm -rf /etc/config/ddns

# 创建 home文件夹
mkdir /home && chmod 0755 /home

# 禁止Docker 开机自启
[ -f /etc/init.d/dockerd ] && ( /etc/init.d/dockerd disable  && /etc/init.d/dockerd stop)

# 设置控制程序
mkdir -p /home/control && chmod 0755 /home/control
mv -f /root/config/control.run /home/control/control.run 
mv -f /root/config/control_linux_amd64 /home/control/control

cp -r /home/control/control.run /etc/init.d/control && chmod 0755 /etc/init.d/control
chmod -R 0755 /home/control/

/etc/init.d/control enable


# 重启
reboot

exit 0
