FROM node:18-alpine

WORKDIR /app

# Install dependencies (with layer caching)
COPY package*.json ./
RUN npm ci

# Copy application files
COPY . .

# Set environment variables
ENV NODE_ENV=development
ENV PORT=3000
ENV NEXT_TELEMETRY_DISABLED=1

# Expose port
EXPOSE 3000

# Build the application for production mode
# Uncomment the line below for production mode
# RUN npm run build
# CMD ["npm", "start"]

# Run dev server (for development mode)
CMD ["npm", "run", "dev", "--", "-H", "0.0.0.0"] 