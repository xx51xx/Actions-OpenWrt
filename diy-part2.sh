#!/bin/bash
# 修改 BusyBox Shell 启动信息
find . -type f -name 'messages.c' | while read -r file; do
  sed -i 's|const char bb_banner\[\] ALIGN1 = "BusyBox v" BB_VER BB_EXTRA_VERSION;|const char bb_banner[] ALIGN1 = "Welcome to OpenWRT";|' "$file"
done

# 修改 openwrt_release 显示信息
find . -type f -name 'openwrt_release' | while read -r file; do
    # 使用 sed 替换 DISTRIB_DESCRIPTION 的值
    sed -i 's|^DISTRIB_DESCRIPTION=.*|DISTRIB_DESCRIPTION=`OpenWRT `|' "$file"
done

# 修改 footer.ut 尾部信息
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
