sed 's/\<Article id\=/\
\<Article id=/g' "$1" > "$1".new

mv "$1" backup-"$1"
mv "$1".new "$1"
