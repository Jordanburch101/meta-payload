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

  const redirects = await getCachedRedirects()()

  if (!redirects?.length) {
    if (disableNotFound) return null
    notFound()
  }

  const redirectItem = redirects.find((redirect) => redirect.from === slug)

  if (!redirectItem) {
    if (disableNotFound) return null
    notFound()
  }

  if (redirectItem.to?.url) {
    if (redirectItem.to.url !== url) {
      redirect(redirectItem.to.url)
    }
  }

  let redirectUrl: string

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

  if (redirectUrl) redirect(redirectUrl)

  if (disableNotFound) return null

  notFound()
}