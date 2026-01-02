FROM node:20-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build argument for Directus URL
ARG DIRECTUS_URL=http://directus:8055
ENV DIRECTUS_URL=$DIRECTUS_URL

# Build the application
RUN npm run build

# Expose port
EXPOSE 4321

# Start the application
CMD ["node", "dist/server/entry.mjs"]