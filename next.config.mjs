import {withSentryConfig} from '@sentry/nextjs';
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

export default withSentryConfig(withPayload(nextConfig), {
// For all available options, see:
// https://github.com/getsentry/sentry-webpack-plugin#options

org: "mythic-xr",
project: "meta-payload",

// Only print logs for uploading source maps in CI
silent: !process.env.CI,

// For all available options, see:
// https://docs.sentry.io/platforms/javascript/guides/nextjs/manual-setup/

// Upload a larger set of source maps for prettier stack traces (increases build time)
widenClientFileUpload: true,

// Automatically annotate React components to show their full name in breadcrumbs and session replay
reactComponentAnnotation: {
enabled: true,
},

// Commenting out tunnelRoute to prevent loops on 404 pages
// tunnelRoute: "/monitoring",

// Hides source maps from generated client bundles
hideSourceMaps: true,

// Automatically tree-shake Sentry logger statements to reduce bundle size
disableLogger: true,

// Enables automatic instrumentation of Vercel Cron Monitors. (Does not yet work with App Router route handlers.)
// See the following for more information:
// https://docs.sentry.io/product/crons/
// https://vercel.com/docs/cron-jobs
automaticVercelMonitors: true,

// Add these configurations:
ignoreErrors: [
  // Add any error patterns you want to ignore
  'ResizeObserver loop',
  'network error',
],

// Disable Sentry during 404 responses
ignoreTransactions: [
  // Ignore transactions for 404 pages
  (ctx) => ctx.request?.url?.includes('404') || false,
],

// Set a lower sample rate for monitoring
tracesSampleRate: 0.1,

// Disable automatic instrumentation for certain features
automaticVercelMonitors: false,

// Ensure this is false in production
debug: false,
});