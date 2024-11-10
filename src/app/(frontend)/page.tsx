import PageTemplate, { generateMetadata } from './[slug]/page'

type PageProps = {
  params?: { [key: string]: string | string[] }
  searchParams?: { [key: string]: string | string[] }
}

// Enable caching with revalidation every hour
export const revalidate = 3600

// Create a wrapper component to handle the home page case
export default async function HomePage(props: PageProps) {
  return PageTemplate({
    ...props,
    params: {
      slug: 'home'
    }
  })
}

export { generateMetadata }
