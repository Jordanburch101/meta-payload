import { Cover } from "@/blocks/cover/schema";
import { RichText } from "@/blocks/richText/schema";
import { Image } from "@/blocks/image/schema";
import { CollectionConfig } from "payload";
import { afterChange, afterDelete } from '../hooks/revalidate'

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
            ]
        },
    ],
    hooks: {
        afterChange: [afterChange],
        afterDelete: [afterDelete],
    },
}