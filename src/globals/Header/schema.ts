import { GlobalConfig } from "payload";
import { link } from '@/fields/link'
import { revalidateHeader } from './hooks/revalidateHeader'

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
                link({
                    appearances: false
                }),
                {
                    name: 'children',
                    label: 'Dropdown Links',
                    type: 'array',
                    fields: [
                        link({
                            appearances: false
                        })
                    ],
                    admin: {
                        condition: () => true
                    }
                }
            ],
            minRows: 1,
            maxRows: 5,
            required: true,
        },
    ],
    hooks: {
        afterChange: [revalidateHeader],
      },
}