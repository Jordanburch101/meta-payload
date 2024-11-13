import { InfiniteMovingCardsClient } from "./Client"

type Card = {
    quote: string
    name: string
    title: string
}

export default function InfiniteMovingCardsServer({cards}: {cards: Card[]}) {  
    return (
        <div className="container mx-auto my-24 flex max-w-screen-xl justify-center">
            <InfiniteMovingCardsClient cards={cards} />
        </div>
    )
}