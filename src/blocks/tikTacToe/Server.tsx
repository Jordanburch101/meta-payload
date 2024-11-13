// Server.tsx
import { Suspense } from 'react'
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import dynamic from 'next/dynamic'

// Dynamically import the client component with SSR disabled
const TicTacToeClient = dynamic(() => import('./Client'), { 
  ssr: false,
  loading: () => <div>Loading game...</div>
})

export default function TicTacToeServer() {  
    return (
        <div className="mx-auto flex max-w-screen-xl my-24 justify-center">
            <Card>
                <CardHeader>
                    <CardTitle className="text-2xl font-bold text-center">Tic Tac Toe</CardTitle>
                </CardHeader>
                <CardContent>
                    <Suspense fallback={<div>Loading...</div>}>
                        <TicTacToeClient />
                    </Suspense>
                </CardContent>
            </Card>
        </div>
    )
}