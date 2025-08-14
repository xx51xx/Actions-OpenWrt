#!/bin/bash
# 修改设备树
mv -f '$WORKSPACE_DIR/config/$cfg/mt7620a_phicomm_psg1208.dts' target/linux/ramips/dts
cat target/linux/ramips/dts/mt7620a_phicomm_psg1208.dts
# 修改 内存大小
sed -i 's/IMAGE_SIZE := 7872k/IMAGE_SIZE := 16064k/g' target/linux/ramips/image/mt7620.mk
cat target/linux/ramips/image/mt7620.mk
exit 0
