import { HeroHighlightDemo } from "./Client"

export default function HeroHighlightServer({title, highlight}: {title: string, highlight: string}) {  
    return (
        <div className="mx-auto flex justify-center">
            <HeroHighlightDemo title={title} highlight={highlight} />
        </div>
    )
}