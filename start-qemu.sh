qemu-system-arm \
  -M vexpress-a9 \
  -smp 1 \
  -m 256 \
  -kernel images/zImage \
  -dtb images/vexpress-v2p-ca9.dtb \
  -drive file=images/rootfs.ext2,if=sd,format=raw \
  -append "console=ttyAMA0,115200 rootwait root=/dev/mmcblk0" \
  -serial mon:stdio \
  -display none \
  -net nic,model=lan9118 \
  -net user # qemu_arm_vexpress_defconfig
