import type { Metadata } from 'next'

import config from '@payload-config'
import { getPayloadHMR } from '@payloadcms/next/utilities'
import configPromise from '@payload-config'
import React, { cache } from 'react'

import type { Page as PageType } from '../../../payload-types'

import { notFound } from 'next/navigation'
import { RenderBlocks } from '@/utils/RenderBlocks'
import { generateMeta } from '@/utils/generateMeta'
import { draftMode } from 'next/headers'

// Enable caching with revalidation every hour
export const revalidate = 3600

export async function generateStaticParams() {
  const payload = await getPayloadHMR({ config: configPromise })
  const pages = await payload.find({
    collection: 'pages',
    draft: false,
    limit: 1000,
    overrideAccess: false,
  })

  const params = pages.docs
    ?.filter((doc) => {
      return doc.slug !== 'home'
    })
    .map(({ slug }) => {
      return { slug }
    })

  return params
}

const queryPageBySlug = cache(async ({ slug }: { slug: string }) => {
  const { isEnabled: draft } = await draftMode()

  const payload = await getPayloadHMR({ config: configPromise })

  const result = await payload.find({
    collection: 'pages',
    draft,
    limit: 1,
    overrideAccess: draft,
    where: {
      slug: {
        equals: slug,
      },
    },
  })

  return result.docs?.[0] || null
})

type Args = {
  params: Promise<{
    slug?: string
  }> | {
    slug?: string
  }
}

export default async function Page({ params }: Args) {
  const resolvedParams = 'then' in params ? await params : params
  const { slug = 'home' } = resolvedParams
  
  let page: PageType | null
  page = await queryPageBySlug({
    slug,
  })

  if (!page) {
    notFound()
  }

  return (
    <article className="pt-16 pb-24">
      <RenderBlocks blocks={page.layout?.layout || []} />
    </article>
  )
}

export async function generateMetadata({ params }: Args): Promise<Metadata> {
  const resolvedParams = 'then' in params ? await params : params
  const { slug = 'home' } = resolvedParams
  
  const page = await queryPageBySlug({
    slug,
  })

  return generateMeta({ doc: page })
}


