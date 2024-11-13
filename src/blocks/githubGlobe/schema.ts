import { Block } from "payload";
// currently not working with react 19
export const GithubGlobe: Block = {
    slug: 'github-globe',
    imageURL: 'https://vfmxvvugriytncpzypvm.supabase.co/storage/v1/object/public/meta-payload-main-bucket/block-thumbnails/globe-block.png',
    fields: [
        {
            name: 'title',
            label: 'Title',
            type: 'text',
            required: true,
        },
        {
            name: 'description',
            label: 'Description',
            type: 'textarea',
            required: true,
        }
    ],
}