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
# sed -i 's/KERNEL_PATCHVER:=\([0-9]\+\.[0-9]\+\)/KERNEL_PATCHVER:=5.4/g' target/linux/x86/Makefile
#
# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
# sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings
# 修改 BusyBox Shell 启动信息
find . -type f -name 'messages.c' | while read -r file; do
  sed -i 's|const char bb_banner\[\] ALIGN1 = "BusyBox v" BB_VER BB_EXTRA_VERSION;|const char bb_banner[] ALIGN1 = "Welcome to OpenWRT";|' "$file"
done




# 修改 footer.ut 文件
find . -type f -name 'footer.ut' | while read -r file; do
    # 使用 awk 替换原始 footer 片段为 JS 动态年份版本
    awk '
    BEGIN { in_block = 0 }
    {
        if ($0 ~ /{% if \(!blank_page\): %}/) {
            in_block = 1
            print "{% if (!blank_page): %}"
            print "</div>"
            print "<footer>"
            print "    <span>"
            print "        &copy; ${new Date().getFullYear()} 两笙山世 私人定制版  |  联系邮箱: live2@qq.com"
            print "    </span>"
            print "</footer>"
            print "<script>L.require('\''menu-bootstrap'\'')</script>"
            print "{% endif %}"
            next
        }

        if (in_block && $0 ~ /<\/html>/) {
            in_block = 0
            print "</body>"
            print "</html>"
            next
        }

        if (!in_block)
            print $0
    }' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
done

exit 0
