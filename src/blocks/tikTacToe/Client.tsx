'use client'
import { useState, useEffect, useCallback } from 'react'
import { Button } from "@/components/ui/button"
import { motion, AnimatePresence } from "framer-motion"
import confetti from 'canvas-confetti'
type Player = 'X' | 'O' | null
export default function TicTacToe() {
  const [board, setBoard] = useState<Player[]>(Array(9).fill(null))
  const [currentPlayer, setCurrentPlayer] = useState<'X' | 'O'>('X')
  const [winner, setWinner] = useState<Player>(null)
  const [winningLine, setWinningLine] = useState<number[] | null>(null)
  const checkWinner = (squares: Player[]): [Player, number[] | null] => {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ]
    for (let i = 0; i < lines.length; i++) {
      const [a, b, c] = lines[i]
      if (squares[a] && squares[a] === squares[b] && squares[a] === squares[c]) {
        return [squares[a], lines[i]]
      }
    }
    return [null, null]
  }
  const handleClick = (index: number) => {
    if (board[index] || winner) return
    const newBoard = [...board]
    newBoard[index] = currentPlayer
    setBoard(newBoard)
    const [newWinner, newWinningLine] = checkWinner(newBoard)
    if (newWinner) {
      setWinner(newWinner)
      setWinningLine(newWinningLine)
      triggerWinAnimation()
    } else {
      setCurrentPlayer(currentPlayer === 'X' ? 'O' : 'X')
    }
  }
  const resetGame = () => {
    setBoard(Array(9).fill(null))
    setCurrentPlayer('X')
    setWinner(null)
    setWinningLine(null)
  }
  const triggerWinAnimation = useCallback(() => {
    // Initial burst of confetti
    const count = 200
    const defaults = {
      origin: { y: 0.7 }
    }
    function fire(particleRatio: number, opts: confetti.Options) {
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
  const getGradientPosition = (index: number) => {
    if (!winningLine) return ''
    const lineStart = Math.min(...winningLine)
    const position = winningLine.indexOf(index)
    const offset = position * 100 / (winningLine.length - 1)
    return `${offset}%`
  }
  const renderSquare = (index: number) => (
    <motion.div
      whileHover={{ scale: 1.1 }}
      whileTap={{ scale: 0.9 }}
      // @ts-ignore
      className="relative"
    >
      <Button
        variant="outline"
        className={`w-20 h-20 text-4xl ${
          winningLine?.includes(index) ? 'bg-purple-200 text-purple-800' : ''
        }`}
        onClick={() => handleClick(index)}
        aria-label={`Square ${index + 1}`}
      >
        <span className="relative z-10">{board[index]}</span>
      </Button>
    </motion.div>
  )
  useEffect(() => {
    if (winner) {
      triggerWinAnimation()
    }
  }, [winner, triggerWinAnimation])
  return (
    <div className="flex flex-col items-center">
      <div className="grid grid-cols-3 gap-2 mb-4" role="grid" aria-label="Tic Tac Toe Board">
        {board.map((_, index) => (
          <div key={index} role="gridcell">
            {renderSquare(index)}
          </div>
        ))}
      </div>
      <AnimatePresence>
        {winner && (
          <motion.div
            initial={{ opacity: 0, y: -50, scale: 0.5 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 50, scale: 0.5 }}
            transition={{ duration: 0.5, type: "spring", stiffness: 100 }}
            // @ts-ignore
            className="relative mb-4 p-4 rounded-lg overflow-hidden"
          >
            <div className="absolute inset-0 bg-gradient-to-r from-purple-400 via-pink-500 to-red-500 animate-gradient-x"></div>
            <motion.div
              // @ts-ignore
              className="relative z-10 text-4xl font-bold text-white text-center"
              animate={{ rotate: [0, -5, 5, -5, 5, 0] }}
              transition={{ duration: 0.5, delay: 0.2 }}
            >
              Winner: {winner}
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>
      {!winner && (
        <div className="text-xl mb-4" aria-live="polite">Next player: {currentPlayer}</div>
      )}
      <Button onClick={resetGame}>Reset Game</Button>
    </div>
  )
}