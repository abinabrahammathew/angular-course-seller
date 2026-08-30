# Stage 1: Build Angular application
FROM node:14-alpine AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build Angular application
RUN npm run build

# Stage 2: Serve Angular application using Nginx
FROM nginx:alpine

COPY --from=build /app/dist/angular-course-seller /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]