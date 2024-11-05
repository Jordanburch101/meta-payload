export default function CoverBlockServer({title, subtitle}: {title: string, subtitle: string}) {
    return (
        <div className="max-w-5xl mx-auto py-24 text-center bg-slate-500">
            <h1 className="text-4xl text-white font-bold mb-4">{title}</h1>
            <p className="text-xl text-white">{subtitle}</p>
        </div>
    )
}