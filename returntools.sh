sed 's/\<Article id\=/\                     
\<Article id=/g' $1 > $1.new

mv $1 $1-bak
mv $1.new $1
