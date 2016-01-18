# Download all Wikipedia version of input page starting from 
# January 1st of the specified input year. The downloaded dataset
# Is automatically compressed with 7-Zip
#
# usage: wiki_get.sh <page> <start_year> <output_file_name>
#
# File "output_file_name.7z" is created. The file contains several data dumps, 
# each containing 1K page versions (except possibly the last).
#
# Note: to download ALL versions of the page, use start_year=0
#
# Example: download all versions of the "Data compression" wikipedia page
#
# wiki_get.sh Data_compression 0 output.xml

page=$1
year_start=$2
outfile=$3

rm $outfile.7z

echo "Downloading all Wikipedia version of page "$page
echo "output file: "$outfile

start_timestamp=$year_start-01-01T00:00:00Z

tot_rev=0

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
		#append to archive

		echo "adding file "dump_$start_timestamp.xml" to archive"

		zcat current_dump.gz > dump_$start_timestamp.xml
		7z u $outfile.7z dump_$start_timestamp.xml
	
		#count how many revisions have been added
		rev=`cat dump_$start_timestamp.xml | grep \<timestamp\> | wc -l`
		tot_rev=$((tot_rev+rev))
	
		echo "added "$rev" revisions"

		rm dump_$start_timestamp.xml

	fi	

	rm current_dump.gz

done

echo ""
echo "Number of downloaded revisions: "$tot_rev


