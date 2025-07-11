# OpenMemory

OpenMemory 是一个为 LLM 提供记忆能力的开源本地化解决方案，支持个性化记忆存储、查询和管理。

## 🚀 快速开始

### ✅ 前提条件

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- Windows（WSL）或 Unix/Linux
- 设置好 API 密钥

---

### 🔧 初始化环境变量

如果你没有 [.env](file://D:\AIGC\code\openmemory\api\alembic\env.py#L0-L0) 文件，请先执行：

```bash 
make env
```
然后编辑以下文件，设置你的 API Key 和用户 ID：

- `api/.env`
- `ui/.env`

---

### ▶️ 启动服务

使用以下命令一键启动所有服务：

```bash
make up
```

这将启动以下组件：
- **MCP Server**: `http://localhost:8765`
- **Qdrant Vector Store**: `http://localhost:6333`
- **前端 UI**（可选）: `http://localhost:3000`

> ✅ 你可以在 `http://localhost:8765/docs` 查看 API 文档。

---

### ⏹️ 停止并清理服务

使用以下命令关闭所有容器并清理资源：

```bash
make down
```

> 💡 此操作会删除所有容器和网络，默认不删除持久化数据（如数据库文件），但你可以根据需求在 Makefile 中扩展行为。

---

## 📝 其他常用命令（可选）

| 命令           | 描述                        |
|----------------|-----------------------------|
| `make build`   | 构建 Docker 镜像             |
| `make logs`    | 查看服务日志                 |
| `make shell`   | 进入后端容器进行调试         |
| `make migrate` | 手动运行数据库迁移脚本       |

---

## 🧠 小贴士

- **(当前已适配 Windows，Linux执行需自行修改)** 如果你是 **Windows 用户**，请确保 [Makefile](file://D:\AIGC\code\openmemory\Makefile) 中的删除命令已适配 Windows，例如使用 `del /Q api\openmemory.db` 而不是 `rm -f`。
- 如果你在开发模式下需要重新加载代码，可以使用 `make down && make up` 重启服务。

---

## ❤️ 欢迎贡献

我们欢迎任何形式的贡献：文档优化、功能改进、测试反馈等。只需 Fork 并提交 PR！

- Fork 项目
- 创建新分支：`git checkout -b feature/your-feature-name`
- 提交更改：`git commit -m '描述你的改动'`
- 推送到远程：`git push origin feature/your-feature-name`
- 提交 Pull Request