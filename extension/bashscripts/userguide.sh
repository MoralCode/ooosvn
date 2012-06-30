#!/bin/bash
#Script toload user guide from development SVN repository
#Usage: userguide.sh [Working directory path] [repostitory URL that the userguide resides in]
cd $1/
echo Changed directory to:
pwd
rm -rf $1/userguide
svn checkout $2
cd $1/userguide
echo Changed directory to:
pwd
zip -rDX ../userguide.odt * -x *.svn*