#!/bin/bash
#Script to commit changes to an updated document into SVN.
#Usage: commit.sh [document path] [document filename] [full repository URL] [working directory path] [commit comment]
echo Committing changes
echo ================================================
echo Document Path: $1 
echo Document UUID: $2 
echo Repository URL: $3 
echo Working directory path: $4 
echo Commit comment: $5 
echo ================================================
if test -f "$1" 		# test that file exists
	then echo "$1" found		# confirmation of file existence
else
	# Error that file doesn't exist and exit
	echo Fatal error!
	echo "$1" not found
	echo "Maybe the filename includes a forbidden character: & ; ( )"
	echo Commit aborted.
	echo ================================================
	exit
fi

if test -d "$4/$2" 		# test that working copy exists
	then echo Working copy "$4/$2" found		# confirmation of working copy existence
else
	# Error that working copy doesn't exist and exit
	echo Fatal error!
	echo Working copy "$4/$2" not found
	echo "Maybe the filename includes a forbidden character: & ; ( )"
	echo Commit aborted.
	echo ================================================
	exit
fi

echo ================================================
# remove pictures just in case they have been deleted from the document, this would otherwise cause bloating
rm -f $4/$2/trunk/Pictures/*
unzip -o "$1" -d $4/$2/trunk/ -x *.svn*
echo ================================================
cd $4/$2/trunk/
echo Changed directory to:
pwd
echo ================================================
# Deal with deleted and added files
svn status | grep ^\! | cut -c8- | xargs svn rm
svn status | grep ^\? | cut -c8- | xargs svn add
svn commit -m "$5"
echo ================================================
cd $4/
echo Changed directory to:
pwd
echo ================================================
svn checkout $3/$2/
echo ================================================
echo Working copy checked out
echo ================================================