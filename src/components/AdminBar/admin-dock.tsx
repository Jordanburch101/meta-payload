'use client'

import { useState, useCallback } from 'react'
import { useRouter, useSelectedLayoutSegments } from 'next/navigation'
import { PayloadAdminBar, PayloadMeUser } from 'payload-admin-bar'
import { Card } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Tooltip, TooltipContent, TooltipProvider, TooltipTrigger } from "@/components/ui/tooltip"
import { Home, FileText, Settings, LogOut, Eye, EyeOff } from 'lucide-react'

const collectionLabels = {
  pages: { plural: 'Pages', singular: 'Page' },
  posts: { plural: 'Posts', singular: 'Post' },
}

type CollectionLabels = typeof collectionLabels
type CollectionKey = keyof typeof collectionLabels

export const AdminDock = ({ adminBarProps, slug }: { adminBarProps?: { preview?: boolean }, slug?: string }) => {
  const [show, setShow] = useState(false)
  const [isPreview, setIsPreview] = useState(adminBarProps?.preview || false)
  const segments = useSelectedLayoutSegments()
  const collection = slug?.startsWith('posts/') ? 'posts' : 'pages'
  const router = useRouter()


  const onAuthChange = useCallback((user: PayloadMeUser | null) => {
    setShow(Boolean(user?.id))
  }, [])

  // Remove the early return to see if PayloadAdminBar is rendering
  // if (!show) return null

  return (
    <TooltipProvider>
      <Card className="fixed bottom-4 left-1/2 transform -translate-x-1/2 bg-background/80 backdrop-blur-sm border border-border/50 rounded-full p-2 shadow-lg transition-all duration-300 hover:bg-background/90 hover:shadow-xl z-50" style={{ display: show ? 'block' : 'none' }}>
        <div className="flex items-center space-x-2">
          <PayloadAdminBar
            {...adminBarProps}
            cmsURL={process.env.NEXT_PUBLIC_SERVER_URL}
            collection={collection}
            collectionLabels={collectionLabels[collection]}
            onAuthChange={onAuthChange}
            style={{ display: 'none' }}
            id={slug}
          />
          <Tooltip>
            <TooltipTrigger asChild>
              <Button variant="ghost" size="icon" className="rounded-full transition-transform hover:scale-110" onClick={() => router.push('/admin')}>
                <Home className="h-5 w-5" />
              </Button>
            </TooltipTrigger>
            <TooltipContent>Dashboard</TooltipContent>
          </Tooltip>
          <Tooltip>
            <TooltipTrigger asChild>
              <Button variant="ghost" size="icon" className="rounded-full transition-transform hover:scale-110" onClick={() => router.push(`/admin/collections/${collection}`)}>
                <FileText className="h-5 w-5" />
              </Button>
            </TooltipTrigger>
            <TooltipContent>{collectionLabels[collection].plural}</TooltipContent>
          </Tooltip>
          <Tooltip>
            <TooltipTrigger asChild>
              <Button variant="ghost" size="icon" className="rounded-full transition-transform hover:scale-110" onClick={() => router.push('/admin/account')}>
                <Settings className="h-5 w-5" />
              </Button>
            </TooltipTrigger>
            <TooltipContent>Account Settings</TooltipContent>
          </Tooltip>
          <Tooltip>
            <TooltipTrigger asChild>
              <Button 
                variant="ghost" 
                size="icon" 
                className="rounded-full transition-transform hover:scale-110" 
                onClick={async () => {
                  try {
                    if (isPreview) {
                      await fetch('/next/exit-preview')
                      setIsPreview(false)
                    } else {
                      await fetch('/next/enter-preview')
                      setIsPreview(true)
                    }
                    router.refresh()
                  } catch (error) {
                    console.error('Preview toggle failed:', error)
                  }
                }}
              >
                {isPreview ? <EyeOff className="h-5 w-5" /> : <Eye className="h-5 w-5" />}
              </Button>
            </TooltipTrigger>
            <TooltipContent>{isPreview ? 'Exit Preview' : 'Enter Preview'}</TooltipContent>
          </Tooltip>
          <Tooltip>
            <TooltipTrigger asChild>
              <Button 
                variant="ghost" 
                size="icon" 
                className="rounded-full transition-transform hover:scale-110" 
                onClick={() => {
                  fetch('/api/users/logout').then(() => {
                    setShow(false)
                    router.push('/')
                    router.refresh()
                  })
                }}
              >
                <LogOut className="h-5 w-5" />
              </Button>
            </TooltipTrigger>
            <TooltipContent>Logout</TooltipContent>
          </Tooltip>
        </div>
      </Card>
    </TooltipProvider>
  )
}