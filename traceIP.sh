awk -F " " '{print $2}' $1 | awk -F: '{print $2}'
