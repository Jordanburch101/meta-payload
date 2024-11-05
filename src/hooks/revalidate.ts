import { CollectionAfterChangeHook, CollectionAfterDeleteHook } from 'payload'

const NEXT_PUBLIC_SERVER_URL = process.env.NEXT_PUBLIC_SERVER_URL || 'http://localhost:3000'

async function revalidateBySlug(slug: string) {
  const res = await fetch(`${NEXT_PUBLIC_SERVER_URL}/api/revalidate?tag=page-${slug}`, {
    method: 'POST',
    headers: {
      'x-payload-verify': process.env.PAYLOAD_SECRET || '',
    },
  })

  if (!res.ok) {
    throw new Error(`Failed to revalidate: ${res.status}`)
  }
}

export const afterChange: CollectionAfterChangeHook = async ({ doc }) => {
  try {
    await revalidateBySlug(doc.slug)
  } catch (err) {
    console.error('Error revalidating after change:', err)
  }
  return doc
}

export const afterDelete: CollectionAfterDeleteHook = async ({ doc }) => {
  try {
    if (doc?.slug) {
      await revalidateBySlug(doc.slug)
    }
  } catch (err) {
    console.error('Error revalidating after delete:', err)
  }
}