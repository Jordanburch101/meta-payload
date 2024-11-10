import PageTemplate, { generateMetadata } from './[slug]/page'

// Enable caching with revalidation every hour
export const revalidate = 3600


export default PageTemplate

export { generateMetadata }
