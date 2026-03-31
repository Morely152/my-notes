# mysx_back 部署文档

本文档详细说明如何在本地测试和将项目部署到 Ubuntu 服务器上。

## 目录

- [环境要求](#环境要求)
- [本地开发模式](#本地开发模式)
- [Docker 本地测试](#docker-本地测试)
- [Ubuntu 服务器部署](#ubuntu-服务器部署)
- [维护与监控](#维护与监控)
- [故障排查](#故障排查)

---

## 环境要求

### 本地开发
- Python 3.13+
- MySQL 8.0+ 或 MariaDB
- Git

### Docker 部署
- Docker 24.0+
- Docker Compose 2.20+

### 服务器部署
- Ubuntu 22.04 LTS 或更高版本
- Docker 24.0+
- Docker Compose 2.20+
- 至少 2GB RAM
- 至少 20GB 磁盘空间

---

## 本地开发模式

### 1. 克隆项目

```bash
git clone <your-repo-url> mysx_back
cd mysx_back
```

### 2. 创建 Python 虚拟环境

```bash
# Windows
python -m venv venv
venv\Scripts\activate

# Linux/Mac
python3 -m venv venv
source venv/bin/activate
```

### 3. 安装依赖

```bash
pip install -r requirements.txt
```

### 4. 配置环境变量

```bash
# 复制配置模板
cp .env.example .env

# 编辑 .env 文件，配置数据库等信息
# Windows: notepad .env
# Linux: nano .env
```

**关键配置项（开发模式）：**
```env
DEBUG=True
IS_DEPLOY=False
SECRET_KEY=your-secret-key-here

# 数据库配置
DB_NAME=mysx
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_HOST=localhost
DB_PORT=3306

# 如果需要通过 SSH 隧道连接远程数据库
SSH_TUNNEL_HOST=your.server.com
SSH_USERNAME=your_ssh_user
SSH_PASSWORD=your_ssh_password
```

### 5. 数据库迁移

```bash
python manage.py migrate
```

### 6. 创建超级用户

```bash
python manage.py createsuperuser
```

### 7. 启动开发服务器

```bash
python manage.py runserver
```

访问：http://localhost:8000

---

## Docker 本地测试

### 方式一：使用 Docker Compose（推荐）

#### ~~1. 配置环境变量（跳过）

```bash
cp .env.example .env
nano .env
```

**生产模式配置：**
```env
DEBUG=False
IS_DEPLOY=True
SECRET_KEY=<生成随机密钥>

# 数据库配置（将使用 docker-compose 中的 MySQL 服务）
DB_NAME=mysx
DB_USER=django_user
DB_PASSWORD=your_secure_password
DB_HOST=db
DB_PORT=3306
DB_ROOT_PASSWORD=your_root_password
```

#### 2. 启动服务

启动Docker Desktop

```bash
# 构建并启动所有服务
docker compose up -d

# 查看日志
docker compose logs -f

# 只查看后端服务日志
docker compose logs -f server
```

#### 3. 初始化数据库

```bash
# 进入容器
docker compose exec server bash

# 运行迁移
python manage.py migrate

# 创建超级用户
python manage.py createsuperuser

# 退出容器
exit
```

#### 4. 验证服务

```bash
# 健康检查
curl http://localhost:8000/api/health/

# 访问管理后台
# http://localhost:8000/admin/
```

#### 5. 停止服务

```bash
docker compose down

# 停止并删除数据卷（谨慎使用！）
docker compose down -v
```

### 方式二：单独使用 Docker

```bash
# 构建镜像
docker build -t mysx_backend .

# 运行容器（需要外部 MySQL 数据库）
docker run -d \
  --name mysx_backend \
  -p 8000:8000 \
  --env-file .env \
  -v chroma_data:/app/data/chroma \
  -v logs_data:/app/logs \
  mysx_backend
```

---

## Ubuntu 服务器部署

### 1. 服务器准备

#### 1.1 更新系统

```bash
sudo apt update && sudo apt upgrade -y
```

#### 1.2 安装 Docker

```bash
# 安装必要的包
sudo apt install -y ca-certificates curl gnupg lsb-release

# 添加 Docker 官方 GPG 密钥
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 添加 Docker 仓库
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 安装 Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 验证安装
docker --version
docker compose version
```

#### 1.3 配置防火墙

```bash
# 允许 SSH
sudo ufw allow 22/tcp

# 允许 HTTP/HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# 如果需要直接访问后端（生产环境建议使用反向代理）
sudo ufw allow 8000/tcp

# 启用防火墙
sudo ufw enable
```

### 2. 部署应用

#### 2.1 创建部署目录

```bash
sudo mkdir -p /opt/mysx
sudo chown $USER:$USER /opt/mysx
cd /opt/mysx
```

#### 2.2 上传代码

**方式 A：使用 Git**
```bash
git clone <your-repo-url> .
git checkout <production-branch>
```

**方式 B：使用 SCP（从本地上传）**
```bash
# 在本地执行
scp -r mysx_back user@your-server:/opt/mysx/
```

**方式 C：使用 SFTP**
```bash
sftp user@your-server
cd /opt/mysx
put -r mysx_back/*
exit
```

#### 2.3 生成生产环境密钥

```bash
# 生成 Django SECRET_KEY
python3 -c "import secrets; print(secrets.token_urlsafe(50))"

# 生成数据库密码
openssl rand -base64 32
```

#### 2.4 配置生产环境变量

```bash
cp .env.example .env
nano .env
```

**生产环境配置示例：**
```env
# ==================== 基础配置 ====================
SECRET_KEY=<生成的随机密钥>
DEBUG=False
IS_DEPLOY=True
ALLOWED_HOSTS=your-domain.com,www.your-domain.com,localhost
SITE_URL=https://your-domain.com

# ==================== 数据库配置 ====================
DB_NAME=mysx
DB_USER=django_user
DB_PASSWORD=<生成的数据库密码>
DB_HOST=db
DB_PORT=3306
DB_ROOT_PASSWORD=<生成的root密码>

# ==================== CORS 配置 ====================
CORS_ALLOWED_ORIGINS=https://your-domain.com,https://www.your-domain.com

# ==================== DeepSeek AI（可选）====================
DEEPSEEK_API_KEY=your_api_key

# ==================== Cloudflare R2（可选）====================
CLOUDFLARE_R2_ACCESS_KEY=your_access_key
CLOUDFLARE_R2_SECRET_KEY=your_secret_key
CLOUDFLARE_R2_BUCKET_NAME=your_bucket
CLOUDFLARE_R2_ENDPOINT_URL=https://your_account.r2.cloudflarestorage.com
CLOUDFLARE_R2_CUSTOM_DOMAIN=https://your_custom_domain.com

# ==================== 邮件配置（可选）====================
EMAIL_HOST=smtp.your-provider.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=your_email@domain.com
EMAIL_HOST_PASSWORD=your_email_password
DEFAULT_FROM_EMAIL=your_email@domain.com
```

#### 2.5 创建超级用户（可选）

在 `.env` 中添加：
```env
DJANGO_SUPERUSER_USERNAME=admin
DJANGO_SUPERUSER_EMAIL=admin@your-domain.com
DJANGO_SUPERUSER_PASSWORD=<your-admin-password>
```

#### 2.6 启动服务

```bash
# 构建并启动
docker compose up -d

# 查看状态
docker compose ps

# 查看日志
docker compose logs -f
```

#### 2.7 初始化数据库

```bash
# 运行数据库迁移
docker compose exec server python manage.py migrate

# 如果没有在 .env 中配置超级用户，手动创建
docker compose exec server python manage.py createsuperuser

# 收集静态文件
docker compose exec server python manage.py collectstatic --noinput
```

### 3. 配置 Nginx 反向代理（可选但推荐）

#### 3.1 安装 Nginx

```bash
sudo apt install -y nginx
```

#### 3.2 创建 Nginx 配置

```bash
sudo nano /etc/nginx/sites-available/mysx
```

**Nginx 配置内容：**
```nginx
# HTTP 重定向到 HTTPS
server {
    listen 80;
    server_name your-domain.com www.your-domain.com;

    # Let's Encrypt 验证路径
    location /.well-known/acme-challenge/ {
        root /var/www/html;
    }

    # 其他请求重定向到 HTTPS
    location / {
        return 301 https://$server_name$request_uri;
    }
}

# HTTPS 配置
server {
    listen 443 ssl http2;
    server_name your-domain.com www.your-domain.com;

    # SSL 证书配置（使用 Let's Encrypt）
    ssl_certificate /etc/letsencrypt/live/your-domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/your-domain.com/privkey.pem;

    # SSL 安全配置
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;
    ssl_session_cache shared:SSL:10m;
    ssl_session_timeout 10m;

    # 日志
    access_log /var/log/nginx/mysx_access.log;
    error_log /var/log/nginx/mysx_error.log;

    # 客户端上传大小限制
    client_max_body_size 20M;

    # 代理到 Django 后端
    location /api/ {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_redirect off;

        # 超时设置
        proxy_connect_timeout 120s;
        proxy_send_timeout 120s;
        proxy_read_timeout 120s;
    }

    # 管理后台
    location /admin/ {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # 静态文件（可选，直接由 Django 提供）
    location /static/ {
        proxy_pass http://127.0.0.1:8000;
    }

    # 媒体文件
    location /media/ {
        proxy_pass http://127.0.0.1:8000;
    }

    # Sitemap
    location /sitemap.xml {
        proxy_pass http://127.0.0.1:8000;
    }
}
```

#### 3.3 启用配置

```bash
# 创建符号链接
sudo ln -s /etc/nginx/sites-available/mysx /etc/nginx/sites-enabled/

# 测试配置
sudo nginx -t

# 重载 Nginx
sudo systemctl reload nginx
```

#### 3.4 配置 SSL 证书（Let's Encrypt）

```bash
# 安装 Certbot
sudo apt install -y certbot python3-certbot-nginx

# 获取并配置证书
sudo certbot --nginx -d your-domain.com -d www.your-domain.com

# 自动续期（已自动配置）
sudo certbot renew --dry-run
```

### 4. 配置服务自动启动

#### 4.1 确保 Docker 开机自启

```bash
sudo systemctl enable docker
```

#### 4.2 配置容器自动重启

已在 `docker-compose.yaml` 中配置 `restart: unless-stopped`

#### 4.3 验证自动启动

```bash
sudo reboot
# 重启后检查
docker compose ps
```

### 5. 更新部署

#### 5.1 更新代码

```bash
cd /opt/mysx
git pull origin main
```

#### 5.2 重新构建和部署

```bash
# 重新构建镜像
docker compose build

# 重启服务
docker compose up -d

# 运行数据库迁移
docker compose exec server python manage.py migrate

# 收集静态文件
docker compose exec server python manage.py collectstatic --noinput
```

#### 5.3 零停机更新（可选）

```bash
# 使用滚动更新
docker compose up -d --no-deps --build server

# 等待新容器健康后再重启旧容器
docker compose up -d
```

---

## 维护与监控

### 1. 日志查看

```bash
# 查看所有服务日志
docker compose logs -f

# 查看特定服务日志
docker compose logs -f server
docker compose logs -f db

# 查看最近 100 行日志
docker compose logs --tail=100 server

# 查看应用日志文件
docker compose exec server tail -f /app/logs/django.log
docker compose exec server tail -f /app/logs/error.log
```

### 2. 数据备份

#### 2.1 数据库备份

```bash
# 创建备份目录
mkdir -p /opt/mysx/backups

# 备份数据库
docker compose exec db mysqldump -u root -p"${DB_ROOT_PASSWORD}" mysx > /opt/mysx/backups/db_backup_$(date +%Y%m%d_%H%M%S).sql

# 或使用 Docker 卷备份
docker run --rm \
  --volumes-from mysx_mysql \
  -v /opt/mysx/backups:/backup \
  ubuntu tar czf /backup/mysql_data_$(date +%Y%m%d_%H%M%S).tar.gz /var/lib/mysql
```

#### 2.2 Chroma 数据备份

```bash
docker run --rm \
  --volumes-from mysx_chroma_data \
  -v /opt/mysx/backups:/backup \
  ubuntu tar czf /backup/chroma_data_$(date +%Y%m%d_%H%M%S).tar.gz /app/data/chroma
```

#### 2.3 自动备份脚本

创建 `/opt/mysx/backup.sh`：
```bash
#!/bin/bash
BACKUP_DIR="/opt/mysx/backups"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# 备份数据库
docker compose exec -T db mysqldump -u root -p"${DB_ROOT_PASSWORD}" mysx > $BACKUP_DIR/db_$DATE.sql

# 备份 Chroma 数据
docker run --rm \
  --volumes-from mysx_chroma_data \
  -v $BACKUP_DIR:/backup \
  ubuntu tar czf /backup/chroma_$DATE.tar.gz /data

# 保留最近 7 天的备份
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete
```

设置定时任务：
```bash
chmod +x /opt/mysx/backup.sh
crontab -e

# 每天凌晨 2 点备份
0 2 * * * /opt/mysx/backup.sh >> /opt/mysx/backups/backup.log 2>&1
```

### 3. 数据恢复

```bash
# 恢复数据库
cat /opt/mysx/backups/db_backup_20240301_020000.sql | docker compose exec -T db mysql -u root -p"${DB_ROOT_PASSWORD}" mysx

# 恢复 Chroma 数据
docker run --rm \
  --volumes-from mysx_chroma_data \
  -v /opt/mysx/backups:/backup \
  ubuntu tar xzf /backup/chroma_backup.tar.gz -C /
```

### 4. 监控命令

```bash
# 容器状态
docker compose ps

# 资源使用情况
docker stats

# 磁盘使用
df -h
docker system df

# 数据库连接数
docker compose exec db mysql -u root -p"${DB_ROOT_PASSWORD}" -e "SHOW PROCESSLIST;"
```

---

## 故障排查

### 1. 容器无法启动

```bash
# 查看容器日志
docker compose logs server

# 检查配置文件
docker compose config

# 重建容器
docker compose down
docker compose up -d --force-recreate
```

### 2. 数据库连接失败

```bash
# 检查数据库容器状态
docker compose ps db

# 进入数据库容器
docker compose exec db bash

# 测试连接
mysql -u django_user -p mysx

# 检查网络
docker network inspect mysx_network
```

### 3. Chroma 数据丢失

```bash
# 检查数据卷
docker volume inspect mysx_chroma_data

# 查看数据目录
docker compose exec server ls -la /app/data/chroma

# 恢复备份
# （参考数据恢复部分）
```

### 4. 健康检查失败

```bash
# 手动测试健康端点
curl http://localhost:8000/api/health/

# 详细健康检查
curl http://localhost:8000/api/health/detailed/

# 检查容器健康状态
docker inspect --format='{{.State.Health.Status}}' mysx_backend
```

### 5. 性能问题

```bash
# 查看容器资源使用
docker stats mysx_backend

# 增加 Gunicorn workers
# 编辑 docker-compose.yaml 或 Dockerfile 中的 CMD

# 数据库优化
docker compose exec db mysql -u root -p -e "SHOW VARIABLES LIKE 'max_connections';"
```

### 6. 日志文件过大

```bash
# 清理 Docker 日志
docker compose logs --tail=0 -f > /dev/null &
docker compose down
docker compose up -d

# 配置日志轮转
# 编辑 /etc/docker/daemon.json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}

sudo systemctl restart docker
```

---

## 常用命令速查

```bash
# 启动服务
docker compose up -d

# 停止服务
docker compose down

# 重启服务
docker compose restart

# 查看日志
docker compose logs -f

# 进入容器
docker compose exec server bash

# 数据库迁移
docker compose exec server python manage.py migrate

# 创建超级用户
docker compose exec server python manage.py createsuperuser

# 收集静态文件
docker compose exec server python manage.py collectstatic

# 查看容器资源使用
docker stats

# 清理未使用的资源
docker system prune -a

# 备份数据库
docker compose exec db mysqldump -u root -p"${DB_ROOT_PASSWORD}" mysx > backup.sql
```

---

## 安全建议

1. **定期更新系统**：`sudo apt update && sudo apt upgrade -y`
2. **使用强密码**：所有密码使用随机生成的强密码
3. **配置防火墙**：只开放必要的端口
4. **启用 SSL**：使用 Let's Encrypt 免费 SSL 证书
5. **定期备份**：设置自动备份任务
6. **监控日志**：定期检查应用和系统日志
7. **限制 SSH 访问**：禁用密码登录，只使用密钥
8. **保持 Docker 更新**：定期更新 Docker 和容器镜像

---

## 联系支持

如有问题，请查看：
- Django 文档：https://docs.djangoproject.com/
- Docker 文档：https://docs.docker.com/
- 项目 Issues：<your-repo-issues-url>
