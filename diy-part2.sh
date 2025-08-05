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

file="feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/footer.ut"
cat > "$file" <<'EOF'
{% if (!blank_page): %}
</div>
<footer>
  <span>
    Powered by
    <a href="https://github.com/openwrt/luci" target="_blank" rel="noreferrer">
      {{ version.luciname }} ({{ version.luciversion }})
    </a>
    /
    <a href="{{ entityencode(version.disturl ?? '#', true) }}" target="_blank" rel="noreferrer">
      {{ version.distname }} {{ version.distversion }} ({{ version.distrevision }})
    </a>
    {% if (lua_active): %}
      / {{ _('Lua compatibility mode active') }}
    {% endif %}
    <br>
    &copy; <span id="year"></span> 两笙山世 私人定制版 OpenWRT | 联系邮箱: live2@qq.com
  </span>
  <ul class="breadcrumb pull-right" id="modemenu" style="display:none"></ul>
</footer>
<script>
  L.require('menu-bootstrap');
  document.getElementById("year").textContent = new Date().getFullYear();
</script>
{% endif %}
EOF



# 修改 sysauth.htm 显示版权 feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/sysauth.ut
sed -i -E "s/(blank_page:)[[:space:]]*true/\1 false/g" feeds/luci/themes/luci-theme-bootstrap/ucode/template/themes/bootstrap/sysauth.ut



exit 0
