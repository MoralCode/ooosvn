#!/bin/bash
#Script to list all revisions of a document in SVN
#Usage: listversions.sh [document UUID] [repository URL] [Working directory path]
echo Listing Versions
echo ================================================
echo Document UUID: $1 
echo Repository URL: $2 
echo Working directory path: $3
echo ================================================
mkdir $3/$1/versions/
echo Versions found: 
for version in `svn log -q $2/$1 | grep r | cut -c2- | cut -d' ' -f1`
do
svn >> $3/$1/versions/$version.version
echo $version
done
echo ================================================