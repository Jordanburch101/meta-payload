import { CollectionAfterChangeHook } from 'payload'
import { revalidatePath } from 'next/cache'

export const revalidateNextCache: CollectionAfterChangeHook = async ({
  doc,
  collection,
}) => {
  // Revalidate the specific page
  if (collection.slug === 'pages' && doc.slug) {
    revalidatePath(`/${doc.slug}`)
  }
  
  // Also revalidate the homepage if the slug is 'index'
  if (doc.slug === 'index') {
    revalidatePath('/')
  }

  return doc
} 