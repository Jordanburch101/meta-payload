import { GithubGlobeClient } from "./Client"

export default function GithubGlobeServer({title, description}: {title: string, description: string}) {  
    return (
        <div className="mx-auto flex justify-center">
            <GithubGlobeClient title={title} description={description} />
        </div>
    )
}