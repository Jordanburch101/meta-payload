
import { SpotlightPreview } from "./Client"

export default function SpotlightServer({title, description}: {title: string, description: string}) {  
    return (
        <div className="mx-auto flex justify-center">
            <SpotlightPreview title={title} description={description} />
        </div>
    )
}