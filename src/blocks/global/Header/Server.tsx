import { getPayloadHMR } from "@payloadcms/next/utilities"
import config from "@/payload.config"
import Image from "next/image"
import Link from "next/link"

// Add these types
type HeaderType = {
  logo: {
    url: string
    alt: string
    width: number
    height: number
  }
  links: Array<{
    url: string
    label: string
  }>
}

export default async function Header() {
    const payload = await getPayloadHMR({config})
    // Add type assertion here
    const header = await payload.findGlobal({
        slug: 'header',
    }) as HeaderType
    return (
        <section className="bg-slate-900 px-4">
            <div className="flex items-center w-full h-32 gap-11">
                <div className="w-64 h-32 flex items-center justify-center">
                    <Image src={header.logo.url} alt={header.logo.alt} width={header.logo.width} height={header.logo.height} className="object-contain" />
                </div>
                <nav className="flex items-center gap-4">
                    {header.links.map((link) => (
                        <Link className="text-white" key={link.url} href={link.url || '#'}>{link.label}</Link>
                    ))}
                </nav>
            </div>
        </section>
    )
}