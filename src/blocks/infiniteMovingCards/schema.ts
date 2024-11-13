import { Block } from "payload";

export const InfiniteMovingCards: Block = {
    slug: 'infinite-moving-cards',
    imageURL: 'https://vfmxvvugriytncpzypvm.supabase.co/storage/v1/object/public/meta-payload-main-bucket/block-thumbnails/moving-cards-block.png',
    fields: [
        {
            name: 'cards',
            type: 'array',
            fields: [
                {
                    name: 'quote',
                    label: 'Quote',
                    type: 'text',
                    required: true,
                },
                {
                    name: 'name',
                    label: 'Name',
                    type: 'text',
                    required: true,
                },
                {
                    name: 'title',
                    label: 'Title',
                    type: 'text',
                    required: true,
                }
            ]
        }
    ],
}