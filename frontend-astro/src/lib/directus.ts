import { createDirectus, rest, readItems, readItem, staticToken } from '@directus/sdk';

// Server-side Directus URL (for API calls from Astro server)
const DIRECTUS_URL = import.meta.env.DIRECTUS_URL || 'http://localhost:8055';

// Public Directus URL (for browser/client-side asset URLs)
// In production with nginx proxy, this is '/cms'. In development, same as DIRECTUS_URL.
export const PUBLIC_DIRECTUS_URL = import.meta.env.PUBLIC_DIRECTUS_URL || DIRECTUS_URL;

const DIRECTUS_TOKEN = import.meta.env.DIRECTUS_TOKEN || '90ce679e199f84430ca651a4a3460386';

// Supported locales
export const locales = ['en', 'nl'] as const;
export type Locale = typeof locales[number];
export const defaultLocale: Locale = 'en';

const client = createDirectus(DIRECTUS_URL)
  .with(staticToken(DIRECTUS_TOKEN))
  .with(rest());

export { client, readItems, readItem };

export interface Block {
  id: number;
  block_type: string;
  variant?: string;
  // Legacy single-language fields (for backward compatibility)
  heading?: string;
  subheading?: string;
  content?: string;
  button_text?: string;
  text?: string;
  // Multilingual text fields
  heading_en?: string;
  heading_nl?: string;
  subheading_en?: string;
  subheading_nl?: string;
  content_en?: string;
  content_nl?: string;
  button_text_en?: string;
  button_text_nl?: string;
  text_en?: string;
  text_nl?: string;
  // Non-translatable fields
  button_link?: string;
  image?: string;
  image_position?: string;
  sort?: number;
  translation_group?: string;
  page_id?: string;
  background_image?: string;
}

export interface Page {
  id: string;
  title: string;
  slug: string;
  status: string;
  language: Locale;
  translation_group?: string;
  blocks: Block[];
}

export async function getPageBySlug(slug: string, locale: Locale = defaultLocale, preview = false): Promise<Page | null> {
  try {
    const filter: any = {
      slug: { _eq: slug },
      language: { _eq: locale }
    };

    if (!preview) {
      filter.status = { _eq: 'published' };
    }

    const pages = await client.request(
      readItems('pages', {
        filter,
        fields: ['*', 'blocks.*'],
        limit: 1,
      })
    );

    return (pages as Page[])[0] || null;
  } catch (error) {
    console.error('Error fetching page:', error);
    return null;
  }
}

export async function getAllPages(locale?: Locale): Promise<Page[]> {
  try {
    const filter: any = { status: { _eq: 'published' } };
    if (locale) {
      filter.language = { _eq: locale };
    }

    const pages = await client.request(
      readItems('pages', {
        filter,
        fields: ['*'],
      })
    );

    return pages as Page[];
  } catch (error) {
    console.error('Error fetching all pages:', error);
    return [];
  }
}

export async function getPageWithBlocks(slug: string, locale: Locale = defaultLocale, preview = false): Promise<{ page: Page; blocks: Block[] } | null> {
  const page = await getPageBySlug(slug, locale, preview);

  if (!page) return null;

  // Blocks are already included via the relation
  const blocks = (page.blocks || []) as Block[];

  return { page, blocks };
}

// Find translated version of a page
export async function getTranslatedPage(slug: string, fromLocale: Locale, toLocale: Locale): Promise<Page | null> {
  // First get the original page to find its title
  const originalPage = await getPageBySlug(slug, fromLocale);
  if (!originalPage) return null;

  // Try to find a page with same slug in target language
  const translatedPage = await getPageBySlug(slug, toLocale);
  return translatedPage;
}

// Site settings interfaces
export interface SocialLink {
  name: string;
  url: string;
  icon: string;
}

export interface SiteSettings {
  id: number;
  site_name: string;
  logo: string | null;
  footer_logo: string | null;
  footer_text: string | null;
  copyright_text: string | null;
  contact_email: string | null;
  contact_phone: string | null;
  contact_address: string | null;
  social_links: SocialLink[] | null;
  // Footer fields
  footer_newsletter_label_en: string | null;
  footer_newsletter_label_nl: string | null;
  footer_newsletter_button_en: string | null;
  footer_newsletter_button_nl: string | null;
  footer_newsletter_link: string | null;
  footer_col1_title_en: string | null;
  footer_col1_title_nl: string | null;
  footer_col2_title_en: string | null;
  footer_col2_title_nl: string | null;
  footer_col3_title_en: string | null;
  footer_col3_title_nl: string | null;
  linkedin_url: string | null;
  instagram_url: string | null;
  footer_legal_title_en: string | null;
  footer_legal_title_nl: string | null;
  footer_legal_text_en: string | null;
  footer_legal_text_nl: string | null;
  footer_terms_title_en: string | null;
  footer_terms_title_nl: string | null;
  footer_terms_text_en: string | null;
  footer_terms_text_nl: string | null;
}

export interface NavigationItem {
  id: string;
  status: string;
  sort: number;
  label: string;
  url: string | null;
  page_id: string | null;
  parent_id: string | null;
  location: 'header' | 'footer' | 'both';
  open_in_new_tab: boolean;
  page?: { slug: string; title: string } | null;
  children?: NavigationItem[];
}

