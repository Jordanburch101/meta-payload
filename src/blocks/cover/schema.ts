import { Block } from "payload";

export const Cover: Block = {
    slug: 'cover',
    imageURL: 'https://vfmxvvugriytncpzypvm.supabase.co/storage/v1/object/public/meta-payload-main-bucket/block-thumbnails/cover-block.png',
    fields: [
        {
            name: 'title',
            label: 'Title',
            type: 'text',
        },
        {
            name: 'subtitle',
            label: 'Subtitle',
            type: 'text',
        },
    ],
}