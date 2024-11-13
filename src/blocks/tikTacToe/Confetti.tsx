// components/Confetti.tsx
'use client'

import { useCallback } from 'react'

let confetti: any = null

if (typeof window !== 'undefined') {
  confetti = require('canvas-confetti').default
}

export function useConfetti() {
  const trigger = useCallback(() => {
    if (!confetti) return

    const count = 200
    const defaults = {
      origin: { y: 0.7 }
    }

    function fire(particleRatio: number, opts: any) {
      confetti({
        ...defaults,
        ...opts,
        particleCount: Math.floor(count * particleRatio)
      })
    }

    fire(0.25, {
      spread: 26,
      startVelocity: 55,
    })

    fire(0.2, {
      spread: 60,
    })

    fire(0.35, {
      spread: 100,
      decay: 0.91,
      scalar: 0.8
    })

    fire(0.1, {
      spread: 120,
      startVelocity: 25,
      decay: 0.92,
      scalar: 1.2
    })

    fire(0.1, {
      spread: 120,
      startVelocity: 45,
    })

    // Slower, sustained shower of confetti
    setTimeout(() => {
      const slowConfettiInterval = setInterval(() => {
        confetti({
          particleCount: 2,
          angle: 60,
          spread: 55,
          origin: { x: 0 },
          colors: ['#ff0000', '#00ff00', '#0000ff']
        })
        confetti({
          particleCount: 2,
          angle: 120,
          spread: 55,
          origin: { x: 1 },
          colors: ['#ff0000', '#00ff00', '#0000ff']
        })
      }, 150)

      // Stop the slower confetti after 3 seconds
      setTimeout(() => clearInterval(slowConfettiInterval), 3000)
    }, 1000)
  }, [])

  return { trigger }
}