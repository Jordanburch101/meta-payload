import Page from './[slug]/page'

export default async function RootPage() {
  return Page({ params: { slug: 'index' } })
}