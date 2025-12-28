##### 使用 GitHub Actions 在线云编译 OpenWrt 固件

#### 操作步骤

1. 解压 
```
gzip -d openwrt-xxxx.img.gz

```

2. 让文件系统只读 

```
echo 1 > /proc/sys/kernel/sysrq
echo u > /proc/sysrq-trigger
```

3. DD

```
dd if=openwrt-xxxx.img of=/dev/vda bs=4M status=progress oflag=sync

# 或者 
dd if=openwrt-xxxx.img of=/dev/vda bs=4M conv=fsync
```

4. 强制重启
```
echo 1 > /proc/sys/kernel/sysrq
echo b > /proc/sysrq-trigger
```