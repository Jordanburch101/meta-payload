import { Block } from "payload";

export const TextEffect: Block = {
    slug: 'text-effect',
    imageURL: 'https://vfmxvvugriytncpzypvm.supabase.co/storage/v1/object/public/meta-payload-main-bucket/block-thumbnails/text-effect-block.png',
    fields: [
        {
            name: 'text',
            label: 'Text',
            type: 'text',
            required: true,
        },

    ],
}