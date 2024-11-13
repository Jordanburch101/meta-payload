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
import {
  Sheet,
  SheetContent,
  SheetTrigger,
  SheetTitle,
} from "@/components/ui/sheet"
import { Menu } from "lucide-react"

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
        <section className="bg-black mx-0 w-screen px-4 sticky top-0 z-[49]">
            <div className="flex items-center container mx-auto justify-between w-full gap-11">
                <div className="w-64 py-6 md:py-10 flex items-center justify-center">
                    <CMSLink type="custom" url="/">
                        <Image src={header.logo.url} alt={header.logo.alt} width={header.logo.width} height={header.logo.height} className="object-contain" />
                    </CMSLink>
                </div>
                
                {/* Desktop Navigation */}
                <div className="hidden md:block">
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

                <button className="bg-slate-800 no-underline group cursor-pointer relative shadow-2xl shadow-zinc-900 rounded-full p-px text-xs font-semibold leading-6  text-white hidden md:inline-block">
                    <span className="absolute inset-0 overflow-hidden rounded-full">
                        <span className="absolute inset-0 rounded-full bg-[image:radial-gradient(75%_100%_at_50%_0%,rgba(56,189,248,0.6)_0%,rgba(56,189,248,0)_75%)] opacity-0 transition-opacity duration-500 group-hover:opacity-100" />
                    </span>
                    <div className="relative flex space-x-2 items-center z-10 rounded-full bg-zinc-950 py-0.5 px-4 ring-1 ring-white/10 ">
                        <span>
                        Payload Dashboard
                        </span>
                        <svg
                        fill="none"
                        height="16"
                        viewBox="0 0 24 24"
                        width="16"
                        xmlns="http://www.w3.org/2000/svg"
                        >
                        <path
                            d="M10.75 8.75L14.25 12L10.75 15.25"
                            stroke="currentColor"
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            strokeWidth="1.5"
                        />
                        </svg>
                    </div>
                    <span className="absolute -bottom-0 left-[1.125rem] h-px w-[calc(100%-2.25rem)] bg-gradient-to-r from-emerald-400/0 via-emerald-400/90 to-emerald-400/0 transition-opacity duration-500 group-hover:opacity-40" />
                </button>

                {/* Mobile Navigation */}
                <div className="md:hidden ml-auto">
                    <Sheet>
                        <SheetTrigger className="text-white">
                            <Menu className="w-6 h-6" />
                        </SheetTrigger>
                        <SheetContent side="right" className="bg-black w-[300px] p-6">
                            <SheetTitle aria-describedby="navigation" className="text-white mb-4">Navigation</SheetTitle>
                            <div className="flex flex-col gap-4">
                                {header.links.map((link) => (
                                    <div key={link.id}>
                                        {link.children && link.children.length > 0 ? (
                                            <div className="flex flex-col gap-2">
                                                <div className="text-white font-medium">
                                                    {link.link.label}
                                                </div>
                                                <div className="ml-4 mt-2 flex flex-col gap-2">
                                                    {link.children.map((child, index) => (
                                                        <div key={index} className="flex items-center gap-2">
                                                            <span className="text-white/90">-</span>
                                                            <CMSLink
                                                                key={index}
                                                                className="text-white/90 hover:text-white transition-colors"
                                                                appearance="inline"
                                                                {...child.link}
                                                            />
                                                        </div>
                                                    ))}
                                                </div>
                                            </div>
                                        ) : (
                                            <CMSLink
                                                className="text-white hover:text-white/70 transition-colors"
                                                appearance="inline"
                                                {...link.link}
                                            />
                                        )}
                                    </div>
                                ))}
                            </div>

                            <button className="bg-slate-800 mt-10 no-underline group cursor-pointer relative shadow-2xl shadow-zinc-900 rounded-full p-px text-xs font-semibold leading-6  text-white inline-block">
                                <span className="absolute inset-0 overflow-hidden rounded-full">
                                    <span className="absolute inset-0 rounded-full bg-[image:radial-gradient(75%_100%_at_50%_0%,rgba(56,189,248,0.6)_0%,rgba(56,189,248,0)_75%)] opacity-0 transition-opacity duration-500 group-hover:opacity-100" />
                                </span>
                                <div className="relative flex space-x-2 items-center z-10 rounded-full bg-zinc-950 py-0.5 px-4 ring-1 ring-white/10 ">
                                    <span>
                                    Payload Dashboard
                                    </span>
                                    <svg
                                    fill="none"
                                    height="16"
                                    viewBox="0 0 24 24"
                                    width="16"
                                    xmlns="http://www.w3.org/2000/svg"
                                    >
                                    <path
                                        d="M10.75 8.75L14.25 12L10.75 15.25"
                                        stroke="currentColor"
                                        strokeLinecap="round"
                                        strokeLinejoin="round"
                                        strokeWidth="1.5"
                                    />
                                    </svg>
                                </div>
                                <span className="absolute -bottom-0 left-[1.125rem] h-px w-[calc(100%-2.25rem)] bg-gradient-to-r from-emerald-400/0 via-emerald-400/90 to-emerald-400/0 transition-opacity duration-500 group-hover:opacity-40" />
                            </button>
                        </SheetContent>
                    </Sheet>
                </div>
            </div>
        </section>
    )
}

