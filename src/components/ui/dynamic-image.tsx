import Image from 'next/image'

import { cn } from '@/lib/utils'
import { getImage } from '@/lib/getImage'

export default async function DynamicImage({
  url,
  alt,
  containerClass
}: {
  url: string
  alt?: string
  containerClass?: string
}) {
  const { base64, img } = await getImage(url)

  return (
    <>
      <Image
        className={cn('relative', containerClass)}
        {...img}
        alt={alt || ''}
        placeholder='blur'
        blurDataURL={base64}
      />
    </>
  )
}