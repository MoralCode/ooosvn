#!/bin/bash
# build OOoSVN from sourcefiles, as structured in SVN repo
# Usage: sh buildscript [version]
# eg.    sh buildscript 0.3.4

# Remove existing files if they exist
rm ooosvn-beta-$1.oxt
rm ooosvn-command-line-only-$1.tar.gz

cd extension

# Write version number to description.xml
txtold="<version value=\".*\"\/>"
echo $txtold
txtnew="<version value=\"$1\"\/>"
echo $txtnew
sed s/"$txtold"/"$txtnew"/g description.xml > description2.xml
mv description2.xml description.xml

zip -rDX ../ooosvn-beta-$1.oxt * -x *.svn*
#For some reason I can't get file exclusion working with 7za, otherwise I'd use it for smaller file sizes

# The .tar.gz command line only version
cd bashscripts
# Copy the gpl across
cp ../gpl.txt gpl.txt
tar -pczf ../../ooosvn-command-line-only-$1.tar.gz *.sh *.txt
# Remove the GPL again, it doesn't need to be duplicated in the tree.
rm gpl.txt