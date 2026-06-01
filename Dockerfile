# Build
FROM node:24 AS builder
WORKDIR /app

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN npm install -g pnpm \
  && pnpm install --frozen-lockfile

COPY . .
RUN pnpm build

# Serve
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

