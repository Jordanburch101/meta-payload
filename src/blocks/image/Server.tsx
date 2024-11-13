import Image from "next/image"

export default function ImageBlockServer({image}: {image : {url: string, alt: string}}) {  
    return (
        <div className="max-w-5xl mx-auto flex justify-center">
            <Image src={image.url} placeholder="blur" alt={image.alt} width={500} height={500} />
        </div>
    )
}