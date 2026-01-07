# Project: Oddny Widget System

## Directus Visual Editor - Velden Editbaar Maken

Om velden aanpasbaar te maken in de Directus visual editor:

### 1. ALTER TABLE - Voeg kolom toe aan blocks tabel
```sql
ALTER TABLE blocks ADD COLUMN fieldname_en TEXT DEFAULT '';
ALTER TABLE blocks ADD COLUMN fieldname_nl TEXT DEFAULT '';
```

### 2. INSERT INTO directus_fields - Registreer in Directus
```sql
INSERT INTO directus_fields (collection, field, interface, display, options)
VALUES ('blocks', 'fieldname_en', 'input', 'formatted-value', '{}');
```

### 3. UPDATE defaults - Vul standaardwaarden in
```sql
UPDATE blocks SET fieldname_en = 'Default text' WHERE fieldname_en IS NULL OR fieldname_en = '';
```

### 4. Restart Directus
```bash
pkill -f "node.*directus"; sleep 2; cd backend-directus && npx directus start &
```

### 5. In widget - Gebruik setAttr met array syntax
```astro
data-directus={setAttr({
  collection: 'blocks',
  item: block.id,
  fields: [`fieldname_${locale}`],
  mode: 'popover'
})}
```

## Database Locatie
```
/Users/fabianvandijk/Documents/Apfront styleguide/local-copy/backend-directus/database.sqlite
```

## Widget Toevoegen Checklist
1. Maak widget bestand in `/frontend-astro/src/components/widgets/WidgetName.astro`
2. Voeg import toe in `BlockRenderer.astro`
3. Voeg if-statement toe voor variant in `BlockRenderer.astro`
4. Voeg entry toe aan `BLOCK_TEMPLATES` in `[locale]/[slug].astro`
5. Voeg database kolommen toe (ALTER TABLE)
6. Registreer velden in directus_fields (INSERT)
7. Zet standaardwaarden (UPDATE)
8. Herstart Directus
