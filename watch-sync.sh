#!/bin/bash
# 实时监控文件变化并自动同步

VAULT_DIR="/root/obsidian-vault"
REMOTE_REPO="git@github.com-obsidian:codesky1991/obsidian-vault.git"
BRANCH="main"
LOG_FILE="$VAULT_DIR/.watch.log"
DEBOUNCE_SEC=30  # 防抖：30秒内的变化合并为一次提交

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# 检查依赖
if ! command -v inotifywait &> /dev/null; then
    echo "安装 inotify-tools..."
    apt-get update && apt-get install -y inotify-tools
fi

cd "$VAULT_DIR"

log "🚀 启动文件监控服务..."

# 确保 Git 已初始化
if [ ! -d ".git" ]; then
    log "📦 初始化 Git 仓库..."
    git init
    git remote add origin "$REMOTE_REPO"
    git remote update
    log "✅ Git 仓库初始化完成"
fi

# 监听 .md 文件和目录变化
inotifywait -m -r \
    --exclude '\.(git|Attachments|sync.*\.log|\.log)' \
    -e modify,create,delete,move \
    "$VAULT_DIR" 2>/dev/null | while read -r directory events filename; do

    # 过滤非笔记文件
    if [[ "$filename" =~ \.(md|jpg|png|pdf)$ ]] || [[ "$events" =~ DIRECTORY ]]; then
        log "📁 检测到变化: $events $filename"

        # 防抖：等待一段时间积累变化
        sleep "$DEBOUNCE_SEC"

        # 执行同步
        /root/obsidian-vault/auto-sync.sh

        log "⏰ 等待下一轮监控..."
    fi
done
