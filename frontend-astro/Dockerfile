FROM node:20-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build args for compile-time env vars
ARG DIRECTUS_URL=http://directus:8055
ARG PUBLIC_DIRECTUS_URL=http://localhost:8055

# Set env vars for build
ENV DIRECTUS_URL=$DIRECTUS_URL
ENV PUBLIC_DIRECTUS_URL=$PUBLIC_DIRECTUS_URL

# Build the application
RUN npm run build

# Expose port
EXPOSE 4321

# Start the application
CMD ["node", "dist/server/entry.mjs"]