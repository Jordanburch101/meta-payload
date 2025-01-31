import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import TikTacToeClient from "./Client"
export default function TikTacToeServer({title}: {title: string}) {  
    return (
        <div className="mx-auto flex max-w-screen-xl my-24 justify-center">
            <Card>
                <CardHeader>
                    <CardTitle className="text-2xl font-bold text-center">Tic Tac Toe</CardTitle>
                </CardHeader>
                <CardContent>
                    <TikTacToeClient />
                </CardContent>
            </Card>
        </div>
    )
}