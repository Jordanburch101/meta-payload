import type { CollectionAfterChangeHook } from 'payload'

export const afterChangeHook: CollectionAfterChangeHook = async ({
  doc,
  req,
}) => {
  try {
    // Get the base URL from environment variable or fallback to localhost
    const baseURL = process.env.NEXT_PUBLIC_SERVER_URL || 'http://localhost:3000'

    // Revalidate the specific page and the index
    await Promise.all([
      fetch(`${baseURL}/api/revalidate?path=/`),
      fetch(`${baseURL}/api/revalidate?secret=${process.env.REVALIDATION_TOKEN}&path=/${doc.slug}`)
    ])

    console.log(`Revalidated paths: / and /${doc.slug}`)
  } catch (err) {
    console.error('Error revalidating:', err)
  }

  return doc
}