import * as React from 'react'

export const Width: React.FC<{
  children: React.ReactNode
  className?: string
  width?: number | string
}> = ({ children, className, width }) => {
  return (
    <div className={className} style={{ maxWidth: width ? `calc(${width}% - 1.5rem)` : undefined, flex: `0 0 calc(${width}% - 1.5rem)` }}>
      {children}
    </div>
  )
}
