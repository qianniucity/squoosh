# 使用官方的 Node.js 镜像作为基础镜像
FROM node:20.11.1

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json 到工作目录
COPY package*.json ./

# 设置 npm 镜像为淘宝镜像，并增加超时时间
RUN npm config set registry https://registry.npmmirror.com/ && \
  npm config set fetch-retries 5 && \
  npm config set fetch-retry-mintimeout 20000 && \
  npm config set fetch-retry-maxtimeout 120000

# 安装项目依赖
RUN npm install

# 复制项目文件到工作目录
COPY . .

# 暴露应用运行的端口（假设应用运行在端口3000）
EXPOSE 3000

# 构建项目
RUN npm run build

# 设置环境变量
ENV DEV_PORT=3000

# 设置容器启动时运行的命令
CMD ["npm", "run", "serve"]
