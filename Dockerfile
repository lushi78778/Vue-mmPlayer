# 构建应用
FROM node:18 AS builder
WORKDIR /app
COPY . .
RUN pnpm install
# RUN pnpm run prepare
# RUN pnpm run lint
RUN pnpm run build

# 最小化镜像
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
RUN npm install -g http-server

EXPOSE 12445
CMD ["http-server", "dist", "-p", "12445"]