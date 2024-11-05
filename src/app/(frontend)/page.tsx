import Page from './[slug]/page'

export const dynamic = 'force-dynamic'

export default async function RootPage() {
  return Page({ params: { slug: 'index' } })
}