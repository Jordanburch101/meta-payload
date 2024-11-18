import { withPayload } from '@payloadcms/next/withPayload'

/** @type {import('next').NextConfig} */
const nextConfig = {
  // Your Next.js config here
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'vfmxvvugriytncpzypvm.supabase.co',
        pathname: '/**',
      },
    ],
    domains: [
      "api.microlink.io", // Microlink Image Preview
    ],
  },
}

// Export the configuration without Sentry
export default withPayload(nextConfig);