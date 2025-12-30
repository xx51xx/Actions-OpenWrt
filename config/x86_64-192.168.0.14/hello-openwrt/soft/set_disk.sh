#!/bin/sh

function set_disk() {
    # 寻找磁盘路径
    disk_boot=$(echo $(mount | grep "on /boot " | awk '{print $1}' | head -n 1))
    disk_main=$(echo "$disk_boot" | sed 's/[0-9]$/2/')
    disk=$(echo $disk_boot | sed 's/1$//')

    # 判断是否安装了parted,如果安装在卸载，系统会报错.
    if command -v parted &> /dev/null ; then
        opkg install /root/soft/losetup*
        opkg install /root/soft/resize2fs*
    else
        opkg install /root/soft/losetup*
        opkg install /root/soft/resize2fs*
        opkg install /root/soft/libparted*
        opkg install /root/soft/parted*
    fi

    # 开始分区
    echo -e "ok\nfix" | parted -l ---pretend-input-tty
    echo yes | parted $disk ---pretend-input-tty resizepart 2 100%
    losetup /dev/loop0 $disk_main 2> /dev/null
    resize2fs -f /dev/loop0
}

# 调用函数
set_disk

exit 0