export async function getSiteSettings(): Promise<SiteSettings | null> {
  try {
    const response = await client.request(
      readItems('site_settings', {
        fields: ['*'],
        limit: 1,
      })
    );
    if (Array.isArray(response)) {
      return (response as SiteSettings[])[0] || null;
    }
    return response as SiteSettings;
  } catch (error) {
    console.error('Error fetching site settings:', error);
    return null;
  }
}

export async function getNavigationItems(location?: 'header' | 'footer' | 'both'): Promise<NavigationItem[]> {
  try {
    const filter: any = { status: { _eq: 'published' } };

    if (location) {
      filter._or = [
        { location: { _eq: location } },
        { location: { _eq: 'both' } }
      ];
    }

    const items = await client.request(
      readItems('navigation_items', {
        filter,
        fields: ['*', 'page_id.slug', 'page_id.title'],
        sort: ['sort'],
      })
    );

    const navItems = (items as any[]).map(item => ({
      ...item,
      page: item.page_id ? { slug: item.page_id.slug, title: item.page_id.title } : null,
      page_id: item.page_id?.id || item.page_id
    }));

    const rootItems = navItems.filter(item => !item.parent_id);
    const childItems = navItems.filter(item => item.parent_id);

    rootItems.forEach(root => {
      root.children = childItems.filter(child => child.parent_id === root.id);
    });

    return rootItems;
  } catch (error) {
    console.error('Error fetching navigation items:', error);
    return [];
  }
}

export function getAssetUrl(fileId: string | null): string | null {
  if (!fileId) return null;
  return `${PUBLIC_DIRECTUS_URL}/assets/${fileId}`;
}

// ===== ARTICLES =====
export async function getArticles(status: string = 'published') {
  try {
    const response = await client.request(
      readItems('articles', {
        filter: { status: { _eq: status } },
        sort: ['-published_date'],
        fields: ['*', 'category.*', 'featured_image.*', 'image_2.*', 'image_3.*', 'image_4.*'],
      })
    );
    return response;
  } catch (error) {
    console.error('Error fetching articles:', error);
    return [];
  }
}

export async function getArticleBySlug(slug: string) {
  try {
    const response = await client.request(
      readItems('articles', {
        filter: { slug: { _eq: slug } },
        fields: ['*', 'category.*', 'featured_image.*', 'image_2.*', 'image_3.*', 'image_4.*'],
        limit: 1,
      })
    );
    return response[0] || null;
  } catch (error) {
    console.error('Error fetching article:', error);
    return null;
  }
}

export async function getCategories() {
  try {
    const response = await client.request(
      readItems('categories', {
        sort: ['name'],
      })
    );
    return response;
  } catch (error) {
    console.error('Error fetching categories:', error);
    return [];
  }
}

export async function getSimilarArticles(categoryId: number, excludeId: number, limit: number = 4) {
  try {
    const response = await client.request(
      readItems('articles', {
        filter: { 
          status: { _eq: 'published' },
          category: { _eq: categoryId },
          id: { _neq: excludeId }
        },
        sort: ['-published_date'],
        fields: ['*', 'category.*', 'featured_image.*', 'image_2.*', 'image_3.*', 'image_4.*'],
        limit: limit,
      })
    );
    return response;
  } catch (error) {
    console.error('Error fetching similar articles:', error);
    return [];
  }
}

// ===== BLOGS =====
export interface Blog {
  id: number;
  status: string;
  title_en: string;
  title_nl: string;
  slug: string;
  featured_image: string | null;
  intro_en: string;
  intro_nl: string;
  content_en: string;
  content_nl: string;
  author_name: string;
  author_role: string;
  category: string;
  show_social_share: boolean;
  published_date: string;
  language: string;
}

export async function getBlogs(status: string = 'published'): Promise<Blog[]> {
  try {
    const response = await client.request(
      readItems('blogs', {
        filter: { status: { _eq: status } },
        sort: ['-published_date'],
        fields: ['*'],
      })
    );
    return response as Blog[];
  } catch (error) {
    console.error('Error fetching blogs:', error);
    return [];
  }
}

export async function getBlogBySlug(slug: string): Promise<Blog | null> {
  try {
    const response = await client.request(
      readItems('blogs', {
        filter: { slug: { _eq: slug } },
        fields: ['*'],
        limit: 1,
      })
    );
    return (response as Blog[])[0] || null;
  } catch (error) {
    console.error('Error fetching blog:', error);
    return null;
  }
}

export async function getSimilarBlogs(category: string, excludeId: number, limit: number = 6): Promise<Blog[]> {
  try {
    const response = await client.request(
      readItems('blogs', {
        filter: { 
          status: { _eq: 'published' },
          category: { _eq: category },
          id: { _neq: excludeId }
        },
        sort: ['-published_date'],
        fields: ['*'],
        limit: limit,
      })
    );
    return response as Blog[];
  } catch (error) {
    console.error('Error fetching similar blogs:', error);
    return [];
  }
}
