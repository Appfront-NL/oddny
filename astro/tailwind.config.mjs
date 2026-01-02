/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
  // Disable preflight to avoid breaking existing styles
  corePlugins: {
    preflight: false,
  },
  theme: {
    extend: {
      // Appfront brand colors
      colors: {
        'appfront': {
          'dark-teal': '#06232a',
          'green': '#00d195',
          'purple': '#efbbff',
          'light': '#f7f9f5',
          'gray': '#edeeee',
        },
      },
      fontFamily: {
        'geist': ['Geist', 'sans-serif'],
      },
    },
  },
  plugins: [],
}
