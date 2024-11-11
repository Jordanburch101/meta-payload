'use client'

import Link from 'next/link'
 
export default function NotFound() {
  return (
    <div className="min-h-screen flex items-center justify-center">
      <div className="text-center space-y-4">
        <h2 className="text-4xl font-bold">404: Not Found</h2>
        <p className="text-gray-600">Sorry, we couldn&apos;t find what you&apos;re looking for.</p>
        <Link 
          href="/" 
          className="inline-block px-6 py-2 text-white bg-blue-600 rounded-lg hover:bg-blue-700 transition-colors"
          replace
        >
          Return Home
        </Link>
      </div>
    </div>
  )
}