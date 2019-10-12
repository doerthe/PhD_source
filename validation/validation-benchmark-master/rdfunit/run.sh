#!/bin/bash

INPUT_FOLDER="./data"
CACHE=$(pwd)/cache2

for t in 10 100 1000 10000 100000 1000000
do
	for s in foaf geo dbo skos owl dcterms prov frbrer lgdo isbd gsp mads ngeo
	do
		shopt -s nullglob
		for f in "$INPUT_FOLDER""$t"/"$s"/*.nt
		do
			STARTTIME=$(date +%s%3N)
			echo $f
			b=$(basename $f)
			ss=`echo $s | tr - ,`

			docker run -v $INPUT_FOLDER:/data \
			-v $CACHE:/RDFUnit/data \
			-it --rm yourname/rdfunit -u /data/$t/$s/$b -d http://www.google.com -s $ss -o ttl
			ENDTIME=$(date +%s%3N)
			ERRORCOUNT=`sed '/rut:resultCount/!d' $CACHE/results/www.google.com.aggregatedTestCaseResult.ttl | sed -e 's/[^0-9]//g' | awk '{s+=$1} END {print s}'`
			echo "$t,$s,$f,$(($ENDTIME - $STARTTIME)),$ERRORCOUNT" >> rdfunit-combo3.csv
			cp $CACHE/results/www.google.com.aggregatedTestCaseResult.ttl "$f".rdfunit-results.ttl
		done
	done
done

