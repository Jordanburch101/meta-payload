'use client'

import dynamic from 'next/dynamic'
import { Suspense } from 'react'

const TicTacToeClient = dynamic(() => import('./Client'), { 
  ssr: false,
  loading: () => <div>Loading game...</div>
})

export function TicTacToeWrapper() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <TicTacToeClient />
    </Suspense>
  )
} 