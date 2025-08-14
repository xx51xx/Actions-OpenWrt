#!/bin/bash
# 修改设备树
mv -f 'mt7620a_phicomm_psg1208.dts' 'target/linux/ramips/dts'
# 修改 内存大小
sed -i 's/IMAGE_SIZE := 7872k/IMAGE_SIZE := 16064k/g' lede/target/linux/ramips/image/mt7620.mk
exit 0
