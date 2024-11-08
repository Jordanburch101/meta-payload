import { Cover } from "@/blocks/cover/schema";
import { RichText } from "@/blocks/richText/schema";
import { Image } from "@/blocks/image/schema";
import { HeroHighlight } from "@/blocks/heroHighlight/schema";
import { CollectionConfig } from "payload";
import { Spotlight } from "@/blocks/spotlight/schema";
import { revalidateNextCache } from "@/hooks/revalidateNextCache";


export const Pages: CollectionConfig = {
    slug: 'pages',
    fields: [
        {
            name: 'title',
            label: 'Title',
            type: 'text',
            required: true,
        },
        {
            name: 'slug',
            label: 'Slug',
            type: 'text',
            required: true,
            admin: {
                position: 'sidebar',
            },
        },
        {
            name: 'layout',
            label: 'Layout',
            type: 'blocks',
            required: true,
            blocks: [
                Cover,
                RichText,
                Image,
                HeroHighlight,
                Spotlight
            ]
        },
    ],
    hooks: {
        afterChange: [revalidateNextCache],
    },
}