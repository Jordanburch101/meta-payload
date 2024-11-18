import { Block } from "payload";
import { link } from '@/fields/link'

export const TextImage: Block = {
    slug: 'text-image',
    imageURL: 'https://vfmxvvugriytncpzypvm.supabase.co/storage/v1/object/public/meta-payload-main-bucket/block-thumbnails/text-image-block.png',
    fields: [
        {
            name: 'title',
            label: 'Title',
            type: 'text',
        },
        {
            name: 'description',
            label: 'Description',
            type: 'textarea',
        },
        {
            name: 'alignment',
            label: 'Alignment',
            type: 'select',
            options: [
                {
                    label: 'Left',
                    value: 'left',
                },
                {
                    label: 'Right',
                    value: 'right',
                },
            ],
            required: true,
        },
        {
            name: 'image',
            label: 'Image',
            type: 'upload',
            relationTo: 'media',
            required: true,
        },
        {
            name: 'buttons',
            label: 'Buttons',
            type: 'array',
            fields: [
                link({

                })
            ],
        },
    ],
}