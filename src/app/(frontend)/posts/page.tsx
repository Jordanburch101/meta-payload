import type { Metadata } from 'next/types'

import { PageRange } from '@/components/PageRange'
import { Pagination } from '@/components/Pagination'
import configPromise from '@payload-config'
import { getPayload } from 'payload'
import React from 'react'
import { FocusCards } from '@/components/ui/focus-cards'

export const dynamic = 'force-static'
export const revalidate = 600

export default async function Page() {
  const payload = await getPayload({ config: configPromise })

  const posts = await payload.find({
    collection: 'posts',
    depth: 1,
    limit: 12,
    overrideAccess: false,
  })


  return (
    <div className="pt-24 pb-24">

      <div className="container mb-16">
        <div className="prose dark:prose-invert max-w-none">
          <h1 className="text-center text-4xl md:text-6xl font-bold">Posts</h1>
        </div>
      </div>

      <div className="container text-center mb-8">
        <PageRange
          collection="posts"
          currentPage={posts.page}
          limit={12}
          totalDocs={posts.totalDocs}
        />
      </div>

      <FocusCards
        cards={posts.docs.map((post) => ({
          title: post.title,
          // @ts-ignore
          src: post.meta?.image?.url || '/https://vfmxvvugriytncpzypvm.supabase.co/storage/v1/object/public/meta-payload-main-bucket/block-thumbnails/image-block.png',
          href: `/posts/${post.slug}`,
        }))}
      />

      <div className="container">
        {posts.totalPages > 1 && posts.page && (
          <Pagination page={posts.page} totalPages={posts.totalPages} />
        )}
      </div>
    </div>
  )
}

export function generateMetadata(): Metadata {
  return {
    title: `Payload Website Template Posts`,
  }
}
