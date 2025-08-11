# ---------- STAGE 1: Build ----------
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Install system dependencies (for native modules)
RUN apk add --no-cache libc6-compat

# Copy package files first (to leverage Docker cache)
COPY package*.json ./

# Install all dependencies (including dev)
RUN npm ci

# Copy the rest of your app source code
COPY . .

# Build the Next.js app for production
RUN npm run build

# ---------- STAGE 2: Production ----------
FROM node:20-alpine AS runner

ENV NODE_ENV=production

# Set working directory
WORKDIR /app

# Copy package files for production dependencies install
COPY package*.json ./

# Install only production dependencies
RUN npm ci --omit=dev

# Copy build artifacts and public folder from builder stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json

# Expose the default Next.js port
EXPOSE 3000

# Start the Next.js production server
CMD ["npm", "start"]
