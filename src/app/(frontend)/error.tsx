'use client'

import { useEffect } from 'react'
import { Button } from '@/components/ui/button'

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  useEffect(() => {
    // Log to your error reporting service
    console.error('💥 Error boundary caught:', {
      message: error.message,
      stack: error.stack,
      digest: error.digest,
      timestamp: new Date().toISOString()
    })
  }, [error])

  return (
    <div className="container mx-auto py-28">
      <div className="prose max-w-none">
        <h2>Something went wrong!</h2>
        <Button
          onClick={reset}
          variant="default"
        >
          Try again
        </Button>
      </div>
    </div>
  )
}