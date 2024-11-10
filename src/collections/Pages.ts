import { Cover } from "@/blocks/cover/schema";
import { RichText } from "@/blocks/richText/schema";
import { Image } from "@/blocks/image/schema";
import { HeroHighlight } from "@/blocks/heroHighlight/schema";
import { CollectionConfig } from "payload";
import { Spotlight } from "@/blocks/spotlight/schema";
import { revalidateNextCache } from "@/hooks/revalidateNextCache";

import { OverviewField, MetaTitleField, MetaImageField, MetaDescriptionField, PreviewField } from '@payloadcms/plugin-seo/fields'
import { slugField } from "@/fields/slug";
import { FormBlock } from "@/blocks/form/schema";

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
            name: 'createdBy',
            type: 'relationship',
            relationTo: 'users',
            required: true,
            admin: {
                position: 'sidebar',
                readOnly: true,
            },
            hooks: {
                beforeChange: [
                    ({ req }) => {
                        if (!req.user) throw new Error('User is required');
                        return req.user.id;
                    },
                ],
            },
        },
        ...slugField(),
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
                            Spotlight,
                            FormBlock
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
    versions: {
        drafts: {
            autosave: {
                interval: 100, // We set this interval for optimal live preview
            },
    },
    maxPerDoc: 50,
    },
    hooks: {
        afterChange: [revalidateNextCache],
    },
}