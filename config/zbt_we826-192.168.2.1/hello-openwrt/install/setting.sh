#!/bin/sh

# 设置时间
#  uci -q batch <<-EOF
# 	set system.@system[0].timezone='CST-8'
# 	set system.@system[0].zonename='Asia/Shanghai'

# 	delete system.ntp.server
# 	add_list system.ntp.server='ntp1.aliyun.com'
# 	add_list system.ntp.server='ntp.tencent.com'
# 	add_list system.ntp.server='ntp.ntsc.ac.cn'
# 	add_list system.ntp.server='time.apple.com'
# EOF
# uci commit system

# 扩容磁盘
# /root/soft/set_disk.sh

# 查看空间
df -h

# 添加SWAP
# cp /root/soft/create_swap.sh /etc/rc.d/SSS99_create_swap.sh && chmod 0755 /etc/rc.d/SSS99_create_swap.sh

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

# 修改默认主题
# sed -i "s|option mediaurlbase '/luci-static/bootstrap'|option mediaurlbase '/luci-static/bootstrap-light'|g" /etc/config/luci

# 定义 控制程序
# mkdir -p /home/control && chmod 0755 /home/control 
# cp -r /root/soft/control-run.sh /etc/init.d/control && chmod 0755 /etc/init.d/control && rm -rf /root/soft/control-run.sh
# cp -r /root/soft/control_* /home/control/control && chmod -R 0755 /home/control/
# /etc/init.d/control enable && /etc/init.d/control start

# 删除无用文件
rm -rf /root/*
rm -rf /etc/uhttpd*
# rm -rf /etc/config/ddns

# 创建 home文件夹
mkdir /home && chmod 0755 /home

# 禁止Docker 开机自启
[ -f /etc/init.d/dockerd ] && ( /etc/init.d/dockerd disable  && /etc/init.d/dockerd stop)

# 重启
reboot

exit 0
