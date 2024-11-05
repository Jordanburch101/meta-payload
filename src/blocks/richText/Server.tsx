import { serializeLexical } from "@/utils/serialize"

export default function RichTextBlockServer({content}: {content: any}) {
    return (
        <div className="max-w-5xl mx-auto text-center">
            <div className="richText">
                {serializeLexical({nodes: content.root.children})}
            </div>
        </div>
    )
}