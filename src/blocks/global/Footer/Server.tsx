import { getPayloadHMR } from "@payloadcms/next/utilities"
import config from "@/payload.config"
import Image from "next/image"
import Link from "next/link"

export default async function FooterServer() {
    const payload = await getPayloadHMR({config})
    const footer = await payload.findGlobal({
        slug: 'footer',
    })
    return (
        <section className="bg-slate-900 mt-auto px-4">
            <div className="flex items-center w-full h-32 gap-11">
                <div className="w-64 h-32 flex flex-col items-center justify-center">
                    <Image src={footer.logo.url} alt={footer.logo.alt} width={footer.logo.width} height={footer.logo.height} className="object-contain" />
                    <div className="text-white">
                        {footer.copyright}
                    </div>
                </div>
                <nav>
                    {footer.links.map((link) => (
                        <Link className="text-white" key={link.url} href={link.url || '#'}>{link.label}</Link>
                    ))}
                </nav>
            </div>
        </section>
    )
}