#!/bin/bash
#Script to list all documents within a working dir
#Usage: listdocuments.sh [working directory path]
echo "Listing Documents in $1"
echo ================================================
mkdir $1/documentlist/
count = 0
for document in `find $1 -maxdepth 2 -mindepth 2 -iname trunk | cut -d'/' -f5`
do
svn >> $1/documentlist/$document
count=$((count+1))
done
echo $count found
echo ================================================