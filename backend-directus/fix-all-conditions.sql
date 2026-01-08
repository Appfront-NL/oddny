-- Complete fix for all widget field conditions
-- This script properly hides all fields based on variant

-- First, hide ALL fields by default (set hidden condition for everything)
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"__never__"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"__never__"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' 
  AND field NOT IN ('id', 'variant', 'sort', 'page', 'status', 'page_id');

-- Now enable specific fields for each variant

-- ============================================
-- VARIANT: about-us
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"about-us"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"about-us"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'au_title_en', 'au_title_nl',
  'au_title_line1_en', 'au_title_line1_nl',
  'au_title_line2_en', 'au_title_line2_nl',
  'au_intro_en', 'au_intro_nl',
  'au_mission_title_en', 'au_mission_title_nl',
  'au_mission_text_en', 'au_mission_text_nl',
  'au_promise_title_en', 'au_promise_title_nl',
  'au_promise_text_en', 'au_promise_text_nl',
  'au_cta_text_en', 'au_cta_text_nl',
  'au_cta_link',
  'au_oddny_label_en', 'au_oddny_label_nl',
  'au_harrison_label_en', 'au_harrison_label_nl',
  'au_humans_label_en', 'au_humans_label_nl'
);

-- ============================================
-- VARIANT: character-cards
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
  'harrison_energy', 'harrison_cuteness', 'harrison_overall'
);

-- ============================================
-- VARIANT: friends-and-foes
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"friends-and-foes"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"friends-and-foes"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND (
  field LIKE 'ff_name_%' OR 
  field LIKE 'ff_role_%' OR
  field = 'ff_card_count' OR
  field = 'heading_en' OR field = 'heading_nl'
);

-- ============================================
-- VARIANT: contact-widget
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"contact-widget"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"contact-widget"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'contact_email', 'contact_phone',
  'email_text_en', 'email_text_nl',
  'phone_text_en', 'phone_text_nl',
  'postcard_text_en', 'postcard_text_nl'
);

-- ============================================
-- VARIANT: newsletter-cta
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"newsletter-cta"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"newsletter-cta"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'np_title_en', 'np_title_nl',
  'np_subtitle_en', 'np_subtitle_nl',
  'np_placeholder_en', 'np_placeholder_nl',
  'np_button_text_en', 'np_button_text_nl'
);

-- ============================================
-- VARIANT: tools-collection
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"tools-collection"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"tools-collection"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'tc_nav1_en', 'tc_nav1_nl',
  'tc_nav2_en', 'tc_nav2_nl', 
  'tc_nav3_en', 'tc_nav3_nl',
  'tc_type_tools_en', 'tc_type_tools_nl',
  'tc_type_guide_en', 'tc_type_guide_nl',
  'tc_type_product_en', 'tc_type_product_nl',
  'tc_card1_type_en', 'tc_card1_type_nl', 'tc_card1_text_en', 'tc_card1_text_nl', 'tc_card1_image',
  'tc_card2_type_en', 'tc_card2_type_nl', 'tc_card2_text_en', 'tc_card2_text_nl', 'tc_card2_image',
  'tc_card3_type_en', 'tc_card3_type_nl', 'tc_card3_text_en', 'tc_card3_text_nl', 'tc_card3_image',
  'tc_card4_type_en', 'tc_card4_type_nl', 'tc_card4_text_en', 'tc_card4_text_nl', 'tc_card4_image',
  'tc_card5_type_en', 'tc_card5_type_nl', 'tc_card5_text_en', 'tc_card5_text_nl', 'tc_card5_image',
  'tc_card6_type_en', 'tc_card6_type_nl', 'tc_card6_text_en', 'tc_card6_text_nl', 'tc_card6_image',
  'tc_card7_type_en', 'tc_card7_type_nl', 'tc_card7_text_en', 'tc_card7_text_nl', 'tc_card7_image',
  'tc_card8_type_en', 'tc_card8_type_nl', 'tc_card8_text_en', 'tc_card8_text_nl', 'tc_card8_image',
  'tc_card9_type_en', 'tc_card9_type_nl', 'tc_card9_text_en', 'tc_card9_text_nl', 'tc_card9_image'
);

