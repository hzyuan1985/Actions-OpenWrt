#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
sed -i 's/192.168.6.1/192.168.100.10/g' package/base-files/files/bin/config_generate

# 确保 netconfig-boot 脚本存在并赋予可执行权限
if [ -f "package/base-files/files/usr/bin/netconfig-boot" ]; then
    echo "为 netconfig-boot 脚本添加执行权限..."
    chmod +x package/base-files/files/usr/bin/netconfig-boot
    # 检查权限是否设置成功
    ls -la package/base-files/files/usr/bin/netconfig-boot
else
    echo "警告: 未找到 package/base-files/files/usr/bin/netconfig-boot 文件，请检查路径是否正确。"
fi

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate
