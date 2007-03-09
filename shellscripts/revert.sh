#!/bin/bash
cd $4/

rm -rf $4/$2/trunk/
svn checkout -r$5 $3/$2/

cd $4/$2/trunk/
zip -rDX $1 * -x *.svn*