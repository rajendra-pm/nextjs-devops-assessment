# Builder stage
FROM node:18-bullseye AS builder  # ✅ Debian-based Node image

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy all source code
COPY . .

# Build Next.js app
RUN npm run build

# Production image
FROM node:18-bullseye  # ✅ Debian-based Node image

WORKDIR /app

# Copy build output
COPY --from=builder /app ./

EXPOSE 3000

CMD ["npm", "start"]
