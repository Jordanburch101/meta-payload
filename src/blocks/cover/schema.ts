import { Block } from "payload";

export const Cover: Block = {
    slug: 'cover',
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