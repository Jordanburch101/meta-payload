import { Cover } from "@/blocks/cover/schema";
import { RichText } from "@/blocks/richText/schema";
import { Image } from "@/blocks/image/schema";
import { HeroHighlight } from "@/blocks/heroHighlight/schema";
import { CollectionConfig } from "payload";
import { Spotlight } from "@/blocks/spotlight/schema";
import { TikTacToe } from "@/blocks/tikTacToe/schema";
import { TextEffect } from "@/blocks/textEffect/schema";
import { ConfettiHeader } from "@/blocks/confettiHeader/schema";
import { TextImage } from "@/blocks/textImage/schema";
import { revalidatePage } from './hooks/revalidatePage'

import { OverviewField, MetaTitleField, MetaImageField, MetaDescriptionField, PreviewField } from '@payloadcms/plugin-seo/fields'
import { slugField } from "@/fields/slug";
import { FormBlock } from "@/blocks/form/schema";
import { authenticated } from "@/access/authenticated";
import { authenticatedOrPublished } from "@/access/authenticatedOrPublished";
import { populatePublishedAt } from "@/hooks/populatePublishedAt";
import { generatePreviewPath } from '@/utils/generatePreviewPath'
import { InfiniteMovingCards } from "@/blocks/infiniteMovingCards/schema";
import { GithubGlobe } from "@/blocks/githubGlobe/schema";
import { LinksPreview } from "@/blocks/LinksPreview/schema";

export const Pages: CollectionConfig = {
    slug: 'pages',
    access: {
        create: authenticated,
        delete: authenticated,
        read: authenticatedOrPublished,
        update: authenticated,
      },
    admin: {
        livePreview: {
            url: ({ data }) => {
              const path = generatePreviewPath({
                slug: typeof data?.slug === 'string' ? data.slug : '',
                collection: 'pages',
              })
      
              return `${process.env.NEXT_PUBLIC_SERVER_URL}${path}`
            },
          },
          preview: (data) => {
            const path = generatePreviewPath({
              slug: typeof data?.slug === 'string' ? data.slug : '',
              collection: 'pages',
            })
      
            return `${process.env.NEXT_PUBLIC_SERVER_URL}${path}`
          },
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
                            FormBlock,
                            TikTacToe,
                            InfiniteMovingCards,
                            GithubGlobe,
                            TextEffect,
                            ConfettiHeader,
                            TextImage,
                            LinksPreview,
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
                interval: 100, // This autosaves every 100 milliseconds (10 times per second) for optimal live preview
            },
    },
    maxPerDoc: 50,
    },
    lockDocuments: {
      duration: 600, // Duration in seconds
    },
    hooks: {
        afterChange: [revalidatePage],  
        beforeChange: [populatePublishedAt],
    },
}