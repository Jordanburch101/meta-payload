'use client';

import { useState, useEffect } from 'react';
import { useRouter } from 'next/router';
import { Sheet, SheetContent, SheetTrigger, SheetTitle } from "@/components/ui/sheet";
import { Menu } from "lucide-react";
import { CMSLink } from '@/components/Link';

type LinkType = {
  link: {
    label: string;
    type?: 'custom' | 'reference' | null;
    url?: string;
    reference?: {
      relationTo: 'pages';
      value: any;
    } | null;
    newTab?: boolean | null;
  };
  children?: LinkType[];
  id?: string;
};

type HeaderType = {
  links: LinkType[];
};

export default function MobileNavigation({ header }: { header: HeaderType }) {
  const [isSheetOpen, setIsSheetOpen] = useState(false);
  const [isMounted, setIsMounted] = useState(false);



  return (
    <div className="md:hidden ml-auto">
      <Sheet open={isSheetOpen} onOpenChange={setIsSheetOpen}>
        <SheetTrigger className="text-white" onClick={() => setIsSheetOpen(true)}>
          <Menu className="w-6 h-6" />
        </SheetTrigger>
        <SheetContent side="right" className="bg-black w-[300px] p-6">
          <SheetTitle aria-describedby="navigation" className="text-white mb-4">Navigation</SheetTitle>
          <div className="flex flex-col gap-4">
            {header.links.map((link) => (
              <div key={link.id}>
                {link.children && link.children.length > 0 ? (
                  <div className="flex flex-col gap-2">
                    <div className="text-white font-medium">
                      {link.link.label}
                    </div>
                    <div className="ml-4 mt-2 flex flex-col gap-2">
                      {link.children.map((child, index) => (
                        <div key={index} className="flex items-center gap-2">
                          <span className="text-white/90">-</span>
                          <CMSLink
                            key={index}
                            className="text-white/90 hover:text-white transition-colors"
                            appearance="inline"
                            {...child.link}
                          />
                        </div>
                      ))}
                    </div>
                  </div>
                ) : (
                  <CMSLink
                    className="text-white hover:text-white/70 transition-colors"
                    appearance="inline"
                    {...link.link}
                  />
                )}
              </div>
            ))}
          </div>

          <div className="mt-auto">
            <button className="bg-slate-800 no-underline group cursor-pointer relative shadow-2xl shadow-zinc-900 rounded-full p-px text-xs font-semibold leading-6  text-white inline-block">
              <span className="absolute inset-0 overflow-hidden rounded-full">
                <span className="absolute inset-0 rounded-full bg-[image:radial-gradient(75%_100%_at_50%_0%,rgba(56,189,248,0.6)_0%,rgba(56,189,248,0)_75%)] opacity-0 transition-opacity duration-500 group-hover:opacity-100" />
              </span>
              <div className="relative flex space-x-2 items-center z-10 rounded-full bg-zinc-950 py-0.5 px-4 ring-1 ring-white/10 ">
                <span>
                  Payload Dashboard
                </span>
                <svg
                  fill="none"
                  height="16"
                  viewBox="0 0 24 24"
                  width="16"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M10.75 8.75L14.25 12L10.75 15.25"
                    stroke="currentColor"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeWidth="1.5"
                  />
                </svg>
              </div>
              <span className="absolute -bottom-0 left-[1.125rem] h-px w-[calc(100%-2.25rem)] bg-gradient-to-r from-emerald-400/0 via-emerald-400/90 to-emerald-400/0 transition-opacity duration-500 group-hover:opacity-40" />
            </button>
          </div>
        </SheetContent>
      </Sheet>
    </div>
  );
} 