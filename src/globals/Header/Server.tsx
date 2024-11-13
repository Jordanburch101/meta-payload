import { getPayloadHMR } from "@payloadcms/next/utilities"
import config from "@/payload.config"
import Image from "next/image"
import { CMSLink } from '@/components/Link'
import {
  NavigationMenu,
  NavigationMenuContent,
  NavigationMenuItem,
  NavigationMenuList,
  NavigationMenuTrigger,
} from "@/components/ui/navigation-menu"

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
        <section className="bg-black container mx-auto px-4">
            <div className="flex items-center w-full h-32 gap-11">
                <div className="w-64 h-32 flex items-center justify-center">
                    <CMSLink type="custom" url="/">
                        <Image src={header.logo.url} alt={header.logo.alt} width={header.logo.width} height={header.logo.height} className="object-contain" />
                    </CMSLink>
                </div>
                <NavigationMenu>
                    <NavigationMenuList>
                        {header.links.map((link) => (
                            <NavigationMenuItem key={link.id}>
                                {link.children && link.children.length > 0 ? (
                                    <>
                                        <NavigationMenuTrigger className="text-white">
                                            {link.link.label}
                                        </NavigationMenuTrigger>
                                        <NavigationMenuContent>
                                            <div className="w-[200px] p-3">
                                                <div className="flex flex-col gap-2">
                                                    {link.children.map((child, index) => (
                                                        <CMSLink
                                                            key={index}
                                                            className="text-foreground hover:text-muted-foreground transition-colors"
                                                            appearance="inline"
                                                            {...child.link}
                                                        />
                                                    ))}
                                                </div>
                                            </div>
                                        </NavigationMenuContent>
                                    </>
                                ) : (
                                    <CMSLink
                                        className="text-white px-3 py-2 hover:text-muted-foreground transition-colors"
                                        appearance="inline"
                                        {...link.link}
                                    />
                                )}
                            </NavigationMenuItem>
                        ))}
                    </NavigationMenuList>
                </NavigationMenu>
            </div>
        </section>
    )
}