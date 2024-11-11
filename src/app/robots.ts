import type { MetadataRoute } from 'next'

/**
 * Robots.txt configuration for Next.js
 * 
 * This file controls how search engines and other web robots crawl your site.
 * 
 * To make your site private/non-indexed:
 * - Use the "private" configuration below
 * - This will block all search engines from indexing any page
 * 
 * To make your site public:
 * - Use the "public" configuration
 * - Ensure NEXT_PUBLIC_SERVER_URL environment variable is set

 * @returns {MetadataRoute.Robots} Robots configuration object
 */
export default function robots(): MetadataRoute.Robots {
  // PRIVATE CONFIGURATION - Blocks all search engines
  return {
    rules: {
      userAgent: '*',
      disallow: '/',  // Blocks all paths
    },
  }

  // PUBLIC CONFIGURATION - Allows search engines with some restrictions
  // Uncomment the following and comment out the above to make public:
  /*
  return {
    rules: {
      userAgent: '*',
      allow: '/',
      disallow: [
        '/api/',       // Protect API routes
        '/admin/',     // Protect admin pages
        '/private/',   // Protect private content
      ],
    },
    sitemap: `${process.env.NEXT_PUBLIC_SERVER_URL}/sitemap.xml`,
  }
  */
}