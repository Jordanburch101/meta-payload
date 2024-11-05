
import { Block } from "payload";

export const RichText: Block = {
    slug: 'rich-text',
    fields: [
        {
            name: 'content',
            label: 'Content',
            type: 'richText',
            required: true,
        },
    ],
}