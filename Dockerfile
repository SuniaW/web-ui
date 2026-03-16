# --- 第一阶段：构建阶段 ---
# 将 node:18 修改为 node:20
FROM node:20-alpine AS build-stage

# 设置工作目录
WORKDIR /app

# 复制依赖文件并安装
COPY package*.json ./

# 安装依赖
RUN npm config set registry https://registry.npmmirror.com && \
    npm install

# 拷贝源码并构建
COPY . .
RUN npm run build

# --- 第二阶段：运行阶段 ---
FROM nginx:stable-alpine AS production-stage

# 从第一阶段的成果物中复制 dist 文件夹到 Nginx 目录
COPY --from=build-stage /app/dist /usr/share/nginx/html

# 复制自定义的 Nginx 配置覆盖默认配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 暴露 80 端口
EXPOSE 80

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]