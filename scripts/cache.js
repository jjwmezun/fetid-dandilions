const fs = require(`fs`);
const path = require(`path`);
const matter = require(`gray-matter`);

const getPoems = function() {
    const dir = path.join(process.cwd(), `poems`);
    const filenames = fs.readdirSync(dir);
    const poems = filenames.map(filename => {
        const id = filename.replace(/\.md$/, ``);
        const fullpath = path.join(dir, filename);
        const contents = fs.readFileSync(fullpath, `utf8`);
        const results = matter(contents);
        return {
            id,
            title: results.data.title
        };
    })
    return JSON.stringify(poems);
};

const contents = `export const poems = ${getPoems()}`;

try {
    fs.readdirSync(`cache`);
} catch (e) {
    fs.mkdirSync(`cache`);
}

fs.writeFile(`cache/data.js`, contents, function (err) {
    if ( err ) return console.log(err);
    console.log(`Poems cached.`);
})