import GlobalLayout from '$/components/global-layout'
import Link from 'next/link'

export default function Custom404() {
    return <GlobalLayout><h1>Page Not Found</h1><p><Link href={ `/` }>Go to Home Page</Link></p></GlobalLayout>
}