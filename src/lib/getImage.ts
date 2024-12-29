import { getPlaiceholder } from 'plaiceholder'

export async function getImage(src: string) {
  // Convert relative URL to absolute URL if needed
  const imageUrl = src.startsWith('http') ? src : `${process.env.NEXT_PUBLIC_SERVER_URL}${src}`

  const buffer = await fetch(imageUrl).then(async res =>
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