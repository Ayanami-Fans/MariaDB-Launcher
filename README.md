# MariaDB Launcher

一个基于 Windows `.bat` 批处理脚本的 **MariaDB 服务管理工具**。

通过简单的数字菜单，可以快速完成 MariaDB 服务的启动、停止、重启以及状态查看。

本工具适用于 **Windows 10 / Windows 11**，无需安装额外软件。

---

## ✨ 功能

目前支持以下功能：

| 选项    | 功能            | 说明                    |
| ----- | ------------- | --------------------- |
| `[1]` | 启动 MariaDB    | 启动 MariaDB Windows 服务 |
| `[2]` | 关闭 MariaDB    | 停止 MariaDB Windows 服务 |
| `[3]` | 重启 MariaDB    | 先停止 MariaDB，再重新启动     |
| `[4]` | 查看 MariaDB 状态 | 查看 MariaDB 当前运行状态     |
| `[5]` | EXIT          | 退出 MariaDB Launcher   |

---

## 🖥️ 运行效果

运行 `MariaDB Launcher` 后，会显示以下菜单：

```text
========================================
         MariaDB 服务管理工具
========================================

[1] 启动 MariaDB
[2] 关闭 MariaDB
[3] 重启 MariaDB
[4] 查看 MariaDB 状态
[5] EXIT

========================================

请输入选项：
```

输入对应数字即可执行操作。

---

## 📦 使用方法

### 1. 下载项目

将项目下载到 Windows 本地。

也可以使用 Git 克隆：

```bash
git clone https://github.com/你的用户名/你的仓库名.git
```

---

### 2. 确认 MariaDB 服务名称

本工具默认管理的 Windows 服务名称为：

```text
MariaDB
```

可以打开 CMD，执行：

```cmd
sc query MariaDB
```

如果能够查询到服务，说明服务名称正确。

例如：

```text
SERVICE_NAME: MariaDB
        TYPE               : 10  WIN32_OWN_PROCESS
        STATE              : 4  RUNNING
```

如果你的 MariaDB 服务名称不是 `MariaDB`，需要修改脚本中的服务名称。

---

## 🚀 启动 MariaDB Launcher

直接双击：

```text
MariaDB_Manager.bat
```

如果当前没有管理员权限，程序会自动请求 **Windows 管理员权限**。

出现 Windows 用户账户控制提示后，点击：

```text
是
```

即可。

---

## 🔐 管理员权限

MariaDB Windows 服务的启动和停止通常需要管理员权限。

MariaDB Launcher 内置管理员权限检测。

如果当前不是管理员身份，会自动通过 PowerShell 请求管理员权限：

```bat
powershell.exe -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
```

因此不需要每次手动：

```text
右键 → 以管理员身份运行
```

直接双击 BAT 即可。

---

## 🛠️ 功能说明

### 1. 启动 MariaDB

选择：

```text
[1] 启动 MariaDB
```

程序执行：

```cmd
net start MariaDB
```

启动 MariaDB Windows 服务。

---

### 2. 关闭 MariaDB

选择：

```text
[2] 关闭 MariaDB
```

程序执行：

```cmd
net stop MariaDB
```

停止 MariaDB Windows 服务。

---

### 3. 重启 MariaDB

选择：

```text
[3] 重启 MariaDB
```

程序会依次执行：

```cmd
net stop MariaDB
net start MariaDB
```

执行流程：

```text
停止 MariaDB
      ↓
启动 MariaDB
      ↓
重启完成
```

适用于修改 MariaDB 配置文件后重新加载配置。

---

### 4. 查看 MariaDB 状态

选择：

```text
[4] 查看 MariaDB 状态
```

程序执行：

```cmd
sc query MariaDB
```

如果 MariaDB 正在运行，通常可以看到：

```text
STATE              : 4  RUNNING
```

如果 MariaDB 已停止：

```text
STATE              : 1  STOPPED
```

---

### 5. 退出

选择：

```text
[5] EXIT
```

退出 MariaDB Launcher。

---

## 📁 项目结构

推荐项目结构：

```text
MariaDB-Launcher/
│
├── MariaDB_Manager.bat
├── README.md
└── LICENSE
```

其中：

```text
MariaDB_Manager.bat
```

是 MariaDB Launcher 的核心程序。

---

## ⚙️ 环境要求

| 项目         | 要求                      |
| ---------- | ----------------------- |
| 操作系统       | Windows 10 / Windows 11 |
| MariaDB    | 已安装为 Windows 服务         |
| CMD        | Windows 自带              |
| PowerShell | Windows 自带              |
| 管理员权限      | 需要                      |
| 第三方依赖      | 无                       |

---

## ⚠️ 注意事项

### 服务名称

MariaDB Launcher 默认使用：

```text
MariaDB
```

作为 Windows 服务名称。

如果你的 MariaDB 服务名称不同，需要修改 BAT 文件中的：

```bat
net start MariaDB
net stop MariaDB
sc query MariaDB
```

---

### MariaDB Launcher 不负责连接数据库

本工具负责管理：

```text
MariaDB Windows 服务
```

而不是直接连接数据库。

因此执行：

```text
[1] 启动 MariaDB
```

后，只是启动 MariaDB 服务，并不会自动进入 MariaDB 命令行。

如果需要连接数据库，可以使用：

```cmd
mysql -u root -p
```

或者使用其他数据库管理工具。

---

## 🔧 自定义服务名称

例如你的 MariaDB Windows 服务名称为：

```text
MariaDB106
```

那么将：

```bat
net start MariaDB
net stop MariaDB
sc query MariaDB
```

修改为：

```bat
net start MariaDB106
net stop MariaDB106
sc query MariaDB106
```

即可。

---

## 📝 编码说明

BAT 文件使用：

```bat
chcp 65001 >nul
```

将 CMD 编码切换为 UTF-8，以便正常显示中文菜单。

窗口标题使用：

```bat
title MariaDB Launcher
```

使用英文标题可以减少 Windows CMD 对中文窗口标题的编码兼容问题。

---

## 📄 License

本项目仅用于学习和个人开发环境中的 MariaDB 服务管理。

你可以根据自己的需要自由修改和使用。

如果需要正式开源发布，可以根据项目实际需求选择合适的开源许可证，例如：

* MIT License
* Apache License 2.0
* GPL-3.0

---

## ⭐ 支持项目

如果 MariaDB Launcher 对你有帮助，欢迎 Star ⭐、Fork 本项目。

如果发现问题或有新的功能建议，也欢迎提交 Issue。
