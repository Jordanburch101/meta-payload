import { Block } from "payload";

export const HeroHighlight: Block = {
    slug: 'hero-highlight',
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