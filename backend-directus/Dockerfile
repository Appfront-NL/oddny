FROM directus/directus:11

# Create directus user directories
USER root
RUN mkdir -p /directus/database && chown -R node:node /directus

# Copy our database and uploads as the node user
COPY --chown=node:node database.sqlite /directus/database/database.sqlite
COPY --chown=node:node uploads/ /directus/uploads/

# Switch back to node user
USER node

# Set environment variables to use our existing database
ENV DB_CLIENT=sqlite3
ENV DB_FILENAME=/directus/database/database.sqlite
ENV PUBLIC_URL=http://localhost:8055
ENV CORS_ENABLED=true
ENV CORS_ORIGIN=http://localhost,http://localhost:4321,true

# Expose port
EXPOSE 8055