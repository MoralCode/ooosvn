#!/bin/bash
#Script to generate version thumbnails for a document
#Usage: thumbnails.sh [document file name] [repository URL] [Working directory path]
echo Generating thumbnails
echo ================================================
echo Document UUID: $1 
echo Repository URL: $2 
echo Working directory path: $3
echo ================================================
echo Versions found: 
for version in `svn log -q $2/$1 | grep r | cut -c2- | cut -d' ' -f1`
do
svn checkout -q -r$version $2/$1/trunk/Thumbnails/ $3/$1/preview/.$version/
mv $3/$1/preview/.$version/thumbnail.png $3/$1/preview/$version.png >> $3/$1/preview/log.txt
rm -rf $3/$1/preview/$version/
echo $version
done
echo ================================================