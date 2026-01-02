#!/bin/bash

# Oddny Setup Script for Appfront Server
# Run with: sudo bash setup-appfront.sh

set -e

echo "=== Oddny Setup Script ==="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run with sudo: sudo bash setup-appfront.sh"
  exit 1
fi

cd /opt/projects/oddny

echo "1. Stopping Docker containers..."
docker compose down 2>/dev/null || true

echo "2. Pulling latest code..."
git pull origin main

echo "3. Updating nginx config..."
# Backup original
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup.$(date +%Y%m%d%H%M%S)

# Read the current config and replace oddny section
python3 << 'PYTHON_SCRIPT'
import re

with open('/etc/nginx/sites-available/default', 'r') as f:
    content = f.read()

# Pattern to find the oddny.appfront.nl server block
pattern = r'server\s*\{\s*\n\s*listen\s+443\s+ssl;\s*\n\s*server_name\s+oddny\.appfront\.nl;.*?^\}'

with open('/opt/projects/oddny/nginx-oddny.conf', 'r') as f:
    new_oddny_block = f.read()

# Replace the oddny block
new_content = re.sub(pattern, new_oddny_block, content, flags=re.MULTILINE | re.DOTALL)

with open('/etc/nginx/sites-available/default', 'w') as f:
    f.write(new_content)

print("Nginx config updated")
PYTHON_SCRIPT

echo "4. Testing nginx config..."
nginx -t

echo "5. Reloading nginx..."
systemctl reload nginx

echo "6. Building and starting Docker containers..."
docker compose up -d --build

echo "7. Waiting for Directus to start (30 seconds)..."
sleep 30

echo "=== Setup Complete ==="
echo ""
echo "Your site should now be available at:"
echo "  - Frontend: https://oddny.appfront.nl"
echo "  - Directus Admin: https://oddny.appfront.nl/cms/admin"
echo ""
echo "Default Directus login:"
echo "  - Email: admin@example.com"
echo "  - Password: admin"
