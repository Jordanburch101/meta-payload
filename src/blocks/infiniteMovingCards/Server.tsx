import { InfiniteMovingCardsClient } from "./Client"

type Card = {
    quote: string
    name: string
    title: string
}

export default function InfiniteMovingCardsServer({cards}: {cards: Card[]}) {  
    return (
        <div className="container mx-auto flex max-w-screen-xl justify-center">
            <InfiniteMovingCardsClient cards={cards} />
        </div>
    )
}