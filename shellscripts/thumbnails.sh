#!/bin/bash

for version in `svn log -q $3/$2 | grep r | cut -c2- | cut -d' ' -f1`
do
svn checkout -r$version $3/$2/trunk/Thumbnails/ $4/$2/preview/.$version/
mv $4/$2/preview/.$version/thumbnail.png $4/$2/preview/$version.png >> $4/$2/preview/log.txt
rm -rf $4/$2/preview/$version/
done