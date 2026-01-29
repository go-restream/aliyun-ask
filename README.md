# Aliyun Ask Skill

阿里云（Alibaba Cloud）资源查询助手 - Claude Code Skill

## 概述

这是一个专为 Claude Code 设计的阿里云资源查询技能Skill，通过自然语言查询阿里云资源信息，包括 ECS、RDS、VPC、SLB、OSS 等多种服务。

## 核心特性

- **自然语言查询**: 使用中文自然语言描述查询需求，无需记忆复杂的 CLI 命令
- **只读安全保证**: 严格限制为只读查询操作，防止误操作导致资源变更
- **智能规划**: 自动分析查询需求并生成执行计划
- **结果保存**: 支持保存查询结果到本地文件
- **历史对比**: 支持与历史查询结果进行对比分析

## 支持的阿里云服务

- **ECS** (Elastic Compute Service): 云服务器
- **RDS** (Relational Database Service): 关系型数据库
- **VPC** (Virtual Private Cloud): 专有网络
- **SLB** (Server Load Balancer): 负载均衡
- **OSS** (Object Storage Service): 对象存储
- 以及更多阿里云服务...

## 安装

### 本地安装

Claude Code 插件的本地安装：

```bash
git clone https://github.com/go-restream/aliyun-ask.git

make install
```

### help
```bash
✗ make help
aliyun-ask Plugin Installation
==============================

Available targets:
  make install           - Install plugin to ~/.claude/ (default)
  make install INSTALL_DIR=/custom/path - Install to custom directory
  make uninstall         - Remove installed plugin files
  make help              - Show this help message

Current install directory: /Users/xxx/.claude

```

## 使用方法

### 基本查询

```bash
# 查询所有 ECS 实例
/aliyun-ask 我的ECS实例有哪些

# 查询特定区域的 RDS 实例
/aliyun-ask 华北2区的RDS实例列表

# 查询 VPC 信息
/aliyun-ask 查询所有VPC及其网段配置

# 查询 SLB 监听器状态
/aliyun-ask 查看负载均衡器的监听器配置
```

### 保存查询结果

查询完成后，插件会询问是否保存结果。如果选择保存，结果将存储在 `aliyun_memos` 目录下。

### 历史对比

```bash
# 对比当前查询结果与历史记录
/aliyun-ask 对比一下现在的ECS实例和上次查询的结果有什么变化
```

## 工作原理

### 智能规划流程

1. **需求分析**: 使用 NLP 技术分析用户的查询需求
2. **生成执行计划**: 将自然语言转换为结构化的 Aliyun CLI 执行计划
3. **生成任务清单**: 基于执行计划生成具体的 TODO 任务列表
4. **用户确认**: 向用户展示执行计划，等待确认
5. **执行查询**: 调用 Aliyun CLI 执行查询操作
6. **结果整理**: 格式化并展示查询结果

### 安全机制

- **PreToolUse Hook**: 在执行命令前验证是否为只读操作
- **操作白名单**: 仅允许 Describe、Get、List 等查询类命令
- **操作黑名单**: 自动拦截 Create、Delete、Update 等变更类命令
- **确认机制**: 关键操作需要用户确认

## 环境要求

### 前置条件

1. **Aliyun CLI**: 已安装并配置阿里云命令行工具
   ```bash
   # 安装 Aliyun CLI
   pip install aliyun-cli

   # 配置凭证
   aliyun configure
   ```

2. **jq**: JSON 处理工具（用于安全钩子脚本）
   ```bash
   # macOS
   brew install jq

   # Linux
   sudo apt-get install jq
   ```

3. **Bash**: Unix/Linux/macOS 环境

## 常见问题

### Q: 为什么命令被拦截？

A: 插件严格限制为只读操作。如果您的命令包含 Create、Delete、Update 等关键词，会被安全钩子拦截。

### Q: 如何查看完整的 Aliyun CLI 参数？

A: 插件会自动使用 `aliyun help` 获取帮助信息。您也可以手动查看：
```bash
aliyun ecs help
aliyun rds help
```

### Q: 查询结果保存在哪里？

A: 结果保存在项目目录下的 `aliyun_memos/` 目录中，文件名格式为 `aliyun_output_YYYYMMDD_HHMM.md`。

### Q: 支持哪些阿里云区域？

A: 支持所有阿里云公共云区域，包括华北1/2、华东1/2、华南1等。

## 安全说明

本插件采用多层安全机制：

1. **应用层限制**: Agent 提示词明确禁止变更类操作
2. **Hook 层限制**: PreToolUse Hook 在命令执行前进行验证
3. **用户确认**: 执行前展示任务清单，等待用户确认

## 许可证

Apache 2.0 License

## 贡献

欢迎提交 Issue 和 Pull Request！

## 作者

XiaoYang

## 相关链接

- [阿里云 CLI 文档](https://help.aliyun.com/document_detail/110260.html)
- [Claude Code 插件开发文档](https://docs.anthropic.com/claude-code/plugins)
- [GitHub 仓库](https://github.com/go-restream/aliyun-ask)
