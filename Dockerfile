# Multi-stage Dockerfile for react frontend

# Builder stage
FROM node:18-alpine AS builder
WORKDIR /app

# Copy manifest and lock files
COPY package*.json ./
COPY yarn.lock ./
RUN yarn install

# Copy all sources
COPY . .
RUN yarn build

FROM nginx:alpine AS production

# Copy static assets for serving
COPY --from=builder /app/build /usr/share/nginx/html

# Optional: Copy custom nginx config if needed
# COPY nginx.conf /etc/nginx/nginx.conf
# for react and vite only
EXPOSE 80 
CMD ["nginx", "-g", "daemon off;"]
