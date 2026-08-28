#!/bin/bash
# 初始化 Obsidian Vault Git 仓库并推送到 GitHub

set -e

VAULT_DIR="/root/obsidian-vault"
REPO_NAME="obsidian-vault"
GITHUB_USER="codesky1991"
REMOTE_URL="git@github.com:${GITHUB_USER}/${REPO_NAME}.git"

echo "🚀 初始化 Obsidian Vault Git 仓库..."

cd "$VAULT_DIR"

# 初始化 Git 仓库
if [ ! -d ".git" ]; then
    echo "📦 初始化 Git 仓库..."
    git init
    git remote add origin "$REMOTE_URL"
else
    echo "✅ Git 仓库已存在"
fi

# 创建 .gitignore
cat > .gitignore << 'EOF'
# Obsidian
.trash/
.vault-backups/

# OS
.DS_Store
Thumbs.db

# Logs
*.log
.sync.log
.watch.log
sync-service.log
.cron.log

# Temp
*.tmp
*.bak
EOF

# 添加 .gitignore
git add .gitignore 2>/dev/null || true

# 添加所有文件（排除 .gitignore 再次添加）
git add .

# 初始提交
echo "📝 创建初始提交..."
git commit -m "✨ Initial commit: Obsidian knowledge vault

- 模板系统 (Daily, Note, Book)
- 财经投资笔记
- 编程学习笔记
- 学习方法笔记
- 生活健康笔记
- 自动同步配置"

# 设置默认分支为 main
git branch -M main

echo ""
echo "⚠️  重要：请确保 SSH 公钥已添加到 GitHub"
echo ""
echo "你的 SSH 公钥："
cat ~/.ssh/obsidian_sync.pub
echo ""
echo "复制上述公钥，添加到："
echo "https://github.com/settings/keys"
echo ""
echo "添加后，运行以下命令推送："
echo "  cd $VAULT_DIR"
echo "  git push -u origin main"
