# Obsidian Vault - 滔滔的知识库

## 📋 快速开始

### 1. 打开仓库

1. 打开 Obsidian 应用
2. 选择「打开本地仓库」
3. 选择 `/root/obsidian-vault`

### 2. 启用插件

1. 设置 → 社区插件 → 关闭安全模式
2. 安装推荐插件：
   - Templater
   - Dataview
   - Calendar
   - Tag Wrangler

### 3. 阅读指南

打开 `快速入门指南.md` 了解完整使用方法。

## 📁 目录结构

```
├── 00-Templates/      # 模板
├── 01-编程学习/       # 技术笔记
├── 02-财经投资/       # 投资笔记
├── 03-学习方法/       # 学习方法
├── 04-生活健康/       # 健康生活
├── 05-职业发展/       # 职业发展
├── 90-Attachments/   # 附件
├── 91-Inbox/          # 每日笔记
├── 知识地图.md        # 知识导航
└── About.md          # 关于我
```

## 🔄 同步

### 手动同步

```bash
./auto-sync.sh
```

### 实时监控同步（推荐）

```bash
# 方式1：直接运行监控
./watch-sync.sh

# 方式2：安装为系统服务（后台运行）
sudo cp obsidian-sync.service /etc/systemd/system/
sudo systemctl enable obsidian-sync.service
sudo systemctl start obsidian-sync.service

# 方式3：定时同步（每5分钟）
# 添加 crontab:
# */5 * * * * /root/obsidian-vault/auto-sync.sh
```

### Hugo 同步

```bash
./sync-to-hugo.sh
```

### SSH 密钥配置

已生成专用 SSH 密钥，请将以下公钥添加到 GitHub:

```
cat ~/.ssh/obsidian_sync.pub
```

复制输出内容，添加到 GitHub → Settings → SSH Keys

## 📚 相关资源

- [Obsidian 官网](https://obsidian.md/)
- [Obsidian 中文文档](https://publish.obsidian.md/help-zh/)
- [Dataview 文档](https://blacksmithgu.github.io/obsidian-dataview/)
