#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git apps https://github.com/hzy306016819/openwrt-apps' >>feeds.conf.default
echo 'src-git OpenAppFilter https://github.com/destan19/OpenAppFilter' >>feeds.conf.default
echo 'src-git lucky https://github.com/gdy666/luci-app-lucky' >>feeds.conf.default
# 添加 aliyundrive-webdav 软件源
echo 'src-git aliyundrivewebdav https://github.com/messense/aliyundrive-webdav.git' >> feeds.conf.default

# 添加 OpenClash 软件源
echo 'src-git OpenClash https://github.com/vernesong/OpenClash.git' >> feeds.conf.default
# --- 修复 Rust Host 编译问题 (OpenClash 依赖触发) ---
# 1. 修改 Rust 的 Makefile，禁用 CI LLVM 下载
RUST_MAKEFILE="feeds/packages/lang/rust/Makefile"
if [ -f "$RUST_MAKEFILE" ]; then
    sed -i 's/--set=llvm\.download-ci-llvm=true/--set=llvm.download-ci-llvm=false/' "$RUST_MAKEFILE"
    # 针对 CI 环境的额外加固：避免 CI 变量导致 Rust 构建脚本报错
    sed -i '/x\.py \\/a \        --ci false \\' "$RUST_MAKEFILE"
fi

# 2. 清理可能残留的 Rust 缓存（云编译环境通常很干净，但加上也无妨）
rm -rf build_dir/target-*/host/rustc-*-src 2>/dev/null || true
