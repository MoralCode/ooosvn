#!/bin/bash
mkdir $4/$2/
mkdir $4/$2/temp/

unzip -o $1 -d $4/$2/temp/ -x *.svn*
cd $4/$2/temp/

# Get and write repo UUID
repo_uuid=`svnlook uuid $4`

txtold="<meta:user-defined meta:name=\"Info 1\"\/>"
#echo $txtold
txtnew="<meta:user-defined meta:name=\"Repository-UUID\">$repo_uuid<\/meta:user-defined>"
#echo $txtnew
#echo s/"$txtold"/"$txtnew"/g
sed s/"$txtold"/"$txtnew"/g meta.xml > meta2.xml
mv meta2.xml meta.xml

# Import
svn import . $3/$2/trunk/ -m 'Initial Import'

rm -rf $4/$2/temp/
cd $4/
svn checkout $3/$2/

cd $4/$2/trunk/
zip -rDX $1 * -x *.svn*