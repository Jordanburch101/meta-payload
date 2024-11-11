import type { Metadata } from 'next'

import { getPayloadHMR } from '@payloadcms/next/utilities'
import configPromise from '@payload-config'
import React, { cache, Fragment } from 'react'

import type { Page as PageType } from '../../../payload-types'

import { RenderBlocks } from '@/utils/RenderBlocks'
import { generateMeta } from '@/utils/generateMeta'
import { draftMode } from 'next/headers'
import { PayloadRedirects } from '@/components/PayloadRedirects'
import { notFound } from 'next/navigation'

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
  }>
}

export default async function Page({ params: paramsPromise }: Args) {
  try {
    const { slug = 'home' } = await paramsPromise
    const url = '/' + slug
    
    let page: PageType | null = null

    try {
      page = await queryPageBySlug({
        slug,
      })
    } catch (err) {
      console.error('Error fetching page:', err)
      notFound()
    }

    if (!page) {
      notFound()
    }

    return (
      <Fragment>
        <PayloadRedirects disableNotFound url={url} />
        <RenderBlocks blocks={page.layout?.layout || []} />
      </Fragment>
    )
  } catch (err) {
    console.error('Page render error:', err)
    notFound()
  }
}

export async function generateMetadata({ params: paramsPromise }: Args): Promise<Metadata> {
  const { slug = 'home' } = await paramsPromise
  const page = await queryPageBySlug({
    slug,
  })

  return generateMeta({ doc: page })
}
