import type React from 'react'
import type { Page } from '@/payload-types'

import { getCachedDocument } from '@/utils/getDocument'
import { getCachedRedirects } from '@/utils/getRedirects'
import { notFound, redirect } from 'next/navigation'

interface Props {
  disableNotFound?: boolean
  url: string
}

/* This component helps us with SSR based dynamic redirects */
export const PayloadRedirects: React.FC<Props> = async ({ disableNotFound, url }) => {
  const slug = url.startsWith('/') ? url : `${url}`

  console.log('🔄 PayloadRedirects checking:', {
    url,
    slug,
    disableNotFound
  })

  const redirects = await getCachedRedirects()()
  
  if (!redirects?.length) {
    console.log('❌ No redirects found in system')
    if (disableNotFound) return null
    notFound()
  }

  const redirectItem = redirects.find((redirect) => redirect.from === slug)
  
  console.log('🔍 Redirect check:', {
    found: !!redirectItem,
    from: redirectItem?.from,
    to: redirectItem?.to
  })

  // Early return if no redirect found
  if (!redirectItem) {
    console.log('❌ No matching redirect found for:', slug)
    if (disableNotFound) return null
    notFound()
  }

  // Early return if no 'to' destination
  if (!redirectItem.to) {
    console.log('❌ Redirect found but no destination specified for:', slug)
    if (disableNotFound) return null
    notFound()
  }

  // Handle URL redirect
  if (redirectItem.to?.url) {
    console.log('➡️ Redirecting to URL:', redirectItem.to.url)
    redirect(redirectItem.to.url)
  }

  // Handle reference redirect
  let redirectUrl: string | null = null

  if (typeof redirectItem.to?.reference?.value === 'string') {
    const collection = redirectItem.to?.reference?.relationTo
    const id = redirectItem.to?.reference?.value

    console.log('🔄 Fetching referenced document:', { collection, id })
    const document = (await getCachedDocument(collection, id)()) as Page 
    
    if (!document) {
      console.log('❌ Referenced document not found')
      if (disableNotFound) return null
      notFound()
    }

    redirectUrl = `${redirectItem.to?.reference?.relationTo !== 'pages' ? `/${redirectItem.to?.reference?.relationTo}` : ''}/${
      document.slug
    }`
  } else {
    redirectUrl = `${redirectItem.to?.reference?.relationTo !== 'pages' ? `/${redirectItem.to?.reference?.relationTo}` : ''}/${
      typeof redirectItem.to?.reference?.value === 'object'
        ? redirectItem.to?.reference?.value?.slug
        : ''
    }`
  }

  if (redirectUrl) {
    console.log('➡️ Redirecting to:', redirectUrl)
    redirect(redirectUrl)
  }

  console.log('❌ No valid redirect found and reached end of component')
  if (disableNotFound) return null
  notFound()
}
