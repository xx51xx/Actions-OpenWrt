#!/bin/bash

file="img/zbt_we826-192.168.2.1_openwrt-ramips-mt7620-phicomm_psg1208-squashfs-sysupgrade.bin"

# 判断文件是否存在
if [ -f "$file" ]; then
    # 使用 sed 替换文件名中的字符串
    newfile=$(echo "$file" | sed 's/phicomm_psg1208/zbt_we826/')
    # 执行重命名
    mv "$file" "$newfile"
fi

exit 0
