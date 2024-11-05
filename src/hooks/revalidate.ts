import type { CollectionAfterChangeHook } from 'payload'

export const afterChangeHook: CollectionAfterChangeHook = async ({
  doc,
}) => {
  try {
    const baseURL = process.env.NEXT_PUBLIC_SITE_URL || 'http://localhost:3000'
    
    // Revalidate using the new tag-based approach
    await fetch(`${baseURL}/api/revalidate?tag=pages-${doc.slug}`)
    
    console.log(`Revalidated tag: pages-${doc.slug}`)
  } catch (err) {
    console.error('Error revalidating:', err)
  }

  return doc
}