import Page from './[slug]/page'

// Enable caching with revalidation every hour
export const revalidate = 3600

export default async function RootPage() {
  return Page({ params: { slug: 'home' } })
}
