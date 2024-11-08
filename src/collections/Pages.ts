import { Cover } from "@/blocks/cover/schema";
import { RichText } from "@/blocks/richText/schema";
import { Image } from "@/blocks/image/schema";
import { HeroHighlight } from "@/blocks/heroHighlight/schema";
import { CollectionConfig } from "payload";
import { Spotlight } from "@/blocks/spotlight/schema";
import { revalidateNextCache } from "@/hooks/revalidateNextCache";

import { OverviewField, MetaTitleField, MetaImageField, MetaDescriptionField, PreviewField } from '@payloadcms/plugin-seo/fields'

export const Pages: CollectionConfig = {
    slug: 'pages',
    admin: {
        useAsTitle: 'title',
        defaultColumns: ['title', 'slug', 'updatedAt'],
    },
    fields: [
        {
            name: 'title',
            label: 'Title',
            type: 'text',
            required: true,
        },
        {
            name: 'slug',
            label: 'Slug',
            type: 'text',
            required: true,
            admin: {
                position: 'sidebar',
            },
        },
        {
            type: 'tabs',
            tabs: [
                {
                    name: 'layout',
                    label: 'Layout',
                    fields: [{
                        type: 'blocks',
                        name: 'layout',
                        required: true,
                        blocks: [
                            Cover,
                            RichText,
                            Image,
                            HeroHighlight,
                            Spotlight
                        ]
                    }]
                },
                {
                    name: 'meta',
                    label: 'SEO',
                    fields: [
                      OverviewField({
                        titlePath: 'meta.title',
                        descriptionPath: 'meta.description',
                        imagePath: 'meta.image',
                      }),
                      MetaTitleField({
                        hasGenerateFn: true,
                      }),
                      MetaImageField({
                        relationTo: 'media',
                      }),
          
                      MetaDescriptionField({}),
                      PreviewField({
                        // if the `generateUrl` function is configured
                        hasGenerateFn: true,
          
                        // field paths to match the target field for data
                        titlePath: 'meta.title',
                        descriptionPath: 'meta.description',
                      }),
                    ],
                },
            ],
        },

    ],
    hooks: {
        afterChange: [revalidateNextCache],
    },
}