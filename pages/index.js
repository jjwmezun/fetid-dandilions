import Date from '../components/date'
import GlobalLayout from '../components/global-layout'
import Head from 'next/head'
import Image from 'next/image'
import Link from 'next/link'

import { getSortedPoemsData } from '../lib/poems'

export async function getStaticProps() {
  const allPoemsData = getSortedPoemsData()
  return {
    props: {
      allPoemsData
    }
  }
}

export default function Home({ allPoemsData }) {
  return (
    <GlobalLayout>
      <Head>
        <title>Fetid Dandilions</title>
        <meta charset="utf-8"></meta>
      </Head>

      <main>
        <h1>Fetid Dandilions</h1>
      </main>

      <section>
        <h2>Poems</h2>
        <ul>
          {allPoemsData.map(({ id, date, title }) => (
            <li key={id}>
              <Link href={`/poems/${id}`}>{title}</Link>
            </li>
          ))}
        </ul>
      </section>
    </GlobalLayout>
  )
}
