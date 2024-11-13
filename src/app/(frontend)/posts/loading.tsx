"use client";
import { tailspin } from 'ldrs'

tailspin.register()

export default function Loader() {
  return (
    <section className="flex flex-col items-center justify-center pb-24 min-h-screen">
      <div className="flex flex-col items-center justify-center">
        <div className="grid place-items-center">
          {/* @ts-ignore */}
          <l-tailspin
            size="150"
            stroke="5"
            speed="0.9" 
            color="rgb(255 255 255)"
          >
          {/* @ts-ignore */}
          </l-tailspin>
        </div>
      </div>
    </section>
  )
}