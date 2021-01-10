#!/bin/bash

cd wikiextractor/wikiextractor

python3 -m WikiExtractor ../../kawiki-latest-pages-articles.xml.bz2 --processes 8 -q -o - \
| sed "/^\s*\$/d" \
| grep -v "^<doc id=" \
| grep -v "</doc>\$" \
> ../../kawiki-latest-pages-articles.txt
echo "Succesfully extractied and cleaned ../../kawiki-latest-pages-articles.xml.bz2 to ../../kawiki-latest-pages-articles.txt"

