FILENAME=`basename $1`
sort -t: -n -k 3 -k4 -k5 $1 > /tmp/pgaotemp/bak/$FILENAME.new
