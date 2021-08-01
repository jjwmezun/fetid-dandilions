import styles from './poem.module.sass'

export default function PoemLayout({ children }) {
    return <div className={styles.poem}>{children}</div>
  }
  