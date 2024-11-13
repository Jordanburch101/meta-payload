'use client'

import { usePathname } from 'next/navigation'
import { AdminDock } from './admin-dock'
import type { PayloadAdminBarProps } from 'payload-admin-bar'
import { useEffect, useState } from 'react'

export const CurrentPageAdmin = ({ adminBarProps }: { adminBarProps?: PayloadAdminBarProps }) => {
  const pathname = usePathname()
  const [validSlug, setValidSlug] = useState<string | null>(null)
  
  // console.log('CurrentPageAdmin mounted', { adminBarProps, pathname })

  useEffect(() => {
    const checkPage = async () => {
      const slug = pathname === '/' ? 'home' : pathname
      console.log('Checking page:', slug)
      
      try {
        // Extract the actual slug, handling posts paths
        const cleanSlug = slug.startsWith('/posts/') 
          ? slug.replace('/posts/', '') 
          : slug.slice(1)

        const pageResponse = await fetch(`${process.env.NEXT_PUBLIC_SERVER_URL}/api/pages?where[slug][equals]=${cleanSlug}`)
        const pageData = await pageResponse.json()
        
        const postResponse = await fetch(`${process.env.NEXT_PUBLIC_SERVER_URL}/api/posts?where[slug][equals]=${cleanSlug}`)
        const postData = await postResponse.json()
        
        if (slug === 'home' || (pageData.docs && pageData.docs.length > 0)) {
          setValidSlug(cleanSlug)
        } else if (postData.docs && postData.docs.length > 0) {
          setValidSlug(`posts/${cleanSlug}`)
        } else {
          setValidSlug(null)
        }
      } catch (error) {
        console.error('Error checking page/post:', error)
        setValidSlug(null)
      }
    }

    checkPage()
  }, [pathname])

  return <AdminDock adminBarProps={adminBarProps} slug={validSlug || undefined} />
}