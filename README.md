wiki_get: Download all versions of a Wikipedia page
===============
Author: Nicola Prezza
mail: nicola.prezza@gmail.com

### Description

A simple script to download all versions of a Wikipedia page. Wikipedia has a download limit of 1000 versions starting from a given timestamp (https://www.mediawiki.org/wiki/Manual:Parameters_to_Special:Export). This script downloads iteratively ALL versions (1000 at a time) of the page by performing POST requests until no more data is returned. All versions are added to an archive automatically compressed with 7-Zip.

### Usage 

> wiki_get.sh page

### Example

To download all versions of the "Data compression" wikipedia page, call:

> wiki_get.sh Data_compression
