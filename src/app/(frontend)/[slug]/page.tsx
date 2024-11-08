import type { Metadata } from 'next'

import config from '@payload-config'
import { getPayloadHMR } from '@payloadcms/next/utilities'
import React, { cache } from 'react'

import type { Page as PageType } from '../../../payload-types'

import { notFound } from 'next/navigation'
import { RenderBlocks } from '@/utils/RenderBlocks'
import { generateMeta } from '@/utils/generateMeta'

// Enable caching with revalidation every hour
export const revalidate = 3600

export async function generateMetadata({ params: paramsPromise }: { params: { slug: string } }): Promise<Metadata> {
  const { slug = 'home' } = await paramsPromise
  const page = await queryPageBySlug({
    slug,
  })

  return generateMeta({ doc: page })
}

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
  const renderTime = new Date().toISOString()

  page = await queryPageBySlug({
    slug,
  })

  if (!page) {
    return notFound()
  }

  return (
    <div>
      <div className="text-xs text-gray-400 p-2 m-2 bg-gray-100 rounded-md font-mono">
        Rendered at: {renderTime}
      </div>
      <RenderBlocks blocks={page.layout?.layout || []} />
    </div>
  )
}


