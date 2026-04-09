---
title: ClaudeCode笔记
date: 2026-03-30 21:38:04
tags:
- springBoot
- bug
categories:
- 后端
cover: /images/background/2026.3.30.02.png
coverWidth: 1200
coverHeight: 320
author: 不二
---

Claude Code从入门到精通
<!-- more -->

##### Claude Code 概述

引入自官网   https://claude.com/product/claude-code

>Claude Code 是一个代理编码工具，可以读取你的代码库、编辑文件、运行命令，并与你的开发工具集成。可在终端、IDE、桌面应用和浏览器中使用。

>  Claude Code 是一个由 AI 驱动的编码助手，可帮助你构建功能、修复错误和自动化开发任务。它理解你的整个代码库，可以跨多个文件和工具工作以完成任务。

##### 安装

**脚本**

```shell
curl -fsSL https://claude.ai/install.sh | bash
```

**环境变量**

```sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

<img src="./ClaudeCode%E7%AC%94%E8%AE%B0/image-20260330215819200.png" alt="image-20260330215819200" style="zoom:50%;" />

##### 选择主题

选择喜欢的主题颜色

##### 付费方式

😂还是到了这一步，最便宜的选项一20$,大概会限制在每周100w`token`，注意这个数据是实时的，他可能会根据使用去动态调整。可以尝试，但是没钱哇，烧不起根本，我们知道`claude code`本身其实只是一个代码管理工具我们可以使用国内的一些模型，或者是别的付费模型。

![image-20260330222757374](./ClaudeCode%E7%AC%94%E8%AE%B0/image-20260330222757374.png)

###### cc switch

开源项目：https://github.com/farion1231/cc-switch

简单来说，`cc-switch` 是一个专门为 Claude Code 开发的**开源补丁/切换工具**。它的核心逻辑是：**“挟天子以令诸侯”**。

注意：⚠️如果你选择这种方式的话，那么你的Claude Code付费模式应该选择`Anthropic Console account`,这并不难理解， cc switch帮你接管了请求，它会直接跳过真实的官方验证，或者通过你配置好的中转 key 进行伪装登录。

**下载地址**：https://github.com/farion1231/cc-switch/tags

下载对应版本之后配置你的模型吧

<img src="./ClaudeCode%E7%AC%94%E8%AE%B0/image-20260330225634741.png" alt="image-20260330225634741" style="zoom:50%;" />

##### 剩下的配置部分

可以一直回车，但是最后一步授权claude code工作区的时候，建议选择一个独立的文件夹，不要授权过大的权限。

##### Claude Code 操作说明

| `/`       | Command（命令）       | 执行内置操作                                                 |
| --------- | --------------------- | ------------------------------------------------------------ |
| `@`       | Context（上下文）     | 引用文件/代码/目录                                           |
| `!`       | Bash 模式             | 直接执行终端命令，stdout/stderr 自动注入上下文               |
| `#`       | Memory（记忆注入）    | 把内容持久写入 CLAUDE.md 项目记忆，跨会话长期生效，例如：**#config.yaml** |
| `&`       | Async（异步任务）     | 后台/云端异步执行任务，不阻塞当前会话，可关闭终端后在 claude.ai/code 查看进度 |
| `\`+Enter | Multiline（多行输入） | 换行不发送，写多行内容，长需求描述一次性写完                 |
| 无前缀    | 自然语言              | 普通任务指令                                                 |

###### 常见高频命令：

| 命令       | 作用               |
| :--------- | :----------------- |
| `/help`    | 查看全部能力       |
| `/clear`   | 清空对话           |
| `/plan`    | 进入规划模式       |
| `/model`   | 切换模型           |
| `/context` | 查看上下文使用情况 |
| `/export`  | 导出对话           |
| `/status`  | 环境状态           |
| `/tasks`   | 管理后台任务       |
| `/theme`   | 主题切换           |
| `/memory`  | 编辑 CLAUDE.md     |

##### 第一次尝试

###### **claude**

启动进入claude

**切换模式**

shift +tab  切换模式，一共有三种模式提供选择

+ plan mode on   （规划模式）只讨论，不修改
+ esc to interrupt （默认） 修改文件前一定询问用户
+ accept edits on  （自动）自动创建修改文件，不再需要用户的同意

###### **/Rewind**

回滚

###### **/tasks**

查看后台任务

###### /**context**

当前上下文占用

###### **/compact**

压缩记忆

###### /**resume**

回到之前对话

###### /init

初始化项目，生成 ==CLAUDE.md==

###### /**cost**

预测价格，当次会话

###### claude --continue

在上一次对话结束的地方启动

###### claude --fork-session

启动一个新的窗口，克隆一个子会话，可以配合 `--continue`,组合成`claude --continue --fork-session`**从上一次退出的地方**，开启一个**新的实验分支**

##### /**hooks**

**PreToolUse (工具执行前)**:

- **用途**: 审查。就像保镖，在 Claude 打算拿起“笔”（写入文件）或者“扳手”（运行终端）之前，先过一遍你的安全规则。

**PostToolUse (工具执行后)**:

- **用途**: 收尾。改完代码后自动格式化（Prettier）、运行测试（Vitest）、或者更新 README 文档。

**PostToolUseFailure (执行失败后)**:

- **用途**: 救火。如果刚才的命令运行崩了，可以触发一个自动清理脚本，或者把错误记录到特定的日志文件里。

**PermissionDenied (拒绝授权时)**:

- **用途**: 反思。当你按了 `n` 拒绝它的操作，你可以配置一个 Hook 让它反思为什么被拒绝，从而改进下一次的建议。

**Notification（接收到消息时）**

+ 在 Claude Code 的 Hooks 体系里，`Notification` 就像是它的**“消息推送员”**。虽然它不像 `PreToolUse` 那样能改变逻辑，但在处理耗时较长的任务时，它是救命稻草。

##### 

| `/help`    | 查看全部能力       |
| ---------- | ------------------ |
| `/clear`   | 清空对话           |
| `/plan`    | 进入规划模式       |
| `/model`   | 切换模型           |
| `/context` | 查看上下文使用情况 |
| `/export`  | 导出对话           |
| `/status`  | 环境状态           |
| `/tasks`   | 管理后台任务       |
| `/theme`   | 主题切换           |
| `/memory`  | 编辑 CLAUDE.md     |

##### SubAgent

##### Agent Skill

##### Claude Code 项目目录结构

> https://www.runoob.com/claude-code/claude-code-project.html

```tex
your-project/
├── CLAUDE.md                    ← 团队共享指令，提交到 git
├── CLAUDE.local.md              ← 个人覆盖，被 git 忽略
└── .claude/
    ├── settings.json            ← 权限 + 配置，提交到 git
    ├── settings.local.json      ← 个人权限，被 git 忽略
    ├── commands/                ← 自定义斜杠命令
    │   ├── review.md            →  /project:review
    │   ├── fix-issue.md         →  /project:fix-issue
    │   └── deploy.md            →  /project:deploy
    ├── rules/                   ← 模块化指令文件（全局生效）
    │   ├── code-style.md
    │   ├── testing.md
    │   └── api-conventions.md
    ├── skills/                  ← 自动调用的工作流
    │   ├── security-review/
    │   │   └── SKILL.md
    │   └── deploy/
    │       └── SKILL.md
    └── agents/                  ← 子代理角色定义
        ├── code-reviewer.md
        └── security-auditor.md
```



##### 一些模版示例

###### CLAUDE.md

````makefile
# 项目名称

## 项目概述
简述这个项目的目的和功能。

## 技术栈
- Frontend: React + TypeScript
- Backend: Node.js + Express
- Database: PostgreSQL

## 目录结构
- `src/components/` - React 组件
- `src/api/`        - API 层
- `tests/`          - 测试文件

## 常用命令
- 启动开发服务器：`pnpm dev`
- 运行测试：`pnpm test`
- 代码检查：`pnpm lint`

## 开发规范
- 使用 TypeScript strict 模式
- 优先使用 interface 而非 type
- 禁止使用 any，使用 unknown 替代
```

### 文件位置与层级

项目的核心文件结构如下： 
```
your-project/
├── CLAUDE.md                  # 项目主记忆文件（团队共享）
├── .claude/
│   ├── settings.json          # Hooks、权限、环境配置
│   ├── settings.local.json    # 个人配置（建议加入 .gitignore）
│   └── commands/              # 自定义斜杠命令
│       └── my-command.md
└── .mcp.json                  # MCP 服务配置
```
````



