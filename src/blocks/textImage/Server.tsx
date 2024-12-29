import Image from "next/image"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { CMSLink } from '@/components/Link'
import DynamicImage from "@/components/ui/dynamic-image"

interface ButtonProps {
  title: string
  link: string
  variant: 'default' | 'secondary' | 'outline' | 'ghost' | 'link'
}

interface TextImageLayoutProps {
  imageOnRight?: boolean
  title: string
  description: string
  alignment: 'left' | 'right'
  image: {
    url: string
    alt: string
  }
  buttons: ButtonProps[]
}

export default function TextImageServer({
  imageOnRight = true,
  title,
  description,
  alignment,
  image,
  buttons,
}: TextImageLayoutProps) {
  const contentOrder = alignment === 'right' ? "lg:order-first" : "lg:order-last"
  const imageOrder = alignment === 'right' ? "lg:order-last" : "lg:order-first"

  return (
    <section className="my-12 md:my-24">
      <div className="container px-4 md:px-6">
        <div className="grid items-center gap-6 lg:grid-cols-2 lg:gap-12 xl:gap-16">
          <div className={`space-y-4 ${contentOrder}`}>
            <h2 className="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl">{title}</h2>
            <p className="text-gray-500 dark:text-gray-400 md:text-xl/relaxed lg:text-base/relaxed xl:text-xl/relaxed">
              {description}
            </p>
            <div className="flex flex-col gap-2 min-[400px]:flex-row">
              {buttons.map((child, index) => (
                // @ts-ignore
                <CMSLink key={index} {...child.link} />
              ))}
            </div>
          </div>
          <div className={`flex justify-center ${imageOrder}`}>
            <Image 
              className="aspect-[4/3] overflow-hidden rounded-xl object-cover object-center w-full h-auto" 
              src={image.url} 
              alt={image.alt} 
              width={800}
              height={600}
            />
          </div>
        </div>
      </div>
    </section>
  )
}