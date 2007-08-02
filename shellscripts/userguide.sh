#!/bin/bash
cd $1/

rm -rf $1/userguide
echo $2
svn checkout $2

cd $1/userguide
zip -rDX ../userguide.odt * -x *.svn*