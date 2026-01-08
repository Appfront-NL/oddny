-- FINAL FIX: Show only fields that are ACTUALLY USED in widget code
-- Based on analysis of actual widget .astro files

-- Step 1: Hide ALL fields by default
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"__never__"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"__never__"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' 
  AND field NOT IN ('id', 'variant', 'sort', 'page', 'status', 'page_id');

-- Step 2: Always show variant and sort
UPDATE directus_fields SET conditions = NULL, hidden = 0
WHERE collection = 'blocks' AND field IN ('variant', 'sort');

-- Step 3: Always hide system fields
UPDATE directus_fields SET hidden = 1
WHERE collection = 'blocks' AND field IN (
  'id', 'page', 'page_id', 'status', 'block_type', 
  'language', 'translation_group', 'live_preview_sync',
  'heading', 'background', 'button_link_2'
);

-- ============================================
-- NEWSLETTER-CTA: heading, content, button_text, text (placeholder)
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"newsletter-cta"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"newsletter-cta"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'content_en', 'content_nl',
  'button_text_en', 'button_text_nl',
  'text_en', 'text_nl'
);

-- ============================================
-- ABOUT-US: au_title_line1, au_title_line2, au_intro, au_mission_title, au_mission_text, au_promise_title, au_promise_text, au_cta_text, au_cta_link
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"about-us"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"about-us"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'au_title_line1_en', 'au_title_line1_nl',
  'au_title_line2_en', 'au_title_line2_nl',
  'au_intro_en', 'au_intro_nl',
  'au_mission_title_en', 'au_mission_title_nl',
  'au_mission_text_en', 'au_mission_text_nl',
  'au_promise_title_en', 'au_promise_title_nl',
  'au_promise_text_en', 'au_promise_text_nl',
  'au_cta_text_en', 'au_cta_text_nl',
  'au_cta_link'
);

-- ============================================
-- CHARACTER-CARDS: oddny_*, harrison_*, label fields
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"character-cards"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"character-cards"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'oddny_name_en', 'oddny_name_nl',
  'oddny_fact_en', 'oddny_fact_nl',
  'oddny_image',
  'oddny_knowledge', 'oddny_strength', 'oddny_protection', 
  'oddny_energy', 'oddny_cuteness', 'oddny_overall',
  'harrison_name_en', 'harrison_name_nl',
  'harrison_fact_en', 'harrison_fact_nl',
  'harrison_image',
  'harrison_knowledge', 'harrison_strength', 'harrison_protection',
  'harrison_energy', 'harrison_cuteness', 'harrison_overall',
  'fact_file_label_en', 'fact_file_label_nl',
  'stats_label_en', 'stats_label_nl',
  'knowledge_label_en', 'knowledge_label_nl',
  'strength_label_en', 'strength_label_nl',
  'protection_label_en', 'protection_label_nl',
  'energy_label_en', 'energy_label_nl',
  'cuteness_label_en', 'cuteness_label_nl',
  'overall_label_en', 'overall_label_nl'
);

-- ============================================
-- COLOUR-CARDS (green/pink/teal): heading, cc_card*_label, cc_card*_text, cc_card*_link, cta_text, cta_link
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["colour-cards-green","colour-cards-pink","colour-cards-teal"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["colour-cards-green","colour-cards-pink","colour-cards-teal"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'cc_card1_label_en', 'cc_card1_label_nl', 'cc_card1_text_en', 'cc_card1_text_nl', 'cc_card1_link',
  'cc_card2_label_en', 'cc_card2_label_nl', 'cc_card2_text_en', 'cc_card2_text_nl', 'cc_card2_link',
  'cc_card3_label_en', 'cc_card3_label_nl', 'cc_card3_text_en', 'cc_card3_text_nl', 'cc_card3_link',
  'cta_text_en', 'cta_text_nl', 'cta_link'
);

-- ============================================
-- CONTACT-WIDGET: contact_email, contact_phone, email_text, phone_text, postcard_text
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"contact-widget"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"contact-widget"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'contact_email', 'contact_phone',
  'email_text_en', 'email_text_nl',
  'phone_text_en', 'phone_text_nl',
  'postcard_text_en', 'postcard_text_nl'
);

-- ============================================
-- CREATIVE-FLOW-CARDS: heading, cf_nav1-3, cf_from_label, cf_check_prices_label
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"creative-flow-cards"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"creative-flow-cards"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'cf_nav1_en', 'cf_nav1_nl',
  'cf_nav2_en', 'cf_nav2_nl',
  'cf_nav3_en', 'cf_nav3_nl',
  'cf_from_label_en', 'cf_from_label_nl',
  'cf_check_prices_label_en', 'cf_check_prices_label_nl'
);

-- ============================================
-- DYNAMIC-CARDS: heading, card1-6_title, card1-6_excerpt, image, image_2-6
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"dynamic-cards"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"dynamic-cards"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'image', 'image_2', 'image_3', 'image_4', 'image_5', 'image_6',
  'card1_title_en', 'card1_title_nl', 'card1_excerpt_en', 'card1_excerpt_nl',
  'card2_title_en', 'card2_title_nl', 'card2_excerpt_en', 'card2_excerpt_nl',
  'card3_title_en', 'card3_title_nl', 'card3_excerpt_en', 'card3_excerpt_nl',
  'card4_title_en', 'card4_title_nl', 'card4_excerpt_en', 'card4_excerpt_nl',
  'card5_title_en', 'card5_title_nl', 'card5_excerpt_en', 'card5_excerpt_nl',
  'card6_title_en', 'card6_title_nl', 'card6_excerpt_en', 'card6_excerpt_nl'
);

