# Pagebuilder - Directus + Astro

Visual page builder met Directus CMS en Astro frontend.

## Stack
- **Frontend:** Astro 5 + Tailwind CSS
- **CMS:** Directus 11
- **Database:** SQLite

## Installatie

### 1. Clone & Install
```bash
git clone https://github.com/appfront/pagebuilder.git
cd pagebuilder
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

## URLs
- Frontend: http://localhost:4321
- Directus Admin: http://localhost:8055/admin

## Features
- Visual page editor met live preview
- Block-based content (Hero, Rich Text, Image, Three Column, etc.)
- Multi-language support (NL/EN)
- Blog/Articles systeem
- Inline editing in preview
