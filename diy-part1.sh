#!/bin/bash
#
# 修改内核版本,版本修改为:5.4
sed -i 's/KERNEL_PATCHVER:=\([0-9]\+\.[0-9]\+\)/KERNEL_PATCHVER:=5.4/g' target/linux/x86/Makefile
exit 0
