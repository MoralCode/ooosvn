#!/bin/bash
#Script to revert document to another version
#Usage: revert.sh [output path] [document UUID] [repository URL] [Working directory path] [version number in SVN]
echo Reverting document
echo ================================================
echo Document output path: $1
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
if test -d "$4/$2/trunk" 		# test that directory exists
	then echo "$4/$2/trunk/" found		# confirmation of directory existence
else
	# Error that file doesn't exist and exit
	echo Fatal error!
	echo "$4/$2/trunk/" not found
	echo Document can not be reverted
	echo ================================================
	exit
fi
cd $4/$2/trunk/
echo Changed directory to:
pwd
echo ================================================
zip -rDX "$1" * -x *.svn*
echo ================================================
