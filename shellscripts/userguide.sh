#! /bin/bash
cd $1/

rm -rf $1/userguide
svn checkout https://svn.sourceforge.net/svnroot/ooosvn/userguide/

cd $1/userguide
zip -rDX ../userguide.odt * -x *.svn*