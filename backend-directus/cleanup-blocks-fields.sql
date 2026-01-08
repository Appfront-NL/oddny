-- Cleanup blocks fields - Add conditions to show only relevant fields per variant
-- Run with: sqlite3 database.sqlite < cleanup-blocks-fields.sql

-- First, set variant field to sort position 1 (top of form)
UPDATE directus_fields SET sort = 1, width = 'full' WHERE collection = 'blocks' AND field = 'variant';

-- Set block_type to sort position 2
UPDATE directus_fields SET sort = 2, width = 'full' WHERE collection = 'blocks' AND field = 'block_type';

-- Set sort field to position 3
UPDATE directus_fields SET sort = 3, width = 'half' WHERE collection = 'blocks' AND field = 'sort';

-- Set page field to position 4
UPDATE directus_fields SET sort = 4, width = 'half' WHERE collection = 'blocks' AND field = 'page';

-- Common fields (shown for most variants) - positions 10-30
UPDATE directus_fields SET sort = 10 WHERE collection = 'blocks' AND field = 'heading_en';
UPDATE directus_fields SET sort = 11 WHERE collection = 'blocks' AND field = 'heading_nl';
UPDATE directus_fields SET sort = 12 WHERE collection = 'blocks' AND field = 'subheading_en';
UPDATE directus_fields SET sort = 13 WHERE collection = 'blocks' AND field = 'subheading_nl';
UPDATE directus_fields SET sort = 14 WHERE collection = 'blocks' AND field = 'content_en';
UPDATE directus_fields SET sort = 15 WHERE collection = 'blocks' AND field = 'content_nl';
UPDATE directus_fields SET sort = 16 WHERE collection = 'blocks' AND field = 'button_text_en';
UPDATE directus_fields SET sort = 17 WHERE collection = 'blocks' AND field = 'button_text_nl';
UPDATE directus_fields SET sort = 18 WHERE collection = 'blocks' AND field = 'button_link';
UPDATE directus_fields SET sort = 20 WHERE collection = 'blocks' AND field = 'image';
UPDATE directus_fields SET sort = 21 WHERE collection = 'blocks' AND field = 'background_image';

-- ============================================
-- CONDITIONAL VISIBILITY PER VARIANT
-- ============================================

-- ABOUT-US variant fields (au_*)
UPDATE directus_fields SET 
  sort = 100,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"about-us"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"about-us"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field LIKE 'au_%';

-- CHARACTER-CARDS variant fields (oddny_*, harrison_*, fact_file_*, stats_*, knowledge_*, etc)
UPDATE directus_fields SET 
  sort = 200,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"character-cards"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"character-cards"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (
  field LIKE 'oddny_%' OR 
  field LIKE 'harrison_%' OR 
  field LIKE 'fact_file_%' OR 
  field LIKE 'stats_%' OR 
  field LIKE 'knowledge_%' OR 
  field LIKE 'strength_%' OR 
  field LIKE 'protection_%' OR 
  field LIKE 'energy_%' OR 
  field LIKE 'cuteness_%' OR 
  field LIKE 'overall_%'
);

-- FRIENDS-AND-FOES variant fields (ff_*, friends_cards)
UPDATE directus_fields SET 
  sort = 300,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"friends-and-foes"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"friends-and-foes"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (field LIKE 'ff_%' OR field = 'friends_cards' OR field = 'ff_card_count');

-- CONTACT-WIDGET variant fields (contact_*, email_*, phone_*, postcard_*)
UPDATE directus_fields SET 
  sort = 400,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"contact-widget"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"contact-widget"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (
  field LIKE 'contact_%' OR 
  field LIKE 'email_text_%' OR 
  field LIKE 'phone_text_%' OR 
  field LIKE 'postcard_%'
);

-- NEWSLETTER-CTA variant fields (np_*)
UPDATE directus_fields SET 
  sort = 500,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"newsletter-cta"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"newsletter-cta"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field LIKE 'np_%';

-- TOOLS-COLLECTION variant fields (tc_*)
UPDATE directus_fields SET 
  sort = 600,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"tools-collection"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"tools-collection"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field LIKE 'tc_%';

