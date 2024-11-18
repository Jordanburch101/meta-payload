"use client";
import React from "react";
import { LinkPreview } from "@/components/ui/link-preview";

interface LinkPreviewClientProps {
    rows: any[];
    
}

export function LinkPreviewClient({ rows }: LinkPreviewClientProps) {
  return (
    <div className="flex justify-center items-center flex-col px-4">
      {rows.map((row, index) => (
        <div key={index} className="text-neutral-500 dark:text-neutral-400 text-xl md:text-3xl max-w-3xl mx-auto mb-10">
          {row['first-text'] && (
            <>
              {row['first-text']}{" "}
            </>
          )}
          {row['first-link'] && (
            <LinkPreview url={row['first-link'].link} className="font-bold">
              {row['first-link'].title}
            </LinkPreview>
          )}
          {row['second-text'] && (
            <>
              {" "}{row['second-text']}{" "}
            </>
          )}
          {row['second-link'] && (
            <LinkPreview url={row['second-link'].link} className="font-bold">
              {row['second-link'].title}
            </LinkPreview>
          )}
          {row['third-text'] && (
            <>
              {" "}{row['third-text']}{" "}
            </>
          )}
          {row['third-link'] && (
            <LinkPreview
              url={row['third-link'].link}
              className="font-bold bg-clip-text text-transparent bg-gradient-to-br from-purple-500 to-pink-500"
            >
              {row['third-link'].title}
            </LinkPreview>
          )}
        </div>
      ))}
    </div>
  );
}
