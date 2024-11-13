import { Page } from '@/payload-types'
import React, { Fragment } from 'react'
import CoverBlockServer from '@/blocks/cover/Server'
import ImageBlockServer from '@/blocks/image/Server'
import RichTextBlockServer from '@/blocks/richText/Server'
import HeroHighlightServer from '@/blocks/heroHighlight/Server'
import SpotlightServer from '@/blocks/spotlight/Server'
import {FormBlockClient} from '@/blocks/form/Client'
import TikTacToeServer from '../tikTacToe/Server'
import InfiniteMovingCardsServer from '../infiniteMovingCards/Server'
import GithubGlobeServer from '../githubGlobe/Server'
import TextEffectServer from '../textEffect/Server'

const blockComponents = {
    'hero-highlight': HeroHighlightServer,
    'spotlight': SpotlightServer,
    'cover': CoverBlockServer,
    'image': ImageBlockServer,
    'rich-text': RichTextBlockServer,
    'formBlock': FormBlockClient,
    'tik-tac-toe': TikTacToeServer,
    'infinite-moving-cards': InfiniteMovingCardsServer,
    'github-globe': GithubGlobeServer,
    'text-effect': TextEffectServer,
}

export const RenderBlocks: React.FC<{
  blocks: Page['layout']['layout']
}> = (props) => {
  const { blocks } = props

  const hasBlocks = blocks && Array.isArray(blocks) && blocks.length > 0

  if (hasBlocks) {
    return (
      <Fragment>
        {blocks.map((block, index) => {
          const { blockName, blockType } = block
          

          if (blockType && blockType in blockComponents) {
            const Block = blockComponents[blockType]

            if (Block) {
              return (
                <div className="" key={index}>
                  <Block {...(({ blockName, blockType, ...rest }: typeof block) => rest)(block) as any} />
                </div>
              )
            }
          }
          return null
        })}
      </Fragment>
    )
  }

  return null
}
