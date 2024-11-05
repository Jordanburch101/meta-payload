import { CollectionConfig } from "payload";

export const revalidateWebhook: CollectionConfig['hooks'] = {
  afterChange: [
    async ({ doc }) => {
      try {
        const slug = doc.slug || 'index'
        const secret = process.env.REVALIDATION_TOKEN // Add this to your .env
        
        // Revalidate the specific page
        await fetch(`${process.env.NEXT_PUBLIC_SERVER_URL}/api/revalidate?tag=page-${slug}&secret=${secret}`)
        
        // Revalidate the pages collection
        await fetch(`${process.env.NEXT_PUBLIC_SERVER_URL}/api/revalidate?tag=pages&secret=${secret}`)
      } catch (err) {
        console.error('Error revalidating:', err)
      }
    },
  ],
} 