---
created: 2024-08-06
title: Git服务器搭建教程
tags:
  - Git
  - DevOps
  - 教程
aliases: [搭建Git服务器, git-server]
source: Hugo博客迁移
related:
  - Hugo学习
---

# Git 服务器搭建教程

## 环境准备

1. 购买云服务器（推荐阿里云/腾讯云）
2. 安装 Ubuntu/CentOS 系统
3. 安装 Git

```bash
# Ubuntu
sudo apt update
sudo apt install git

# CentOS
sudo yum install git
```

## 创建 Git 用户

```bash
# 创建 git 用户
sudo adduser git

# 设置密码
sudo passwd git
```

## 创建裸仓库

```bash
# 切换到 git 用户
sudo su - git

# 创建仓库目录
mkdir -p ~/repositories/myproject.git

# 初始化裸仓库
cd ~/repositories/myproject.git
git init --bare
```

## 配置 SSH 免密登录

```bash
# 在本地生成 SSH 密钥
ssh-keygen -t rsa -C "your_email@example.com"

# 将公钥复制到服务器
ssh-copy-id git@your-server-ip
```

## 客户端克隆

```bash
# 克隆仓库
git clone git@your-server-ip:~/repositories/myproject.git

# 添加远程仓库（如果已有本地仓库）
git remote add origin git@your-server-ip:~/repositories/myproject.git
git push -u origin master
```

## 安全配置

### 禁用 Git 用户 shell 登录

```bash
# 编辑 /etc/passwd
sudo vim /etc/passwd

# 将 git 用户的行从：
git:x:1001:1001:,,,:/home/git:/bin/bash

# 改为：
git:x:1001:1001:,,,:/home/git:/usr/bin/git-shell
```

### 配置防火墙

```bash
sudo ufw allow 22
sudo ufw allow 80
sudo ufw enable
```

## 常用 Git 命令

```bash
git clone          # 克隆仓库
git pull           # 拉取更新
git push           # 推送代码
git status         # 查看状态
git log            # 查看提交历史
git branch         # 查看分支
git checkout       # 切换分支
git merge          # 合并分支
```

## 相关笔记

- [[Hugo学习]]
- [[后台开发]]
