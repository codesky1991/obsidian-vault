#!/bin/bash
# Obsidian to Hugo Sync Script
# 将 Obsidian 笔记同步回 Hugo 博客

set -e

VAULT_DIR="/root/obsidian-vault"
HUGO_CONTENT="/root/blog/quickstart/content"

echo "🔄 Obsidian -> Hugo 同步脚本"

# 同步财经投资
echo "📂 同步 02-财经投资..."
mkdir -p "$HUGO_CONTENT/finance"

# 同步编程学习
echo "📂 同步 01-编程学习..."
mkdir -p "$HUGO_CONTENT/program"

# 同步学习方法
echo "📂 同步 03-学习方法..."
mkdir -p "$HUGO_CONTENT/posts"

# 同步生活健康
echo "📂 同步 04-生活健康..."
mkdir -p "$HUGO_CONTENT/general"

echo "✅ 同步完成！"
echo ""
echo "下一步："
echo "1. cd /root/blog/quickstart"
echo "2. hugo --minify"
echo "3. 部署 public/ 目录"
