import { Block } from "payload";

export const HeroHighlight: Block = {
    slug: 'hero-highlight',
    imageURL: 'https://vfmxvvugriytncpzypvm.supabase.co/storage/v1/object/public/meta-payload-main-bucket/block-thumbnails/hero-block.png',
    fields: [
        {
            name: 'title',
            label: 'Title',
            type: 'text',
            required: true,
        },
        {
            name: 'highlight',
            label: 'Highlight',
            type: 'textarea',
            required: true,
        },
    ],
}