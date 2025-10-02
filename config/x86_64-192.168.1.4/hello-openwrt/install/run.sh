#!/bin/sh

# 一般情况下不要动！
if [ -f /root/setting.sh ]; then
    # 如果文件小于 512KB，并且开头有 UTF-8 BOM，就去掉 BOM
    # 定义 BOM 的标志
    BOM=$(printf '\xEF\xBB\xBF')

    # 先处理 /root
    find /root -type f | while read file
    do
        # 获取文件大小（字节）
        size=$(stat -c %s "$file" 2>/dev/null || echo 0)

        # 如果文件大于等于 512KB，就跳过
        if [ "$size" -ge 524288 ]; then
            continue
        fi

        # 检查文件开头是否有 BOM
        head3=$(head -c 3 "$file")
        if echo "$head3" | grep -q "$BOM"; then
            # echo "去掉 BOM: $file"
            # 用 sed 删除开头的 BOM
            sed -i "1s/^$BOM//" "$file"
        fi
    done

    (sleep 300 && chmod 0755 /root/setting.sh && /root/setting.sh) &

else

    rm -rf /etc/rc.d/SSS99init_run.sh
    
fi
exit 0