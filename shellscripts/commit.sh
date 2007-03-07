#! /bin/bash

rm -f $4/$2/trunk/Pictures/*
#rm -rf $4/$2/trunk/*
unzip -o $1 -d $4/$2/trunk/ -x *.svn*
cd $4/$2/trunk/

svn status | grep ^\! | cut -c8- | xargs svn rm

svn status | grep ^\? | cut -c8- | xargs svn add

svn commit -m "$5"

cd $4/
svn checkout $3/$2/

#cd $4/$2/trunk/
#zip -rDX $1 * -x *.svn*