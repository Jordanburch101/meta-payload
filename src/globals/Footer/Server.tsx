import { getPayloadHMR } from "@payloadcms/next/utilities"
import config from "@/payload.config"
import Image from "next/image"
import Link from "next/link"
import { CMSLink } from "@/components/Link"

// Add these types
type FooterType = {
    logo: {
      url: string
      alt: string
      width: number
      height: number
    }
    links: Array<{
      id: string
      link: {
        url?: string
        label: string
        [key: string]: any // for additional CMSLink props
      }
      children?: Array<{
        link: {
          url?: string
          label: string
          [key: string]: any // for additional CMSLink props
        }
      }>
    }>
    copyright: string
}

export default async function Footer() {
    const payload = await getPayloadHMR({config})
    const footer = await payload.findGlobal({
        slug: 'footer',
    }) as FooterType
    return (
        <section className="bg-slate-900 mt-auto px-4">
            <div className="flex items-center w-full h-32 gap-11">
                <div className="w-64 h-32 flex flex-col items-center justify-center">
                    <Image src={footer.logo.url} alt={footer.logo.alt} width={footer.logo.width} height={footer.logo.height} className="object-contain" />
                    <div className="text-white">
                        {footer.copyright}
                    </div>
                </div>
                <nav className="flex items-center gap-4">
                    {footer.links.map((link) => (
                        <div key={link.id} className="relative group">
                            <CMSLink 
                                className="text-white" 
                                appearance="inline"
                                {...link.link}
                            />
                            {link.children && link.children.length > 0 && (
                                <div className="absolute left-0 top-full hidden group-hover:block bg-slate-800 p-2 rounded-md min-w-[200px]">
                                    <div className="flex flex-col gap-2">
                                        {link.children.map((child, index) => (
                                            <CMSLink 
                                                key={index}
                                                className="text-white hover:text-gray-300 whitespace-nowrap" 
                                                appearance="inline"
                                                {...child.link}
                                            />
                                        ))}
                                    </div>
                                </div>
                            )}
                        </div>
                    ))}
                </nav>
            </div>
        </section>
    )
}