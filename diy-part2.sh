#!/bin/bash

# 修改 BusyBox Shell 启动信息
sed -i '/^define Build\/Compile/i\
define Build/Prepare\n\
\t$(call Build/Prepare/Default)\n\
\t# 修改 BusyBox 的欢迎信息\n\
\t$(SED) '\''s|const char bb_banner\\[\\].*=[^;]*;|const char bb_banner[] ALIGN1 = "Welcome to OpenWRT";|'\'' $(PKG_BUILD_DIR)/libbb/messages.c\n\
endef\n' package/utils/busybox/Makefile

# 修改 openwrt_release 显示信息 package/base-files/files/etc/openwrt_release
sed -i "s|^DISTRIB_DESCRIPTION='%D %V %C'|DISTRIB_DESCRIPTION='OpenWRT'|" package/base-files/files/etc/openwrt_release

# 修改 footer.ut 尾部信息 feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/footer.ut
sed -i '/<footer>/,/<\/footer>/ s|\(<span>.*\)</span>|\1<br>&copy; <span id="year"></span> 两笙山世 私人定制版OpenWRT  \|  联系邮箱: live2@qq.com</span>|' feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/footer.ut
sed -i 's|<script>L\.require('\''menu-bootstrap'\'')</script>|<script>\
L.require('\''menu-bootstrap'\'');\
document.getElementById("year").textContent = new Date().getFullYear();\
</script>|' feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/footer.ut


# 修改 sysauth.htm 显示版权 feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/sysauth.ut
sed -i -E "s/(blank_page:)[[:space:]]*true/\1 false/g" feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/sysauth.ut



exit 0
