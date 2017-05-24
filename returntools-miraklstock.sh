sed 's/\<article/\
\<article/g' "$1" > "$1".new

mv "$1" backup-"$1"
mv "$1".new "$1"

grep -v "sellerId=\"[0-9]*\"" $1
