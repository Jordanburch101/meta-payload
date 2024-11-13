import { link } from "@/fields/link";
import { GlobalConfig } from "payload";
import { revalidateFooter } from "./hooks/revalidateFooter";

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
        {
            name: 'copyright',
            label: 'Copyright',
            type: 'text',
            required: true,
        },
    ],
    hooks: {
        afterChange: [revalidateFooter],
    },
}