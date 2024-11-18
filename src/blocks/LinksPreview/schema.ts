import { Block } from 'payload'

export const LinksPreview: Block = {
  slug: 'links-preview',
  imageURL: 'https://vfmxvvugriytncpzypvm.supabase.co/storage/v1/object/public/meta-payload-main-bucket/block-thumbnails/links-preview-block.png',
  labels: {
    singular: 'Links Preview',
    plural: 'Links Previews',
  },
  fields: [
    {
      name: 'rows',
      label: 'Rows',
      type: 'array',
      required: true,
      fields: [
        {
          name: 'first-text',
          label: 'First Text',
          type: 'text',
        },
        {
          name: 'first-link',
          label: 'First Link',
          type: 'group',
          fields: [
            {
              name: 'link',
              label: 'Link',
              type: 'text',
            },
            {
              name: 'title',
              label: 'Title',
              type: 'text',
            },
          ],
        },
        {
          name: 'second-text',
          label: 'Second Text',
          type: 'text',
        },
        {
          name: 'second-link',
          label: 'Second Link',
          type: 'group',
          fields: [
            {
              name: 'link',
              label: 'Link',
              type: 'text',
            },
            {
              name: 'title',
              label: 'Title',
              type: 'text',
            },
          ],
        },
        {
          name: 'third-text',
          label: 'Third Text',
          type: 'text',
        },
      ]
    }
  ]
}