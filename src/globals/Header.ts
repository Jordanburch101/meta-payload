import { GlobalConfig } from "payload";

export const Header: GlobalConfig = {
    slug: 'header',
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
            minRows: 1,
            maxRows: 5,
            required: true,
        },
    ],
}