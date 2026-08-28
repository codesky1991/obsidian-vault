#!/bin/bash
# 自动同步脚本 - 监控文件变化并自动提交推送

set -e

VAULT_DIR="/root/obsidian-vault"
REMOTE_REPO="git@github.com-obsidian:codesky1991/obsidian-vault.git"
BRANCH="main"

# 日志文件
LOG_FILE="$VAULT_DIR/.sync.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

cd "$VAULT_DIR"

# 检查是否是 Git 仓库
if [ ! -d ".git" ]; then
    log "📦 初始化 Git 仓库..."
    git init
    git remote add origin "$REMOTE_REPO"
    log "✅ Git 仓库初始化完成"
fi

# 获取远程仓库URL（如果需要更新）
CURRENT_REMOTE=$(git remote get-url origin 2>/dev/null || echo "")
if [ "$CURRENT_REMOTE" != "$REMOTE_REPO" ]; then
    git remote set-url origin "$REMOTE_REPO" 2>/dev/null || git remote add origin "$REMOTE_REPO"
fi

# 获取未跟踪文件
untracked=$(git ls-files --others --exclude-standard)

# 获取已修改文件
modified=$(git ls-files --modified)

# 如果没有变化则退出
if [ -z "$untracked" ] && [ -z "$modified" ]; then
    log "✅ 没有文件变化，跳过同步"
    exit 0
fi

log "📝 检测到文件变化，开始同步..."
log "📄 未跟踪文件: ${untracked:-无}"
log "📝 已修改文件: ${modified:-无}"

# 添加所有变化
git add -A

# 获取变更统计
changes=$(git diff --cached --stat --short)

if [ -z "$changes" ]; then
    log "✅ 没有实际变更，跳过提交"
    exit 0
fi

log "📊 变更统计:"
log "$changes"

# 提交
COMMIT_MSG="Sync: $(date '+%Y-%m-%d %H:%M:%S')"
log "📝 提交: $COMMIT_MSG"
git commit -m "$COMMIT_MSG"

# 推送
log "⬆️ 推送到远程..."
if git push -u origin "$BRANCH" 2>&1 | tee -a "$LOG_FILE"; then
    log "✅ 同步成功!"
else
    log "⚠️ 推送失败，可能是网络问题或需要手动处理冲突"
    exit 1
fi
