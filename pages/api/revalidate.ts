import type { NextApiRequest, NextApiResponse } from 'next'

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  try {
    // Check for secret to confirm this is a valid request
    if (req.query.secret !== process.env.REVALIDATION_TOKEN) {
      return res.status(401).json({ message: 'Invalid token' })
    }

    // Path to revalidate
    const path = req.query.path as string

    await res.revalidate(path)
    return res.json({ revalidated: true })
  } catch (err) {
    return res.status(500).send('Error revalidating')
  }
} 