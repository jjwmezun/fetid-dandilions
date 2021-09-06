import { getSortedPoemsData } from '../../lib/poems'
const poems = process.env.NODE_ENV === `production` ?
    require( `${ process.pwd }/cache/data` ).poems : getSortedPoemsData()

console.log( `${ process.pwd }/cache/data` );

export default function handler(req, res) {
    const results = req.query.q ?
        poems.filter(poem => poem.title.toLowerCase().includes(req.query.q)) : []
    res.statusCode = 200
    res.setHeader(`Content-Type`, `application/json`)
    res.end(JSON.stringify({ results }))
}
  