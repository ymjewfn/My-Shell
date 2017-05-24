#set -x
DATE=`date +"%Y%m"`
temp=/home/mqm/pgao/replayOrders
> $temp/greplist.txt
archive=/data/interface/mqfte/dataout/orders/archive/mqsiarchive/
cd $archive

if [ $# -gt 1 ]; then
  grep -w $2 $1* > $temp/greplist.txt
else
  grep -w $1 $DATE* > $temp/greplist.txt
fi


if [ -s $temp/greplist.txt ]; then 
  sourcefile=`awk -F ":" '{ print $1}' $temp/greplist.txt`
  cp $sourcefile $temp/
  chmod -R 777 $temp
else
  echo "WARNING: I can't locate the order, Please make sure the order's id is correct and try again."
fi

