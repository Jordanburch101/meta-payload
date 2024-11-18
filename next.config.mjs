// @ts-check
import { withPayload } from '@payloadcms/next/withPayload'
import withPlaiceholder from "@plaiceholder/next";

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

// Export the configuration with Plaiceholder
export default withPlaiceholder(withPayload(nextConfig));