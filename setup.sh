#!/bin/sh
set -e

LG=$1
WIKI_DUMP_NAME=${LG}wiki-latest-pages-articles.xml.bz2
WIKI_DUMP_DOWNLOAD_URL=https://dumps.wikimedia.org/${LG}wiki/latest/$WIKI_DUMP_NAME
WIKI_OUT_FILE=${LG}wiki-latest-pages-articles.txt

# download latest Wikipedia dump in chosen language
echo "Downloading the latest $LG-language Wikipedia dump from $WIKI_DUMP_DOWNLOAD_URL..."
wget -c $WIKI_DUMP_DOWNLOAD_URL
echo "Succesfully downloaded the latest $LG-language Wikipedia dump to $WIKI_DUMP_NAME"

cd wikiextractor/wikiextractor

python3 -m WikiExtractor ../../${WIKI_DUMP_NAME} --processes 8 -q -o - \
| sed "/^\s*\$/d" \
| grep -v "^<doc id=" \
| grep -v "</doc>\$" \
> ../../$WIKI_OUT_FILE
echo "Succesfully extractied and cleaned ../../$WIKI_DUMP_NAME to ../../$WIKI_OUT_FILE"

cd ../../
mkdir -p data/whole-data data/marketer-articles
python utils.py
rm $WIKI_OUT_FILE $WIKI_DUMP_NAME

wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1byXIbnkZFDpTpRz1jVMbPtp0ELptuQ51' -O data/marketer-articles/articles.csv

