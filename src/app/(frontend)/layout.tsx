import './globals.css'
import { SpeedInsights } from '@vercel/speed-insights/next';
import { CSPostHogProvider } from '@/app/_analytics/providers'
import HeaderServer from '@/blocks/global/Header/Server'
import FooterServer from '@/blocks/global/Footer/Server'

// Add metadata export
export const metadata = {
  icons: {
    icon: '/favicon.ico', // Place your favicon.ico in the public folder
  },
}

export default function RootLayout({
    children,
  }: {
    children: React.ReactNode
  }) {
    return (
      <CSPostHogProvider>
      <html lang="en">
          <body className="flex flex-col h-screen justify-between dark">
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