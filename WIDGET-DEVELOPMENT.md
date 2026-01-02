# Widget Development Guide for Oddny

## Adding New Widgets

### Step 1: Read the Figma Export
Look at the App.tsx file from the Figma export to understand the structure, styling, and content.

### Step 2: Add Variant to BlockRenderer.astro
Add a new `else if (variant === 'your-variant')` block in `/src/components/BlockRenderer.astro`.

### Step 3: Add Template to slug.astro
Add the widget template to the `BLOCK_TEMPLATES` array in `/src/pages/[locale]/[slug].astro` so it appears in the "Add Block" menu.

### Step 4: Add Database Fields (if needed)
SSH to server and add columns:
```bash
ssh root@85.215.222.143 "cd /var/www/pagebuilder/directus && sqlite3 database.sqlite \"
ALTER TABLE blocks ADD COLUMN your_field_en TEXT;
ALTER TABLE blocks ADD COLUMN your_field_nl TEXT;
\""
```

### Step 5: Deploy
```bash
cd /tmp/oddny && git add -A && git commit -m "Add your-widget" && git push origin main && ssh root@85.215.222.143 "cd /var/www/pagebuilder/astro && git pull origin main && rm -rf dist && npm run build && pm2 restart astro"
```

---

## Making Fields Editable

### Simple Text Fields (popover)
For single-line text that can be edited inline:
```astro
<h3
  data-directus={setAttr({ collection: 'blocks', item: block.id, fields: `field_name_${locale}`, mode: 'popover' })}
>{block[`field_name_${locale}`] || 'Default text'}</h3>
```

### Button with Text + Link
For buttons that need both text and link editable:
```astro
<a
  href={block.button_link || '#'}
  data-directus={setAttr({ collection: 'blocks', item: block.id, fields: `button_text_${locale},button_link`, mode: 'popover' })}
>
  {block[`button_text_${locale}`] || 'Click here'}
</a>
```

### Rich Text Fields (WYSIWYG Editor)
For content that needs formatting (headings, bold, lists, links), use the custom Quill editor:

```astro
<div
  class="your-richtext-class"
  data-richtext
  data-richtext-collection="blocks"
  data-richtext-item={block.id}
  data-richtext-field={`your_field_${locale}`}
  set:html={block[`your_field_${locale}`] || `
    <h3>Default Heading</h3>
    <p>Default paragraph text here.</p>
  `}
/>
```

**Important for Rich Text:**
1. Use `data-richtext` attribute (NOT `data-directus`)
2. Use `set:html` to render HTML content
3. Provide default HTML as fallback
4. The field name should end with `_${locale}` for language support
5. Add the database field as TEXT type

### Database Field Naming Convention
- Locale-specific fields: `fieldname_en`, `fieldname_nl`
- Non-locale fields (like links): `fieldname` (no suffix)

---

## Rich Text Editor Implementation

The custom Quill editor is implemented in `/src/layouts/Layout.astro` and works as follows:

1. **Only activates in iframe** - Checks `window !== window.parent` to detect Directus visual editor
2. **Loads Quill dynamically** - CSS and JS loaded from CDN only when needed
3. **Hover indicator** - Shows "Edit Rich Text" badge on hover
4. **Modal editor** - Opens Quill WYSIWYG in a modal popup
5. **Direct API save** - Saves to Directus via PATCH request

### Quill Toolbar Features
- Header levels (H1, H2, H3, Normal)
- Bold, Italic, Underline
- Ordered and Bullet lists
- Links
- Clear formatting

### Styling Rich Text Content
Add CSS for the rendered content in your widget:
```css
.your-richtext-class {
  font-family: 'Neue Haas Grotesk Display Pro', sans-serif;
}
.your-richtext-class h3 {
  font-size: 28px;
  font-weight: 500;
  color: #42383e;
  margin: 0 0 8px 0;
}
.your-richtext-class p {
  font-size: 16px;
  color: #acaaaa;
  margin: 0 0 32px 0;
}
```

---

## Example: oddny-hub Widget

The oddny-hub widget demonstrates all editing types:

### Simple Text (popover)
```astro
<p
  class="oddny-hub-intro"
  data-directus={setAttr({ collection: 'blocks', item: block.id, fields: `heading_${locale}`, mode: 'popover' })}
>{heading || 'Default intro text'}</p>
```

### Rich Text (Quill editor)
```astro
<div
  class="oddny-hub-steps-content"
  data-richtext
  data-richtext-collection="blocks"
  data-richtext-item={block.id}
  data-richtext-field={`steps_content_${locale}`}
  set:html={block[`steps_content_${locale}`] || `
    <h3>Step One: Title</h3>
    <p>Description text...</p>
  `}
/>
```

### Card Labels (non-locale)
```astro
<div
  class="oddny-hub-card-label"
  data-directus={setAttr({ collection: 'blocks', item: block.id, fields: 'card1_label', mode: 'popover' })}
>{block.card1_label || 'Tools'}</div>
```

### Link Buttons (text + link)
```astro
<a
  href={block.tools_link || '#'}
  class="oddny-hub-card-link"
  data-directus={setAttr({ collection: 'blocks', item: block.id, fields: `tools_link_text_${locale},tools_link`, mode: 'popover' })}
>
  <span>{block[`tools_link_text_${locale}`] || 'More Tools'}</span>
</a>
```

---

## Server Information

- **Directus URL**: http://85.215.222.143:8055
- **Astro URL**: http://85.215.222.143
- **Database**: `/var/www/pagebuilder/directus/database.sqlite`
- **PM2 processes**: `directus`, `astro`
