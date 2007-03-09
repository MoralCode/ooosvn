#!/bin/bash

mkdir $4/$2/versions/

for version in `svn log -q $3/$2 | grep r | cut -c2- | cut -d' ' -f1`
do
svn >> $4/$2/versions/$version.version
#svn >> $4/$2/versions/log.txt
done