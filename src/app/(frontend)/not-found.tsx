import Link from 'next/link'
import React from 'react'
import { Button } from '@/components/ui/button'

export default function NotFound() {
  return (
    <div className="container mx-auto py-28">
      <div className="prose max-w-none">
        <h1 className="m-0">404</h1>
        <p className="mb-4">This page could not be found.</p>
      </div>
      <Button asChild variant="default">
        <Link href="/">Return Home</Link>
      </Button>
    </div>
  )
} 