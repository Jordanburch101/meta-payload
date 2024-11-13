import ConfettiHeaderClient from "./Client";

export default function ConfettiHeaderBlockServer({title}: {title: string}) {
    return (
        <div className="max-w-5xl mx-auto text-center">
            <ConfettiHeaderClient title={title} />
        </div>
    )
}