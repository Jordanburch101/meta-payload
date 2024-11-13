
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import TikTacToeClient from "./Client"
import { Suspense } from "react"

export default function TikTacToeServer() {  
    return (
        <div className="mx-auto flex max-w-screen-xl my-24 justify-center">
            <Card>
                <CardHeader>
                    <CardTitle className="text-2xl font-bold text-center">Tic Tac Toe</CardTitle>
                </CardHeader>
                <CardContent>
                    <Suspense fallback={<div>Loading...</div>}>
                        <TikTacToeClient />
                    </Suspense>
                </CardContent>
            </Card>
        </div>
    )
}