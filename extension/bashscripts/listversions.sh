#!/bin/bash
#Script to list all revisions of a document in SVN
#Usage: listversions.sh [document UUID] [repository URL] [Working directory path]
echo Listing Versions
echo ================================================
echo Document UUID: $1 
echo Repository URL: $2 
echo Working directory path: $3
echo ================================================
if test -d "$3/$1/" 		# test that directory exists
	then echo "$3/$1/" found		# confirmation of directory existence
else
	# Error that file doesn't exist and exit
	echo Fatal error!
	echo "$3/$1/" not found
	echo Document versions can not be generated
	echo ================================================
	exit
fi

if test -d "$3/$1/versions" 		# test that directory exists
  echo Flushing version number cache
  then rm -rf "$3/$1/versions" 		# delete the version directory
fi

mkdir "$3/$1/versions/"

if test -d "$3/$1/versions" 		# test that directory exists
	then echo "$3/$1/versions" created		# confirmation of directory existence
else
	# Error that file doesn't exist and exit
	echo Fatal error!
	echo "$3/$1/versions" not created
	echo Document versions can not be generated
	echo ================================================
	exit
fi
echo ================================================
echo Versions found: 
count=0

for version in `svn log -q $2/$1 | grep r | cut -c2- | cut -d' ' -f1`
do
  echo $version > "$3/$1/versions/$version.version"
  echo $version
  # Do timestamps
  timestamp=`svn log "$2/$1/" | grep r$version | cut -c14-33 | sed s/-//g | sed s/' '//g | sed s/:// | sed s/:/./`
  touch -t $timestamp "$3/$1/versions/$version.version"
  count=$((count+1))
done
echo ================================================
echo $count versions found
echo ================================================