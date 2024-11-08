import { lexicalEditor } from "@payloadcms/richtext-lexical";
import { FixedToolbarFeature, HeadingFeature, InlineToolbarFeature } from "@payloadcms/richtext-lexical";
import { Block } from "payload";

export const RichText: Block = {
    slug: 'rich-text',
    imageURL: 'https://vfmxvvugriytncpzypvm.supabase.co/storage/v1/object/public/meta-payload-main-bucket/block-thumbnails/rich-text-block.png',
    fields: [
        {
            name: 'content',
            label: 'Content',
            type: 'richText',
            required: true,
            editor: lexicalEditor({
                features: ({ rootFeatures }) => {
                  return [
                    ...rootFeatures.filter(feature => feature.key !== 'relationship'),
                    HeadingFeature({ enabledHeadingSizes: ['h2', 'h3', 'h4'] }),
                    FixedToolbarFeature(),
                    InlineToolbarFeature(),
                  ]
                },
              }),
        },
    ],
}