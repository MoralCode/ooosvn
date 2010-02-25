#!/bin/bash
#Script to commit changes to an updated document into SVN.
#Usage: commit.sh [document path] [document filename] [full repository URL] [working directory path] [commit comment]
echo Document Path: $1 
echo Document UUID: $2 
echo Repository URL: $3 
echo Working directory path: $4 
echo Commit comment: $5 
echo ================================================
if test -f "$1" 		# test that file exists
	then echo "$1" found		# confirmation of file existence
else
	echo "$1" not found.	# warn that file doesn't exist
fi
echo ================================================
rm -f $4/$2/trunk/Pictures/*
unzip -o "$1" -d $4/$2/trunk/ -x *.svn*
echo ================================================
cd $4/$2/trunk/
echo Changed directory to:
pwd
echo ================================================
svn status | grep ^\! | cut -c8- | xargs svn rm
svn status | grep ^\? | cut -c8- | xargs svn add
svn commit -m "$5"
echo ================================================
cd $4/
echo Changed directory to:
pwd
echo ================================================
svn checkout $3/$2/