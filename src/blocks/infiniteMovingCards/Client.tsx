"use client";

import React, { useEffect, useState } from "react";
import { InfiniteMovingCards } from "@/components/ui/infinite-moving-cards";

type Card = {
    quote: string
    name: string
    title: string
}

export function InfiniteMovingCardsClient({cards}: {cards: Card[]}) {
  return (
    <div className="h-[40rem] rounded-md flex flex-col antialiased bg-white dark:bg-black dark:bg-grid-white/[0.05] items-center justify-center relative overflow-hidden">
      <InfiniteMovingCards
        items={cards}
        direction="right"
        speed="slow"
      />
    </div>
  );
}
