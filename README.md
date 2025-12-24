# Oddny - Directus + Astro

Visual page builder met Directus CMS en Astro frontend.

## Stack
- **Frontend:** Astro 5 + Tailwind CSS
- **CMS:** Directus 11
- **Database:** SQLite

## Quick Start (Docker)

```bash
# Clone repo
git clone git@github.com:Appfront-NL/oddny.git
cd oddny

# Copy environment file
cp .env.docker .env

# Start services
docker compose up -d

# Apply Directus schema (first time only)
docker compose exec directus npx directus schema apply /directus/schema-snapshot.yaml
```

**URLs:**
- Frontend: http://localhost:4321
- Directus Admin: http://localhost:8055/admin
- Login: admin@example.com / admin

## Manual Installation

### 1. Clone & Install
```bash
git clone git@github.com:Appfront-NL/oddny.git
cd oddny
npm install
cd directus && npm install && cd ..
```

### 2. Directus Setup
```bash
cd directus
cp .env.example .env
# Edit .env met je eigen keys
npx directus bootstrap
npx directus schema apply ./schema-snapshot.yaml
```

### 3. Astro Setup
```bash
cp .env.example .env
# Edit .env met je Directus URL
npm run build
```

### 4. Start Services
```bash
# Terminal 1 - Directus
cd directus && npx directus start

# Terminal 2 - Astro
npm run dev
```

## Features
- Visual page editor met live preview
- Block-based content (Hero, Rich Text, Image, Three Column, etc.)
- Multi-language support (NL/EN)
- Blog/Articles systeem
- Inline editing in preview
- Save & Stay functionality
