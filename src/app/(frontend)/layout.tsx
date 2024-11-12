import './global.css'
import { SpeedInsights } from '@vercel/speed-insights/next';
import { CSPostHogProvider } from '@/utils/analytics/providers'
import Header from '@/globals/Header/Server'
import Footer from '@/globals/Footer/Server'
import { LivePreviewListener } from '@/components/LivePreviewListener';
import { draftMode } from 'next/headers';
import { CurrentPageAdmin } from '@/components/AdminBar/CurrentPageAdmin'

// Add metadata export
export const metadata = {
  icons: {
    icon: '/favicon.ico', // Place your favicon.ico in the public folder
  },
}

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const { isEnabled } = await draftMode()

  return (
    <CSPostHogProvider>
      <html lang="en" suppressHydrationWarning>
        <body className="flex flex-col h-screen justify-between dark">
          <CurrentPageAdmin
            adminBarProps={{
              preview: isEnabled,
            }}
          />
          <LivePreviewListener />
          <Header />
          {/* Layout UI */}
          <main className="mb-auto">{children}</main>
          <SpeedInsights />
          <Footer />
        </body>
      </html>
    </CSPostHogProvider>
  )
}