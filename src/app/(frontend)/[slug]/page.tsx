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

  // Ensure we're returning an array of objects with string values
  return (pages.docs || [])
    .filter((doc) => doc.slug !== 'home')
    .map((doc) => ({
      slug: String(doc.slug), // Ensure slug is a string
    }))
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

export async function generateMetadata({ params: paramsPromise }: { params: { slug: string } }): Promise<Metadata> {
  const { slug = 'home' } = await paramsPromise
  const page = await queryPageBySlug({
    slug,
  })

  return generateMeta({ doc: page })
}

type Args = {
  params: Promise<{
    slug?: string
  }>
}

export default async function Page({ params: paramsPromise }: Args) {
  const { slug = 'home' } = await paramsPromise
  const url = '/' + slug
  const { isEnabled: isDraft } = await draftMode()
  let page: PageType | null

  page = await queryPageBySlug({
    slug,
  })


  if (!page) {
    // return <PayloadRedirects url={url} />
    notFound()
  }

  const { layout } = page

  return (
    <article className="pt-16 pb-24">
      {/* <PageClient /> */}
      {/* Allows redirects for valid pages too */}
      {/* <PayloadRedirects disableNotFound url={url} /> */}
      <RenderBlocks blocks={page.layout?.layout || []} />
    </article>
  )
}


