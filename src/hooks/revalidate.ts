import type { CollectionAfterChangeHook } from 'payload'

export const afterChangeHook: CollectionAfterChangeHook = async ({
  doc,
}) => {
  return doc
}