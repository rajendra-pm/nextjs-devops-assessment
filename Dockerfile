# Use official Node.js LTS version with Debian (not Alpine)
FROM node:18-bullseye AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Build the Next.js app
RUN npm run build

# Production image
FROM node:18-bullseye

WORKDIR /app

# Copy build output
COPY --from=builder /app ./

EXPOSE 3000

CMD ["npm", "start"]
