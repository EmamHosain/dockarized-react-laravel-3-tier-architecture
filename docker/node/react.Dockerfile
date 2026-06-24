# Stage 1: Build the React app
FROM node:25.9.0

# Set working directory
WORKDIR /var/www/html/react

# Copy package files first (for caching)
COPY ./frontend/package*.json ./

# Install dependencies
RUN npm install

# Copy all source code
COPY ./frontend .

# Build the app
# RUN npm run build

# Expose port
EXPOSE 3000

# Start nginx
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]