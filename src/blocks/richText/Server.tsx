import { serializeLexical } from "@/components/RichText/serialize"


export default function RichTextBlockServer({content}: {content: any}) {
    return (
        <div className="max-w-5xl mx-auto my-12">
            <div className="richText">
                {serializeLexical({nodes: content.root.children})}
            </div>
        </div>
    )
}