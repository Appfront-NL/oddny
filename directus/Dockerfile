FROM directus/directus:11

# Copy the database file to the correct location
COPY --chown=node:node database.sqlite /directus/database.sqlite
COPY --chown=node:node uploads/ /directus/uploads/

# Set environment variables
ENV DB_CLIENT=sqlite3
ENV DB_FILENAME=/directus/database.sqlite
ENV PUBLIC_URL=http://localhost:8055
ENV CORS_ENABLED=true
ENV CORS_ORIGIN=http://localhost,http://localhost:4321,true

# Expose port
EXPOSE 8055