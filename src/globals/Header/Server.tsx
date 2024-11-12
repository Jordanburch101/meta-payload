import { getPayloadHMR } from "@payloadcms/next/utilities"
import config from "@/payload.config"
import Image from "next/image"
import { CMSLink } from '@/components/Link'

// Update the HeaderType to include children
type HeaderType = {
  logo: {
    url: string
    alt: string
    width: number
    height: number
  }
  links: {
    link: {
      label: string
      type?: 'custom' | 'reference' | null
      url?: string
      reference?: {
        relationTo: 'pages'
        value: any
      } | null
      newTab?: boolean | null
    }
    children?: {
      link: {
        label: string
        type?: 'custom' | 'reference' | null
        url?: string
        reference?: {
          relationTo: 'pages'
          value: any
        } | null
        newTab?: boolean | null
      }
    }[]
    id?: string
  }[]
}

export default async function Header() {
    const payload = await getPayloadHMR({config})
    const header = await payload.findGlobal({
        slug: 'header',
    }) as HeaderType
    return (
        <section className="bg-slate-900 px-4">
            <div className="flex items-center w-full h-32 gap-11">
                <div className="w-64 h-32 flex items-center justify-center">
                    <CMSLink type="custom" url="/">
                        <Image src={header.logo.url} alt={header.logo.alt} width={header.logo.width} height={header.logo.height} className="object-contain" />
                    </CMSLink>
                </div>
                <nav className="flex items-center gap-4">
                    {header.links.map((link) => (
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