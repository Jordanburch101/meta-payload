import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { TicTacToeWrapper } from './ClientWrapper'

export default function TicTacToeServer() {  
    return (
        <div className="mx-auto flex max-w-screen-xl my-24 justify-center">
            <Card>
                <CardHeader>
                    <CardTitle className="text-2xl font-bold text-center">Tic Tac Toe</CardTitle>
                </CardHeader>
                <CardContent>
                    <TicTacToeWrapper />
                </CardContent>
            </Card>
        </div>
    )
}