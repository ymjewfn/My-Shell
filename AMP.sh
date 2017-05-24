now=`date "+%Y.%m.%d"`
sumlogfile=`ls /usr/WebSphere/CommerceServer/logs/prop_$now* | tail -1`
datalogfile=`ls /usr/WebSphere/CommerceServer/logs/stagingprop_$now* | tail -1`
FHlogfile=`ls /usr/WebSphere/CommerceServer/instances/halfls/etl/extract/staging/logs/FredhopperLive-201* | tail -1`

echo "The following information for Data propagation"
echo "=============================================="
echo "tail -f $datalogfile"
echo "=============================================="
echo "The following information for FH propagation"
echo "=============================================="
echo "tail -f $FHlogfile"
echo "=============================================="
echo "The following information for sum log of propagation"
echo "=============================================="
tail -f $sumlogfile