-- TOOL-HERO variant fields (th_*)
UPDATE directus_fields SET 
  sort = 650,
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["tool-hero","guide-hero"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["tool-hero","guide-hero"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field LIKE 'th_%';

-- POPULAR-RESOURCES variant fields (pr_*)
UPDATE directus_fields SET 
  sort = 700,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"popular-resources"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"popular-resources"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field LIKE 'pr_%';

-- ODDNY-PARTNER variant fields (partner*_, partners_*, speech_*, benefits_*)
UPDATE directus_fields SET 
  sort = 800,
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["oddny-partner","oddny-partners"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["oddny-partner","oddny-partners"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (
  field LIKE 'partner%_name_%' OR 
  field LIKE 'partner%_role_%' OR 
  field LIKE 'partners_%' OR 
  field LIKE 'speech_%' OR 
  field LIKE 'benefits_%'
);

-- ODDNY-HUB / HUB-WELCOME variant fields (hub_*, tools_link*, guides_link*, products_link*, benefit%_*)
UPDATE directus_fields SET 
  sort = 900,
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["oddny-hub","hub-welcome"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["oddny-hub","hub-welcome"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (
  field LIKE 'hub_%' OR 
  field LIKE 'tools_link%' OR 
  field LIKE 'guides_link%' OR 
  field LIKE 'products_link%' OR
  field LIKE 'benefit1_%' OR
  field LIKE 'benefit2_%' OR
  field LIKE 'benefit3_%' OR
  field LIKE 'benefit4_%'
);

-- ODDNY-HERO variant fields (heading_pink_*, heading_brown_*)
UPDATE directus_fields SET 
  sort = 950,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"oddny-hero"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"oddny-hero"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (field LIKE 'heading_pink_%' OR field LIKE 'heading_brown_%');

-- ODDNY-CARDS / DYNAMIC-CARDS variant fields (card%_title_*, card%_excerpt_*, card%_label, card%_text_*, card%_link, card%_price_*)
UPDATE directus_fields SET 
  sort = 1000,
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["oddny-cards","dynamic-cards"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["oddny-cards","dynamic-cards"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (
  field LIKE 'card%_title_%' OR 
  field LIKE 'card%_excerpt_%' OR 
  field LIKE 'card%_label' OR 
  field LIKE 'card%_text_%' OR 
  field LIKE 'card%_link'
);

-- PRICING-CARDS variant fields (card%_price_*, from_label_*)
UPDATE directus_fields SET 
  sort = 1050,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"pricing-cards"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"pricing-cards"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (field LIKE 'card%_price_%' OR field LIKE 'from_label_%');

-- HOW-TO-BUY variant fields (step%_*)
UPDATE directus_fields SET 
  sort = 1100,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"how-to-buy"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"how-to-buy"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (field LIKE 'step%_title_%' OR field LIKE 'step%_desc_%' OR field LIKE 'steps_content_%');

-- CREATIVE-FLOW-CARDS variant fields (cc_*, cta_*)
UPDATE directus_fields SET 
  sort = 1200,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"creative-flow-cards"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"creative-flow-cards"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (field LIKE 'cc_%' OR field LIKE 'cta_%');

-- IMAGE fields for cards (image_2 through image_6)
UPDATE directus_fields SET 
  sort = 1300,
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["oddny-cards","dynamic-cards","creative-flow-cards"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["oddny-cards","dynamic-cards","creative-flow-cards"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN ('image_2', 'image_3', 'image_4', 'image_5', 'image_6');

-- TEXT fields (text_en, text_nl) - for simple text blocks
UPDATE directus_fields SET 
  sort = 1400,
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["simple","default","banner","centered","left","columns","highlight","gradient"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["simple","default","banner","centered","left","columns","highlight","gradient"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (field = 'text_en' OR field = 'text_nl' OR field = 'text_size_preset' OR field = 'color_theme');

-- WUNDERKAMER variants - use common heading/content fields, no special fields needed

-- COLOUR-CARDS variants - no special fields, uses heading/content

-- Hide rarely used fields by default
UPDATE directus_fields SET 
  sort = 9000,
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"__never__"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"__never__"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN ('background', 'button_link_2');

-- Update variant field to have proper dropdown options
UPDATE directus_fields SET 
  options = '{"choices":[
    {"text":"About Us","value":"about-us"},
    {"text":"Character Cards","value":"character-cards"},
    {"text":"Colour Cards (Green)","value":"colour-cards-green"},
    {"text":"Colour Cards (Pink)","value":"colour-cards-pink"},
    {"text":"Colour Cards (Teal)","value":"colour-cards-teal"},
    {"text":"Contact Widget","value":"contact-widget"},
    {"text":"Creative Flow Cards","value":"creative-flow-cards"},
    {"text":"Dynamic Cards","value":"dynamic-cards"},
    {"text":"Friends and Foes","value":"friends-and-foes"},
    {"text":"Hero (Image Overlay)","value":"image-overlay"},
    {"text":"Hero (Oddny)","value":"oddny-hero"},
    {"text":"How to Buy","value":"how-to-buy"},
    {"text":"Hub Welcome","value":"hub-welcome"},
    {"text":"Newsletter CTA","value":"newsletter-cta"},
    {"text":"Oddny Cards","value":"oddny-cards"},
    {"text":"Oddny Hub","value":"oddny-hub"},
    {"text":"Oddny Partner","value":"oddny-partner"},
    {"text":"Popular Resources","value":"popular-resources"},
    {"text":"Pricing Cards","value":"pricing-cards"},
    {"text":"Simple Text","value":"simple"},
    {"text":"Tool Hero","value":"tool-hero"},
    {"text":"Tools Collection","value":"tools-collection"},
    {"text":"Wunderkamer (Image + Text)","value":"wunderkamer-image-text"},
    {"text":"Wunderkamer (Text + Composition)","value":"wunderkamer-text-3"}
  ]}',
  interface = 'select-dropdown',
  display = 'labels',
  width = 'full',
  note = 'Kies het widget type - velden worden automatisch getoond/verborgen'
WHERE collection = 'blocks' AND field = 'variant';

-- Make common fields conditional too - only show for variants that use them
-- Heading fields - most variants use these
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["about-us","character-cards","contact-widget","dynamic-cards","friends-and-foes","how-to-buy","hub-welcome","image-overlay","newsletter-cta","oddny-cards","oddny-hero","oddny-hub","oddny-partner","popular-resources","pricing-cards","simple","tool-hero","tools-collection","wunderkamer-image-text","wunderkamer-text-3","colour-cards-green","colour-cards-pink","colour-cards-teal"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["about-us","character-cards","contact-widget","dynamic-cards","friends-and-foes","how-to-buy","hub-welcome","image-overlay","newsletter-cta","oddny-cards","oddny-hero","oddny-hub","oddny-partner","popular-resources","pricing-cards","simple","tool-hero","tools-collection","wunderkamer-image-text","wunderkamer-text-3","colour-cards-green","colour-cards-pink","colour-cards-teal"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN ('heading_en', 'heading_nl');

-- Subheading - fewer variants
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["oddny-hero","hub-welcome","oddny-hub","image-overlay","simple"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["oddny-hero","hub-welcome","oddny-hub","image-overlay","simple"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN ('subheading_en', 'subheading_nl');

-- Content - for text-heavy widgets
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["wunderkamer-image-text","wunderkamer-text-3","how-to-buy","simple","default"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["wunderkamer-image-text","wunderkamer-text-3","how-to-buy","simple","default"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN ('content_en', 'content_nl');

-- Button text/link - for widgets with CTAs
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["oddny-hero","hub-welcome","image-overlay","wunderkamer-image-text","oddny-partner","simple"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["oddny-hero","hub-welcome","image-overlay","wunderkamer-image-text","oddny-partner","simple"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN ('button_text_en', 'button_text_nl', 'button_link');

-- Image field - for widgets with single image
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["image-overlay","wunderkamer-image-text","oddny-cards","dynamic-cards","simple"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["image-overlay","wunderkamer-image-text","oddny-cards","dynamic-cards","simple"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field = 'image';

-- Background image - for hero widgets
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["image-overlay","oddny-hero"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["image-overlay","oddny-hero"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field = 'background_image';
