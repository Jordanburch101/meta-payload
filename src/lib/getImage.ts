import { getPlaiceholder } from 'plaiceholder'

export async function getImage(src: string) {
  // Convert relative URLs to absolute URLs if they start with '/'
  const absoluteUrl = src.startsWith('/') 
    ? `${process.env.NEXT_PUBLIC_SERVER_URL || 'http://localhost:3000'}${src}`
    : src

  const buffer = await fetch(absoluteUrl).then(async res =>
    Buffer.from(await res.arrayBuffer())
  )

  const {
    metadata: { height, width },
    ...plaiceholder
  } = await getPlaiceholder(buffer, { size: 10 })

  return {
    ...plaiceholder,
    img: { src, height, width }
  }
}