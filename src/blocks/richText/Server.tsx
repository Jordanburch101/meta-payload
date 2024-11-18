import { serializeLexical } from "@/components/RichText/serialize"


export default function RichTextBlockServer({content}: {content: any}) {
    return (
        <div className="max-w-5xl mx-auto my-12 prose prose-invert">
            {serializeLexical({nodes: content.root.children})}
        </div>
    )
}