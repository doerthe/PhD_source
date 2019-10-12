#!/bin/bash

ALL_ARGS=$1
RESULTS_FILE=$2
INPUT_FOLDER="./data"
TEMP_FOLDER=$(pwd)/tmp
CACHE=$(pwd)/cache1

mkdir -p $TEMP_FOLDER

echo $ALL_ARGS

IFS=',' read -a myarray <<< "$ALL_ARGS"

b=${myarray[0]}
t=${myarray[1]}
s=${myarray[2]}

STARTTIME=$(date +%s%3N)
ss="${s/-/,}"

docker run -v $INPUT_FOLDER:/data \
-v $TEMP_FOLDER:/results \
-v $CACHE:/usr/local/n3unit/resources \
-i --rm n3unit -i /data/$t/$ss/$b -s $s -o /results/$b-n3unit.ttl --count &> /dev/null

ENDTIME=$(date +%s%3N)
ERRORCOUNT=`sed '/:errorCount :count/!d' $TEMP_FOLDER/$b-n3unit.ttl | sed -e 's/[^0-9]//g'`
if [ -z "$ERRORCOUNT" ]; then
	ERRORCOUNT=0
fi
echo "$t,$s,$b,$(($ENDTIME - $STARTTIME)),$ERRORCOUNT" >> $RESULTS_FILE
cp $TEMP_FOLDER/$b-n3unit.ttl $INPUT_FOLDER/$t/$s/$b-n3unit.ttl
rm -f $TEMP_FOLDER/$b-n3unit.ttl

