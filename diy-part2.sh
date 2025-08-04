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

    awk '
    BEGIN { in_block = 0 }

    {
        if ($0 ~ /{% if \(!blank_page\): %}/) {
            in_block = 1
            print "{% if (!blank_page): %}"
            print "    </div>"
            print "    <footer>"
            print "        <span>"
            print "            &copy; ${new Date().getFullYear()} 两笙山世 私人定制版OpenWRT  |  联系邮箱: live2@qq.com"
            print "        </span>"
            print "    </footer>"
            print "    <script>"
            print "    L.require(\"menu-bootstrap\");"
            print ""
            print "    (function () {"
            print "        var loginBtn = document.querySelector(\"button.btn.cbi-button-positive.important\");"
            print "        if (loginBtn) {"
            print "            const p = document.createElement(\"p\");"
            print "            p.style.cssText = \"text-align:center;padding:10px;color:#888;font-size:14px;\";"
            print "            p.textContent = \"本站仅用于个人学习与作品集展示，不提供对外服务，感谢您的访问。\";"
            print "            document.querySelector(\"footer\")?.appendChild(p);"
            print "        }"
            print "    })();"
            print "    </script>"
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

# 修改 sysauth.htm 显示版权
find . -type f -name 'sysauth.htm' | while read -r file; do
    # 使用 sed 替换 blank_page: true -> false
    sed -i "s/{% include('footer', { *blank_page: *true *}) %}/{% include('footer', { blank_page: false }) %}/g" "$file"
done

exit 0
