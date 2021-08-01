import Link from 'next/link'
import Search from './search.js'

export default function GlobalLayout({ children }) {
    return <div>
        <header>
            <h1>Fetid Dandilions</h1>
            <nav>
                <ul>
                    <li><Link href={ `/` }>Home</Link></li>
                </ul>
            </nav>
            <Search />
        </header>
        {children}
    </div>
}