-- ============================================
-- VARIANT: tool-hero (and guide-hero if exists)
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["tool-hero","guide-hero"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["tool-hero","guide-hero"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'th_category_en', 'th_category_nl',
  'th_bg_color'
);

-- ============================================
-- VARIANT: popular-resources
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
-- VARIANT: oddny-partner / oddny-partners
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["oddny-partner","oddny-partners"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["oddny-partner","oddny-partners"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'partners_subtitle_en', 'partners_subtitle_nl',
  'speech_text_en', 'speech_text_nl',
  'benefits_en', 'benefits_nl',
  'partner1_name_en', 'partner1_name_nl', 'partner1_role_en', 'partner1_role_nl',
  'partner2_name_en', 'partner2_name_nl', 'partner2_role_en', 'partner2_role_nl',
  'partner3_name_en', 'partner3_name_nl', 'partner3_role_en', 'partner3_role_nl',
  'partner4_name_en', 'partner4_name_nl', 'partner4_role_en', 'partner4_role_nl',
  'partner5_name_en', 'partner5_name_nl', 'partner5_role_en', 'partner5_role_nl',
  'partner6_name_en', 'partner6_name_nl', 'partner6_role_en', 'partner6_role_nl'
);

-- ============================================
-- VARIANT: oddny-hub / hub-welcome
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["oddny-hub","hub-welcome"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["oddny-hub","hub-welcome"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'subheading_en', 'subheading_nl',
  'welcome_text_en', 'welcome_text_nl',
  'tools_link', 'guides_link', 'products_link',
  'tools_link_text_en', 'tools_link_text_nl',
  'guides_link_text_en', 'guides_link_text_nl',
  'products_link_text_en', 'products_link_text_nl',
  'hub_speech1_en', 'hub_speech1_nl',
  'hub_speech2_en', 'hub_speech2_nl',
  'benefit1_en', 'benefit1_nl', 'benefit1_desc_en', 'benefit1_desc_nl',
  'benefit2_en', 'benefit2_nl', 'benefit2_desc_en', 'benefit2_desc_nl',
  'benefit3_en', 'benefit3_nl', 'benefit3_desc_en', 'benefit3_desc_nl',
  'benefit4_en', 'benefit4_nl', 'benefit4_desc_en', 'benefit4_desc_nl',
  'card1_label', 'card2_label', 'card3_label',
  'card1_text_en', 'card1_text_nl',
  'card2_text_en', 'card2_text_nl',
  'card3_text_en', 'card3_text_nl'
);

-- ============================================
-- VARIANT: oddny-hero
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
-- VARIANT: oddny-cards / dynamic-cards
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["oddny-cards","dynamic-cards"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["oddny-cards","dynamic-cards"]}}]},"hidden":true,"options":{}}]'
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
-- VARIANT: pricing-cards
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"pricing-cards"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"pricing-cards"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'from_label_en', 'from_label_nl',
  'card1_title_en', 'card1_title_nl', 'card1_excerpt_en', 'card1_excerpt_nl', 'card1_price_en', 'card1_price_nl',
  'card2_title_en', 'card2_title_nl', 'card2_excerpt_en', 'card2_excerpt_nl', 'card2_price_en', 'card2_price_nl',
  'card3_title_en', 'card3_title_nl', 'card3_excerpt_en', 'card3_excerpt_nl', 'card3_price_en', 'card3_price_nl'
);

-- ============================================
-- VARIANT: how-to-buy
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
-- VARIANT: creative-flow-cards
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"creative-flow-cards"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"creative-flow-cards"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'cta_text_en', 'cta_text_nl', 'cta_link',
  'cc_card1_label_en', 'cc_card1_label_nl', 'cc_card1_text_en', 'cc_card1_text_nl', 'cc_card1_link', 'cc_card1_title_en', 'cc_card1_title_nl', 'cc_card1_image',
  'cc_card2_label_en', 'cc_card2_label_nl', 'cc_card2_text_en', 'cc_card2_text_nl', 'cc_card2_link', 'cc_card2_title_en', 'cc_card2_title_nl', 'cc_card2_image',
  'cc_card3_label_en', 'cc_card3_label_nl', 'cc_card3_text_en', 'cc_card3_text_nl', 'cc_card3_link', 'cc_card3_title_en', 'cc_card3_title_nl', 'cc_card3_image'
);

-- ============================================
-- VARIANT: image-overlay (hero)
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
-- VARIANT: wunderkamer-image-text
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
-- VARIANT: wunderkamer-text-3
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_eq":"wunderkamer-text-3"}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_neq":"wunderkamer-text-3"}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'content_en', 'content_nl'
);

-- ============================================
-- VARIANT: colour-cards-* (green, pink, teal)
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["colour-cards-green","colour-cards-pink","colour-cards-teal"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["colour-cards-green","colour-cards-pink","colour-cards-teal"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'subheading_en', 'subheading_nl'
);

-- ============================================
-- VARIANT: simple / default / banner / etc (basic text blocks)
-- ============================================
UPDATE directus_fields SET 
  conditions = '[{"rule":{"_and":[{"variant":{"_in":["simple","default","banner","centered","left","columns","highlight","gradient"]}}]},"hidden":false,"options":{}},{"rule":{"_and":[{"variant":{"_nin":["simple","default","banner","centered","left","columns","highlight","gradient"]}}]},"hidden":true,"options":{}}]'
WHERE collection = 'blocks' AND field IN (
  'heading_en', 'heading_nl',
  'content_en', 'content_nl',
  'text_en', 'text_nl',
  'text_size_preset', 'color_theme',
  'button_text_en', 'button_text_nl',
  'button_link',
  'image'
);

-- ============================================
-- Always visible fields (for all variants)
-- ============================================
UPDATE directus_fields SET conditions = NULL, hidden = 0
WHERE collection = 'blocks' AND field IN ('variant', 'sort');

-- Hide system/internal fields
UPDATE directus_fields SET hidden = 1
WHERE collection = 'blocks' AND field IN (
  'id', 'page', 'page_id', 'status', 'block_type', 
  'language', 'translation_group', 'live_preview_sync',
  'heading', 'background', 'button_link_2'
);

SELECT 'All conditions updated successfully';
