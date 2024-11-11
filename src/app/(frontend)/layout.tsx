import './global.css'
import { SpeedInsights } from '@vercel/speed-insights/next';
import { CSPostHogProvider } from '@/utils/analytics/providers'
import HeaderServer from '@/blocks/global/Header/Server'
import FooterServer from '@/blocks/global/Footer/Server'
import { LivePreviewListener } from '@/components/LivePreviewListener';
import { draftMode } from 'next/headers';

// Add metadata export
export const metadata = {
  icons: {
    icon: '/favicon.ico', // Place your favicon.ico in the public folder
  },
}

export default async function RootLayout({children,}: {children: React.ReactNode}) {
  // const { isEnabled } = await draftMode()

    return (
      <CSPostHogProvider>
      <html lang="en">
          <body className="flex flex-col h-screen justify-between dark">
            <LivePreviewListener />
            <HeaderServer />
            {/* Layout UI */}
            <main className="mb-auto">{children}</main>
            <SpeedInsights />
            <FooterServer />
          </body>
        </html>
      </CSPostHogProvider>
    )
  }