import type { APIRoute } from 'astro';

const DIRECTUS_URL = import.meta.env.DIRECTUS_URL || 'http://localhost:3001';

export const POST: APIRoute = async ({ request }) => {
  try {
    const body = await request.json();
    const { email, source = 'website' } = body;

    if (!email || !email.includes('@')) {
      return new Response(JSON.stringify({ 
        success: false, 
        message: 'Invalid email address' 
      }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    const response = await fetch(`${DIRECTUS_URL}/items/newsletter_subscribers`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        email: email.toLowerCase().trim(),
        status: 'active',
        source,
        subscribed_at: new Date().toISOString()
      })
    });

    if (response.ok || response.status === 204) {
      return new Response(JSON.stringify({ 
        success: true, 
        message: 'Successfully subscribed!' 
      }), {
        status: 200,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    let errorData: any = {};
    try {
      const text = await response.text();
      if (text) {
        errorData = JSON.parse(text);
      }
    } catch (e) {
    }
    
    if (errorData.errors?.[0]?.extensions?.code === 'RECORD_NOT_UNIQUE' ||
        errorData.errors?.[0]?.message?.includes('UNIQUE constraint failed')) {
      return new Response(JSON.stringify({ 
        success: false, 
        message: 'This email is already subscribed' 
      }), {
        status: 409,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    return new Response(JSON.stringify({ 
      success: false, 
      message: 'Subscription failed' 
    }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });

  } catch (error) {
    console.error('Newsletter subscription error:', error);
    return new Response(JSON.stringify({ 
      success: false, 
      message: 'Server error' 
    }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
};
