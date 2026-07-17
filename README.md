# Cap

一款使用 Godot 4 开发的轻量经济策略游戏。项目采用纯 2D 等距地图，核心目标是建立具有存量-流量一致会计、商品供需、服务、银行、央行、保险和证券市场的经济模拟。

## 环境

- Godot 4.7.1 或兼容的 Godot 4.x 版本
- OpenCode（需要继续导入开发会话时）
- Git

## 运行

```powershell
godot --path .
```

打开 Godot 编辑器：

```powershell
godot --path . -e
```

## 在另一台电脑继续开发

克隆仓库后进入项目目录：

```powershell
git clone <repository-url>
cd cap
```

导入本仓库中经过脱敏的 OpenCode 会话：

```powershell
opencode import opencode-session.json
opencode .
```

`opencode-session.json` 由 OpenCode 官方 `export --sanitize` 命令生成。项目源码和设计文档由 Git 保存，会话文件用于恢复讨论上下文。

需要重新导出最新会话时，先通过 `opencode session list` 找到会话 ID，然后在 Windows 上运行：

```powershell
cmd /c "opencode export <session-id> --sanitize > opencode-session.json"
```

## 设计文档

- `plan.md`：项目开发计划
- `economy.md`：持续迭代的核心经济模型设计
