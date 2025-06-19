# Use official Node.js Alpine image
FROM node:18-alpine

# Install build tools for native modules
RUN apk add --no-cache python3 make g++ curl

# Set working directory
WORKDIR /app

# Copy package files only
COPY package*.json ./

# Install dependencies (inside container)
RUN npm install

# Copy rest of the app (excluding node_modules via .dockerignore)
COPY . .

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/auth/login || exit 1

# Start the application
CMD ["npm", "start"]
