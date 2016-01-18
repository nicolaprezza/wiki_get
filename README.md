wiki_get: Download all versions of a Wikipedia page
===============
Author: Nicola Prezza
mail: nicola.prezza@gmail.com

### Description

A simple script to download all versions of a Wikipedia page starting from a given year. Wikipedia has a limit of 1000 versions starting from a given timestamp (https://www.mediawiki.org/wiki/Manual:Parameters_to_Special:Export#cite_note-historynote-2). This script downloads iteratively ALL versions (1000 at a time) of the page by performing POST requests until no more data is returned.

### Usage 

> wiki_get.sh   page start_year   output_file_name

To download ALL versions of the page, use start_year=0

### Example

To download all versions of the "Data compression" wikipedia page, call:

> wiki_get.sh Data_compression 0 output.xml
