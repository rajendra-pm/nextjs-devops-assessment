# Use official Node.js LTS version
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Build the Next.js app
RUN npm run build

# Use lightweight Node.js image for production
FROM node:18-alpine

WORKDIR /app

# Copy build output from builder
COPY --from=builder /app ./

# Expose the app port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
