#! /bin/bash
#Author by: Peter Gao(OTS team of salmon china)
#Date: 05/02/2013
#Purpose:Allow search of logs,archive logs,compressed logs and backup logs;
#Change Log:
#               Who             When            Why
#               Peter Gao       25.08.2014      basic version
#
. /home/wasuser/.bash_profile
incdir=`dirname $0`
inst=halflp
app=`cat $incdir/wasservers`
logdir="/usr/WebSphere/AppServer/profiles/$inst/logs"
weblogdir="/usr/WebSphere/CommerceServer/instances/$inst/httplogs"
bckupdir="/var/archive/backups/$inst"
webbckupdir="/var/archive/halfords/$inst/web"

if [ "$1" = "-web" ]; then
app=`cat $incdir/webwasservers`
fi

function printusage {
        echo " "
        echo "  Usage: $0 [-web|-app] <date> <searchString>"
        echo "  <date> is in the format YYYYMMDD and can use wildcards"
        echo " "
        echo " -app is the default choice and searches across System.out files on all app servers"
        echo " -web searches across all messages on the web servers "
        echo " If a date is specified it will also search across zipped logs for that date."
        exit -1
}
#set -x

mode="-app"
date=""

# Ensure the user enters 1-3 parameters only
if [ "$#"  -eq 0 -o "$#" -gt 3 ]; then
        printusage
# If the first parameter is the mode, ensure there is searchstring as well and set the date if 3 parameters
elif [ "$1" = "-web" -o "$1" = "-app" ]; then
        if [ "$#" -eq 1 ]; then
                printusage;
        fi
        mode="$1"
        if [ "$#" -eq 3 ]; then
                date="$2"
        fi
#If the first paramter is not the mode, there can only be 2 parameters
elif [ "$#" -gt 2 ]; then
        printusage
#If the first parameter is not the mode, and there are 2 paramters, the first is the date
elif [ "$#" -eq 2 ]; then
        date="$1"
fi

search="${@: -1}"
echo "Mode: $mode  Date: $date search: $search"
for app in $app ; do
        case "$mode" in
                '-app')
                        if [ "$date" == "" ]; then
                                ssh $app "cd $logdir ; grep -H \"${search}\" */SystemOut*.log"|sed -e "s/^/$app /g"
                        else 
                                ssh $app "cd $bckupdir ; zgrep -H \"${search}\" */SystemOut_*${date}*.log.gz" |sed -e "s/^/$app /g"
                        fi
                        ;;
                '-web')
                        if [ "$date" == "" ]; then
                                ssh $app "cd $weblogdir ; grep -H \"${search}\" access*log*"|sed -e "s/^/$app /g"
                        else
                                ssh $app "cd $webbckupdir ; zgrep -H \"${search}\" access*log.${date}*.gz" |sed -e "s/^/$app /g"
                        fi
                        ;;
        esac
done

exit
