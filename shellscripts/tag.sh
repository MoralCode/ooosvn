#!/bin/bash
unzip -o $1 -d $4/$2/trunk/ -x *.svn*
svn mkdir $4/$2/$5
cd $4/$2/trunk/

svn status | grep ^\! | cut -c8- | xargs svn rm

svn status | grep ^\? | cut -c8- | xargs svn add

cd $4/$2/

svn copy trunk $5/$6 #-m '$7'
svn commit -m '$7' tags/