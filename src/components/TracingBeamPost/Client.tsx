"use client"

import { TracingBeam } from '@/components/ui/tracing-beam'
import RichText from '@/components/RichText'
import { Post } from '@/payload-types'

export default function TracingBeamPost({ post }: { post: Post }) {
  return (
    <TracingBeam className="px-6">
      <div className="lg:mx-0 lg:grid lg:grid-cols-[1fr_48rem_1fr] grid-rows-[1fr]">
        <RichText
          className="lg:grid lg:grid-cols-subgrid col-start-1 col-span-3 grid-rows-[1fr]"
          content={post.content}
          enableGutter={false}
        />
      </div>
    </TracingBeam>
  )
}
