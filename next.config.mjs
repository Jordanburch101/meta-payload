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
  },
}

export default withPayload(nextConfig)
