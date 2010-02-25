#!/bin/bash
#Script to revert document to another version
#Usage: revert.sh [output path] [document UUID] [repository URL] [Working directory path] [version number in SVN]
echo Reverting document
echo ================================================
echo Document path: $1
echo Document UUID: $2
echo Repository URL: $3 
echo Working directory path: $4
echo ================================================
echo Version number to rebuild: $5
rm "$1"
echo ================================================
cd $4/
echo Changed directory to:
pwd
echo ================================================
rm -rf $4/$2/trunk
svn checkout -r$5 $3/$2/
echo ================================================
cd $4/$2/trunk/
echo Changed directory to:
pwd
echo ================================================
zip -rDX "$1" * -x *.svn*
echo ================================================