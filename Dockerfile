# Use the official Node.js 14 image as the base image
FROM node:lts-alpine AS builder

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.yaml files to the container
# COPY package.json pnpm-lock.yaml /app/

# Install pnpm
RUN npm install -g pnpm

# Copy the rest of the app code to the container
COPY . /app

# Install the app dependencies
RUN pnpm i

# Build the React app
RUN pnpm build

# Use the official Nginx image as the base image
FROM nginx:1.18.0-alpine

# copy the dist folder from react to the root of nginx (www)
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy the Nginx configuration file to the container
COPY config/nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 (Nginx default port)
EXPOSE 80

# Start Nginx when the container launches
CMD ["/bin/sh", "-c", "nginx -g 'daemon off;'"]