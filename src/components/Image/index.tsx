import React from 'react'
import { Media } from '@/payload-types'
import NextImage from 'next/image'

interface ImageProps {
  image: Media | {
    id: number
    alt?: string
    url?: string
    width?: number
    height?: number
    prefix?: string
  }
  alt?: string
  width?: number
  height?: number
  className?: string
}

export const Image: React.FC<ImageProps> = ({ image, alt, width, height, className }) => {
  if (!image?.url) return null

  return (
    <NextImage 
      src={image.url}
      alt={alt || image.alt || ''}
      width={width || image.width || undefined}
      height={height || image.height || undefined}
      className={className}
    />
  )
}
