---
created: 2023-11-19
title: Hugo学习笔记
tags:
  - Hugo
  - 建站
  - 静态网站
aliases: [Hugo教程]
source: Hugo博客迁移
related:
  - Git服务器搭建
  - 提升学习效率
---

# Hugo Learn

## 什么是 Hugo

Hugo 是一个用 Go 编写的静态网站生成器，速度极快。

## 安装 Hugo

### Linux/macOS

```bash
# 使用包管理器安装
brew install hugo  # macOS
sudo apt install hugo  # Ubuntu
sudo yum install hugo  # CentOS
```

### Windows

```powershell
# 使用 Chocolatey
choco install hugo -confirm
```

### 验证安装

```bash
hugo version
```

## 创建新网站

```bash
# 创建新网站
hugo new site mysite
cd mysite
```

## 添加主题

```bash
# 初始化 git
git init

# 添加主题作为子模块
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke

# 配置 config.toml
echo 'theme = "ananke"' >> config.toml
```

## 创建内容

```bash
# 创建新帖子
hugo new posts/my-first-post.md

# 创建新博客
hugo new blog/my-blog.md
```

## 启动开发服务器

```bash
# 启动服务器（包含草稿）
hugo server -D

# 指定端口
hugo server -D --port 1313

# 绑定所有 IP
hugo server -D --bind 0.0.0.0
```

## 构建生产版本

```bash
# 构建静态文件
hugo --minify

# 指定配置文件
hugo --config config.yml --minify

# 指定 base URL
hugo --baseURL "https://example.com" --minify
```

## 目录结构

```
mysite/
├── config.toml         # 配置文件
├── content/            # 内容目录
│   ├── posts/         # 帖子
│   └── blog/          # 博客
├── layouts/           # 模板目录
├── static/            # 静态资源
├── themes/            # 主题目录
└── public/            # 生成的静态文件
```

## Frontmatter 格式

```yaml
---
title: "我的第一篇文章"
date: 2024-01-01
draft: false
tags: ["Hugo", "建站"]
categories: ["教程"]
---
```

## 相关笔记

- [[Git服务器搭建]]
- [[提升学习效率]]
