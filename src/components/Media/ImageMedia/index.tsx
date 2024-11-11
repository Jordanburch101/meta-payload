'use client'

import type { StaticImageData } from 'next/image'

import { cn } from '@/lib/utils'
import NextImage from 'next/image'
import React from 'react'

import type { Props as MediaProps } from '../types'



const cssVariables = {
  breakpoints: {
    l: 1440,
    m: 1024,
    s: 768,
  },
  colors: {
    base0: 'rgb(255, 255, 255)',
    base100: 'rgb(235, 235, 235)',
    base500: 'rgb(128, 128, 128)',
    base850: 'rgb(34, 34, 34)',
    base1000: 'rgb(0, 0, 0)',
    error500: 'rgb(255, 111, 118)',
  },
}

const { breakpoints } = cssVariables

export const ImageMedia: React.FC<MediaProps> = (props) => {
  const {
    alt: altFromProps,
    fill,
    imgClassName,
    onClick,
    onLoad: onLoadFromProps,
    priority,
    resource,
    size: sizeFromProps,
    src: srcFromProps,
  } = props

  const [isLoading, setIsLoading] = React.useState(true)

  let width: number | undefined
  let height: number | undefined
  let alt = altFromProps
  let src: StaticImageData | string = srcFromProps || ''

  if (!src && resource && typeof resource === 'object') {
    const {
      alt: altFromResource,
      filename: fullFilename,
      height: fullHeight,
      url,
      width: fullWidth,
    } = resource

    width = fullWidth!
    height = fullHeight!
    alt = altFromResource

    src = `${url}`
  }

  // NOTE: this is used by the browser to determine which image to download at different screen sizes
  const sizes = sizeFromProps
    ? sizeFromProps
    : Object.entries(breakpoints)
        .map(([, value]) => `(max-width: ${value}px) ${value}px`)
        .join(', ')

  return (
    <NextImage
      alt={alt || ''}
      className={cn(imgClassName, 'w-full object-cover')}
      fill={fill}
      height={!fill ? height : undefined}
      onClick={onClick}
      onLoad={() => {
        setIsLoading(false)
        if (typeof onLoadFromProps === 'function') {
          onLoadFromProps()
        }
      }}
      priority={priority}
      quality={90}
      sizes={sizes}
      src={src}
      placeholder="blur"
      blurDataURL={typeof src === 'string' ? src : undefined}
      width={!fill ? width : undefined}
    />
  )
}
