FROM directus/directus:11

USER root

# Create directus user directories
RUN mkdir -p /directus/database && chown -R node:node /directus

# Copy package files for extension installation
COPY --chown=node:node package.json package-lock.json /directus/

# Install extensions as node user
USER node
WORKDIR /directus
RUN npm ci --omit=dev

# Switch back to root for copying data files
USER root

# Copy our database and uploads
COPY --chown=node:node database.sqlite /directus/database/database.sqlite
COPY --chown=node:node uploads/ /directus/uploads/

# Copy extensions folder if exists
COPY --chown=node:node extensions/ /directus/extensions/

# Switch back to node user
USER node

# Set environment variables
ENV DB_CLIENT=sqlite3
ENV DB_FILENAME=/directus/database/database.sqlite

EXPOSE 8055
