#!/bin/bash

# 修改 BusyBox Shell 启动信息
sed -i '/^define Build\/Compile/i\
define Build/Prepare\n\
\t$(call Build/Prepare/Default)\n\
\t# 修改 BusyBox 的欢迎信息\n\
\t$(SED) '\''s|const char bb_banner\\[\\].*=[^;]*;|const char bb_banner[] ALIGN1 = "Welcome to OpenWRT";|'\'' $(PKG_BUILD_DIR)/libbb/messages.c\n\
endef\n' package/utils/busybox/Makefile

# 修改 openwrt_release 显示信息 package/base-files/files/etc/openwrt_release
sed -i 's|^DISTRIB_DESCRIPTION=.*|DISTRIB_DESCRIPTION="OpenWRT"|' package/base-files/files/etc/openwrt_release


# 修改 footer.ut 尾部信息 feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/footer.ut
file="feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/footer.ut"

awk '
BEGIN { in_block = 0 }

{
    if ($0 ~ /{% if \(!blank_page\): %}/) {
        in_block = 1
        print "{% if (!blank_page): %}"
        print "    </div>"
        print "    <footer>"
        print "        <span>"
        print "            &copy; <span id=\"year\"></span> 两笙山世 私人定制版OpenWRT  |  联系邮箱: live2@qq.com"
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
        print "            p.innerHTML = \"&copy; <span id=\\\"year2\\\"></span> 两笙山世 私人定制版OpenWRT  |  联系邮箱: live2@qq.com\";"
        print "            document.querySelector(\"footer\")?.appendChild(p);"
        print "            document.getElementById(\"year2\").textContent = new Date().getFullYear();"
        print "        }"
        print "        document.getElementById(\"year\").textContent = new Date().getFullYear();"
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
}
' "$file" > "$file.tmp" && mv "$file.tmp" "$file"



# 修改 sysauth.htm 显示版权 feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/sysauth.ut
# sed -i -E "s/(blank_page:)[[:space:]]*true/\1 false/g" feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/sysauth.ut



exit 0
