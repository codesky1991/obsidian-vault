#!/bin/bash
# Hugo to Obsidian Migration Script
# 将 Hugo 博客内容迁移到 Obsidian 知识库

set -e

SOURCE_DIR="/root/blog/quickstart/content"
VAULT_DIR="/root/obsidian-vault"

echo "🚀 开始从 Hugo 迁移到 Obsidian..."

# 映射 Hugo 目录到 Obsidian 目录
declare -A DIR_MAP=(
    ["finance"]="02-财经投资"
    ["program"]="01-编程学习"
    ["posts"]="03-学习方法"
    ["blog"]="03-学习方法"
    ["general"]="04-生活健康"
)

# 迁移函数
migrate_file() {
    local src=$1
    local dest=$2
    local category=$3

    if [ ! -f "$src" ]; then
        echo "⚠️  跳过不存在的文件: $src"
        return
    fi

    echo "📄 迁移: $src -> $dest"

    # 读取原文件内容
    content=$(cat "$src")

    # 提取 frontmatter 和正文
    if [[ "$content" =~ ^--- ]]; then
        # 有 frontmatter
        body=$(echo "$content" | sed -n '/^---$/,/^---$/d;p')
        frontmatter=$(echo "$content" | sed -n '/^---$/,/^---$/p')
    else
        body="$content"
        frontmatter=""
    fi

    # 转换 frontmatter
    new_frontmatter="---
created: $(basename "$src" .md | cut -c1-10)
title: '$(basename "$src" .md)'
tags:
  - $category
aliases: []
source: Hugo博客
---

"

    # 处理正文中的链接和路径
    body=$(echo "$body" | sed 's|https://xueqiu.com/||g')
    body=$(echo "$body" | sed 's|https://www.youtube.com/watch?v=|YouTube:|g')
    body=$(echo "$body" | sed 's|http://1.13.2.150:1313/blog/blog/||g')
    body=$(echo "$body" | sed 's|http://localhost:1313/||g')

    # 创建 Obsidian 格式文件
    mkdir -p "$(dirname "$dest")"
    echo "$new_frontmatter" > "$dest"
    echo "# $(basename "$src" .md)" >> "$dest"
    echo "" >> "$dest"
    echo "$body" >> "$dest"
}

# 迁移各个分类
for hugo_dir in "${!DIR_MAP[@]}"; do
    obsidian_dir="${DIR_MAP[$hugo_dir]}"
    echo ""
    echo "📂 处理目录: $hugo_dir -> $obsidian_dir"

    if [ -d "$SOURCE_DIR/$hugo_dir" ]; then
        mkdir -p "$VAULT_DIR/$obsidian_dir"

        for file in "$SOURCE_DIR/$hugo_dir"/*.md; do
            if [ -f "$file" ] && [ "$(basename "$file")" != "_index.md" ]; then
                filename=$(basename "$file")
                # 转换文件名
                new_filename=$(echo "$filename" | sed 's/how_to_choouse_stock/如何选择股票/g' | sed 's/year_invert_2024/2024投资总结与预测/g' | sed 's/financialPlan/理财计划/g' | sed 's/stock/股票什么时候没有风险/g' | sed 's/my_wechat/捐助地址/g' | sed 's/backend/后台开发/g' | sed 's/interview/面试经验/g' | sed 's/hogo-learn/使用Hugo/g' | sed 's/use_hugo/Hugo进阶/g' | sed 's/efficiency_learn/提升学习效率/g' | sed 's/learn_hugo/Hugo学习/g' | sed 's/git/Git服务器搭建/g' | sed 's/stringLeetCode/LeetCode字符串/g' | sed 's/child_learn/小升初规划/g' | sed 's/code_game/信息学竞赛/g' | sed 's/man_learn/锻炼与压力管理/g' | sed 's/blog/博客介绍/g')

                migrate_file "$file" "$VAULT_DIR/$obsidian_dir/$new_filename" "$hugo_dir"
            fi
        done
    fi
done

echo ""
echo "✅ 迁移完成！"
echo ""
echo "下一步操作："
echo "1. 打开 Obsidian"
echo "2. 选择 '打开本地仓库' -> 选择 /root/obsidian-vault"
echo "3. 安装推荐插件"
echo "4. 开始使用双向链接 [[笔记名称]]"
