import Date from '../../components/date'
import GlobalLayout from '../../components/global-layout'
import Head from 'next/head'
import PoemLayout from '../../components/poem-layout'
import { getAllPoemIds, getPoemData } from '../../lib/poems'
import Link from 'next/link'

export async function getStaticProps({ params }) {
  const poemData = await getPoemData(params.id)
  return {
    props: {
      poemData
    }
  }
}


export async function getStaticPaths() {
  const paths = getAllPoemIds()
  return {
    paths,
    fallback: false
  }
}

export default function Poem({ poemData }) {
    return (
      <GlobalLayout>
        <PoemLayout>
          <Head>
              <title>{ poemData.title }</title>
          </Head>
          <header>
            <h1>{poemData.title}</h1>
            <div><Date dateString={poemData.date} /></div>
          </header>
          <div dangerouslySetInnerHTML={{ __html: poemData.contentHtml }} />
          <p><Link href={ `/` }>Return Home</Link></p>
        </PoemLayout>
      </GlobalLayout>
    )
  }
  
  