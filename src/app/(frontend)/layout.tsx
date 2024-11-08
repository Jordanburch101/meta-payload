import './globals.css'
import { SpeedInsights } from '@vercel/speed-insights/next';
import HeaderServer from '@/blocks/global/Header/Server'
import FooterServer from '@/blocks/global/Footer/Server'




export default function RootLayout({
    children,
  }: {
    children: React.ReactNode
  }) {
    return (
      <html lang="en">
        <body className="flex flex-col h-screen justify-between dark">
          <HeaderServer />
          {/* Layout UI */}
          <main className="mb-auto">{children}</main>
          <SpeedInsights />
          <FooterServer />
        </body>
      </html>
    )
  }