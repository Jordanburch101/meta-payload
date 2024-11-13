
import { TextHoverEffect } from "@/components/ui/text-hover-effect";

export default function TextEffectServer({text}: {text: string}) {  
    return (
        <div className="mx-auto flex justify-center">
            <TextHoverEffect text={text} />
        </div>
    )
}