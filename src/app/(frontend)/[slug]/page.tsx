import type { Metadata } from 'next'

import config from '@payload-config'
import { getPayloadHMR } from '@payloadcms/next/utilities'
import React, { cache } from 'react'

import type { Page as PageType } from '../../../payload-types'

import { notFound } from 'next/navigation'
import { RenderBlocks } from '@/utils/RenderBlocks'
import { revalidateTag } from 'next/dist/server/web/spec-extension/revalidate'

export const revalidate = 3600 // Cache for 1 hour, adjust as needed

const queryPageBySlug = cache(async ({ slug }: { slug: string }) => {

    const parsedSlug = decodeURIComponent(slug)
  
    const payload = await getPayloadHMR({ config })
  
    const result = await payload.find({
      collection: 'pages',
      limit: 1,
      where: {
        slug: {
          equals: parsedSlug,
        },
      },
    })
  
    revalidateTag(`page-${parsedSlug}`)
    revalidateTag('pages')
  
    return result.docs?.[0] || null
  })


export async function generateStaticParams() {
  const payload = await getPayloadHMR({ config })
  const pages = await payload.find({
    collection: 'pages',
    draft: false,
    limit: 1000,
  })

  return pages.docs
    ?.filter((doc): doc is PageType => {
      return doc?.slug !== undefined && doc.slug !== 'index'
    })
    .map(({ slug }) => ({ slug }))
}

export default async function Page({
  params: { slug = 'index' },
}: {
  params: { slug?: string }
}) {
  let page: PageType | null

  page = await queryPageBySlug({
    slug,
  })

  if (!page) {
    return notFound()
  }

  return (
    <div className="pt-16 pb-24">

      <RenderBlocks blocks={page.layout} />
    </div>
  )
}


