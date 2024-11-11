'use client'

import { usePathname } from 'next/navigation'
import { AdminBar } from './index'
import type { PayloadAdminBarProps } from 'payload-admin-bar'
import { useEffect, useState } from 'react'

export const CurrentPageAdmin = ({ adminBarProps }: { adminBarProps?: PayloadAdminBarProps }) => {
  const pathname = usePathname()
  const [validSlug, setValidSlug] = useState<string | null>(null)
  
  useEffect(() => {
    const checkPage = async () => {
      const slug = pathname === '/' ? 'home' : pathname.slice(1)
      try {
        const response = await fetch(`${process.env.NEXT_PUBLIC_SERVER_URL}/api/pages?where[slug][equals]=${slug}`)
        const data = await response.json()
        
        // Only set the slug if the page exists
        if (data.docs && data.docs.length > 0) {
          setValidSlug(slug)
        } else {
          setValidSlug(null)
        }
      } catch (error) {
        setValidSlug(null)
      }
    }

    checkPage()
  }, [pathname])

  // Only render AdminBar with slug if the page exists
  return <AdminBar adminBarProps={adminBarProps} slug={validSlug || undefined} />
} 