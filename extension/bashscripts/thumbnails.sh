#!/bin/bash
#Script to generate version thumbnails for a document
#Usage: thumbnails.sh [document file name] [repository URL] [Working directory path]
echo Generating thumbnails
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
	echo Document thumbnails can not be generated
	echo ================================================
	exit
fi

if test -d "$3/$1/preview" 		# test that directory exists
  echo Flushing thumbnail cache
  then rm -rf "$3/$1/preview" 		# delete the version directory
fi

mkdir "$3/$1/preview/"

if test -d "$3/$1/preview" 		# test that directory exists
	then echo "$3/$1/preview" created		# confirmation of directory existence
else
	# Error that file doesn't exist and exit
	echo Fatal error!
	echo "$3/$1/preview" not created
	echo Document thumbnails can not be generated
	echo ================================================
	exit
fi
echo ================================================
echo Versions found:

count=0
for version in `svn log -q $2/$1 | grep r | cut -c2- | cut -d' ' -f1`
do
  svn checkout -q -r$version $2/$1/trunk/Thumbnails/ $3/$1/preview/.$version/
  mv $3/$1/preview/.$version/thumbnail.png $3/$1/preview/$version.png >> $3/$1/preview/log.txt
  rm -rf $3/$1/preview/$version/
  echo $version
  # Do timestamps
  timestamp=`svn log "$2/$1/" | grep r$version | cut -c14-33 | sed s/-//g | sed s/' '//g | sed s/:// | sed s/:/./`
  touch -t $timestamp "$3/$1/preview/$version.png"
  count=$((count+1))
done
echo ================================================
echo $count version thumbnails generated
echo ================================================