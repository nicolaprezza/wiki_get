# Download all Wikipedia version of input page starting from 
# January 1st of input year.
#
# usage: wiki_get.sh <page> <start_year> <output_file_name>
#
# Note: to download ALL versions of the page, use start_year=0
#
# Example: download all versions of the "Data compression" wikipedia page
#
# wiki_get.sh Data_compression 0 output.xml

page=$1
year_start=$2
outfile=$3

rm $outfile

echo "Downloading all Wikipedia version of page "$page
echo "output file: "$outfile

start_timestamp=$year_start-01-01T00:00:00Z

while [ "$start_timestamp" != "" ]
do

	echo ""
	echo "*** Current timestamp: "$start_timestamp
	echo ""

	url=\&pages=$page
	url=$url\&offset=$start_timestamp
	url=$url\&action=submit
	url=$url\&limit=1000

	#download 1000 revisions starting from last timestamp
	curl -d "$url" http://en.wikipedia.org/w/index.php?title=Special:Export -o "current_dump.gz" -H 'Accept-Encoding: gzip,deflate'
		
	#get last timestamp
	start_timestamp=`zcat current_dump.gz | grep \<timestamp\> | cut -d'>' -f 2 | cut -d'<' -f 1 | tail -n 1`

	if [ "$start_timestamp" = "" ]
	then
		echo "No more records. Search terminated."
	else
		#append to archive and remove temporary dump
		zcat current_dump.gz >> $outfile
	fi	

	rm current_dump.gz

done

echo ""
echo "Number of downloaded revisions: "`cat $outfile | grep \<timestamp\> | wc -l`


