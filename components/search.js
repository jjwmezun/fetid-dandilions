import { useCallback, useRef, useState } from "react"
import Link from 'next/link'
import styles from './search.module.sass'

export default function Search() {
    const searchRef = useRef(null)
    const [query, setQuery] = useState('')
    const [active, setActive] = useState(false)
    const [results, setResults] = useState([])

    const searchEndpoint = (query) => `/api/search?q=${query}`

    const onChange = useCallback((event) => {
        const query = event.target.value
        setQuery(query)
        if (query.length) {
            fetch(searchEndpoint(query))
                .then(res => res.json())
                .then(res => {
                    setResults(res.results)
                })
        } else {
            setResults([])
        }
    }, [])

    const onFocus = useCallback(() => {
        setActive(true)
        window.addEventListener('click', onClick)
    }, [])

    const onBlur = useCallback(() => {
        setActive(false)
    })

    const onClick = useCallback((event) => {
        if (searchRef.current && !searchRef.current.contains(event.target)) {
            setActive(false)
            window.removeEventListener('click', onClick)
        }
    }, [])

    return <div className={styles.search}>
        <input
            className={styles.searchBox}
            type="text"
            name="query"
            placeholder="Search"
            onChange={onChange}
            onFocus={onFocus}
            onBlur={onBlur}
            value={query}
        />
        { active && results.length > 0 && (
            <ul className={styles.results}>
                {results.map(({id, title}) => (
                    <li className={styles.result} key={id}>
                        <Link href="/poems/[id]" as={`poems/${id}`}>
                            <a>{title}</a>
                        </Link>
                    </li>
                ))}
            </ul>
        )}
    </div>
}