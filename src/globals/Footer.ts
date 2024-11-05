import { GlobalConfig } from "payload";

export const Footer: GlobalConfig = {
    slug: 'footer',
    fields: [
        {
            name: 'logo',
            label: 'Logo',
            type: 'upload',
            relationTo: 'media',
            required: true,
        },
        {
            name: 'links',
            label: 'Links',
            type: 'array',
            fields: [
                {
                    name: 'label',
                    label: 'Label',
                    type: 'text',
                },
                {
                    name: 'url',
                    label: 'URL',
                    type: 'text',
                },
            ],
        },
        {
            name: 'copyright',
            label: 'Copyright',
            type: 'text',
            required: true,
        },
    ],
}