-- ============================================
-- FRIENDS-AND-FOES: heading (uses ff_name_*_en dynamically from JSON, not individual fields)
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"friends-and-foes"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"friends-and-foes"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'ff_card_count'
);

-- ============================================
-- GUIDES-COLLECTION: heading, gc_nav1-3
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"guides-collection"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"guides-collection"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'gc_nav1_en', 'gc_nav1_nl',
  'gc_nav2_en', 'gc_nav2_nl',
  'gc_nav3_en', 'gc_nav3_nl'
);

-- ============================================
-- IMAGE-OVERLAY (hero): heading, button_text, button_link, background_image
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"image-overlay"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"image-overlay"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'button_text_en', 'button_text_nl',
  'button_link',
  'background_image'
);

-- ============================================
-- HOW-TO-BUY: heading, content, step1-3_title, step1-3_desc
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"how-to-buy"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"how-to-buy"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'content_en', 'content_nl',
  'step1_title_en', 'step1_title_nl', 'step1_desc_en', 'step1_desc_nl',
  'step2_title_en', 'step2_title_nl', 'step2_desc_en', 'step2_desc_nl',
  'step3_title_en', 'step3_title_nl', 'step3_desc_en', 'step3_desc_nl'
);

-- ============================================
-- ODDNY-PARTNER: heading, content, button_text, button_link, benefit1-4, benefit1-4_desc
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["oddny-partner","oddny-partners"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["oddny-partner","oddny-partners"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'content_en', 'content_nl',
  'button_text_en', 'button_text_nl',
  'button_link',
  'benefit1_en', 'benefit1_nl', 'benefit1_desc_en', 'benefit1_desc_nl',
  'benefit2_en', 'benefit2_nl', 'benefit2_desc_en', 'benefit2_desc_nl',
  'benefit3_en', 'benefit3_nl', 'benefit3_desc_en', 'benefit3_desc_nl',
  'benefit4_en', 'benefit4_nl', 'benefit4_desc_en', 'benefit4_desc_nl'
);

-- ============================================
-- POPULAR-RESOURCES: pr_heading, pr_card1-3_type, pr_card1-3_text, pr_card1-3_link
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"popular-resources"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"popular-resources"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'pr_heading_en', 'pr_heading_nl',
  'pr_card1_type_en', 'pr_card1_type_nl', 'pr_card1_text_en', 'pr_card1_text_nl', 'pr_card1_link',
  'pr_card2_type_en', 'pr_card2_type_nl', 'pr_card2_text_en', 'pr_card2_text_nl', 'pr_card2_link',
  'pr_card3_type_en', 'pr_card3_type_nl', 'pr_card3_text_en', 'pr_card3_text_nl', 'pr_card3_link'
);

-- ============================================
-- PRICING-CARDS: heading, from_label, card1-3_label, card1-3_text, card1-3_price, button_text, button_link
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"pricing-cards"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"pricing-cards"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'from_label_en', 'from_label_nl',
  'card1_label', 'card1_text_en', 'card1_text_nl', 'card1_price_en', 'card1_price_nl',
  'card2_label', 'card2_text_en', 'card2_text_nl', 'card2_price_en', 'card2_price_nl',
  'card3_label', 'card3_text_en', 'card3_text_nl', 'card3_price_en', 'card3_price_nl',
  'button_text_en', 'button_text_nl',
  'button_link'
);

-- ============================================
-- TOOL-HERO: heading, th_category, th_bg_color
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"tool-hero"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"tool-hero"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'th_category_en', 'th_category_nl',
  'th_bg_color'
);

-- ============================================
-- TOOLS-COLLECTION: heading, tc_nav1-3
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"tools-collection"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"tools-collection"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'tc_nav1_en', 'tc_nav1_nl',
  'tc_nav2_en', 'tc_nav2_nl',
  'tc_nav3_en', 'tc_nav3_nl'
);

-- ============================================
-- WUNDERKAMER-IMAGE-TEXT: heading, content, button_text, button_link, image
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"wunderkamer-image-text"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"wunderkamer-image-text"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'content_en', 'content_nl',
  'button_text_en', 'button_text_nl',
  'button_link',
  'image'
);

-- ============================================
-- WUNDERKAMER-TEXT-3: heading, content
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"wunderkamer-text-3"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"wunderkamer-text-3"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'content_en', 'content_nl'
);

-- ============================================
-- ODDNY-HERO: heading_pink, heading_brown, subheading, button_text, button_link, background_image
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"oddny-hero"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"oddny-hero"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_pink_en', 'heading_pink_nl',
  'heading_brown_en', 'heading_brown_nl',
  'subheading_en', 'subheading_nl',
  'button_text_en', 'button_text_nl',
  'button_link',
  'background_image'
);

-- ============================================
-- HUB-WELCOME / ODDNY-HUB: Needs to be checked in HubWelcome.astro
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["hub-welcome","oddny-hub"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["hub-welcome","oddny-hub"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'subheading_en', 'subheading_nl',
  'welcome_text_en', 'welcome_text_nl'
);

SELECT 'All field conditions updated based on actual widget code';
