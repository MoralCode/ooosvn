#! /bin/bash

mkdir $1/documentlist/

for document in `find $1 -maxdepth 2 -mindepth 2 -iname trunk | cut -d'/' -f5`
do
svn >> $1/documentlist/$document
#svn >> $1/documentlist/log.txt
done