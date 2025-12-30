#!/bin/sh
# 谨慎使用！
# 判断文件是否为 UTF-8
is_utf8() {
    iconv -f utf-8 -t utf-8 "$1" >/dev/null 2>&1
}

# 去除 UTF-8 BOM
remove_bom() {
    sed -i '1s/^\xEF\xBB\xBF//' "$1"
}

# 清理不可见控制字符（保留 TAB、LF、CR）
clean_control_chars() {
    sed -i 's/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]//g' "$1"
}

# 只处理 .sh 文件
find . -type f -name "*.sh" | while read -r file; do
    size=$(stat -c %s "$file" 2>/dev/null || echo 0)

    # 跳过大文件
    [ "$size" -ge 524288 ] && continue

    # 跳过二进制文件
    if file "$file" | grep -qi "binary"; then
        continue
    fi

    # 清理 BOM
    remove_bom "$file"

    # 清理控制字符
    clean_control_chars "$file"

    # 判断编码
    if is_utf8 "$file"; then
        from_charset="utf-8"
    else
        from_charset="gbk"
    fi

    tmpfile="${file}.tmp_utf8"

    # 转换为 UTF-8（无 BOM）
    if iconv -f "$from_charset" -t utf-8 -c "$file" > "$tmpfile" 2>/dev/null; then
        mv -f "$tmpfile" "$file"
    else
        rm -f "$tmpfile"
        continue
    fi

    # 统一换行符为 LF
    dos2unix "$file" >/dev/null 2>&1
done

exit 0
