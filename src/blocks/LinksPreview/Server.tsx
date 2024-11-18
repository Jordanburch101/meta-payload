import { LinkPreviewClient } from "./Client"


export default function LinksPreviewServer({rows}: {rows: any[]}) {  
    return (
        <div className="container mx-auto my-24 flex max-w-screen-xl justify-center">
            <LinkPreviewClient rows={rows} />
        </div>
    )
}