import { Block } from "payload";

export const ConfettiHeader: Block = {
    slug: 'confetti-header',
    imageURL: 'https://vfmxvvugriytncpzypvm.supabase.co/storage/v1/object/public/meta-payload-main-bucket/block-thumbnails/confetti-header-block.png',
    fields: [
        {
            name: 'title',
            label: 'Title',
            type: 'text',
        },
    ],
}