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
  try {
    const slug = url.startsWith('/') ? url : `${url}`

    let redirects
    try {
      redirects = await getCachedRedirects()()
    } catch (err) {
      console.error('Error fetching redirects:', err)
      if (disableNotFound) return null
      notFound()
    }

    if (!redirects?.length) {
      if (disableNotFound) return null
      return null // Don't call notFound() here, let the parent handle it
    }

    const redirectItem = redirects.find((redirect) => redirect.from === slug)

    if (!redirectItem) {
      if (disableNotFound) return null
      return null // Don't call notFound() here, let the parent handle it
    }

    // Handle direct URL redirects
    if (redirectItem.to?.url) {
      if (redirectItem.to.url !== url) {
        redirect(redirectItem.to.url)
      }
      return null
    }

    // Handle reference-based redirects
    try {
      let redirectUrl: string | undefined

      if (typeof redirectItem.to?.reference?.value === 'string') {
        const collection = redirectItem.to?.reference?.relationTo
        const id = redirectItem.to?.reference?.value

        const document = (await getCachedDocument(collection, id)()) as Page 
        redirectUrl = `${redirectItem.to?.reference?.relationTo !== 'pages' ? `/${redirectItem.to?.reference?.relationTo}` : ''}/${
          document?.slug
        }`
      } else {
        redirectUrl = `${redirectItem.to?.reference?.relationTo !== 'pages' ? `/${redirectItem.to?.reference?.relationTo}` : ''}/${
          typeof redirectItem.to?.reference?.value === 'object'
            ? redirectItem.to?.reference?.value?.slug
            : ''
        }`
      }

      if (redirectUrl && redirectUrl !== url) {
        redirect(redirectUrl)
      }
    } catch (err) {
      console.error('Error processing redirect:', err)
      if (disableNotFound) return null
      notFound()
    }

    return null
  } catch (err) {
    console.error('PayloadRedirects error:', err)
    if (disableNotFound) return null
    notFound()
  }
}
