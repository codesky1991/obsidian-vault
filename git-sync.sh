#!/bin/bash
# Git 同步脚本 - 适用于远程服务器

set -e

VAULT_DIR="/root/obsidian-vault"
REMOTE_REPO="git@github.com:yourusername/obsidian-vault.git"
BRANCH="main"

echo "🚀 开始 Git 同步..."

cd "$VAULT_DIR"

# 初始化 Git（如果是首次）
if [ ! -d ".git" ]; then
    echo "📦 初始化 Git 仓库..."
    git init
    git remote add origin "$REMOTE_REPO"
fi

# 添加所有文件
git add .

# 提交
echo "📝 提交更改..."
git commit -m "Sync: $(date '+%Y-%m-%d %H:%M:%S')"

# 推送
echo "⬆️ 推送到远程..."
git push -u origin "$BRANCH"

echo "✅ 同步完成！"
