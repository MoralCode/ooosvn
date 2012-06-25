#!/bin/bash
#Script to carry out listing of all valid OpenDocument files in a path which are not in OOoSVN.
#Usage: bulklist.sh [path] [OOoSVN working directory]

# list all writable files with correct extensions recursively, minus .ooosvn/
cd "$2"
echo ================================================
echo "Generating OpenDocument file list for:"
echo "$1"
echo ================================================

#remove leftover files
rm bulklist.txt
rm bulklist2.txt
echo Listing any invalid files:
find "$1" -xtype f -perm -u=w -iname '*.odt' -not -path "*.ooosvn*" -o -perm -u=w -iname '*.ods' -not -path "*.ooosvn*" -o -perm -u=w -iname '*.odp' -not -path "*.ooosvn*" -o -perm -u=w -iname '*.odb' -not -path "*.ooosvn*" -o -perm -u=w -iname '*.odg' -not -path "*.ooosvn*" -o -perm -u=w -iname '*.odf' -not -path "*.ooosvn*" > bulklist.txt

#set variables
a=0
already=0
broken=0
import=0

while read line
do a=$(($a+1));

### Reading DocumentUUID and seeing if this file is already under control
testmeta=`unzip -p "$line" meta.xml | grep "<meta:user-defined meta:name=\"DocumentUUID\">" | wc -l`

if [ $testmeta = "1" ]
then
docuUUID=`unzip -p "$line" meta.xml | awk '/<meta:user-defined meta:name=\"DocumentUUID\">/,/<\/meta:user-defined>/' | sed 's/\(.*\)\(<meta:user-defined meta:name=\"DocumentUUID\">\)\(.*\)\(<\/meta:user-defined>\)\(.*\)/\3/' | head -c36`
#echo $line already has a DocuUUID: $docuUUID
if [ -d ~/.ooosvn/$docuUUID/.svn/ ]
then
# the document UUID is already in the working directory so skip it
already=$(($already+1))
else
# there is a document UUID but it isn't in the working directory so list it
echo $line >> bulklist2.txt
fi

else
# file does not have a DocuUUID so check if it has a meta.xml
unzip -t "$line" meta.xml &> ziptemp.txt

if grep -q "cannot find zipfile directory in one of" ziptemp.txt
then
# not a valid zip file so we will skip this one
echo "$line does not appear to be a valid Zip file.  Skipping."
broken=$(($broken+1))
else

if grep -q "caution: filename not matched:  meta.xml" ziptemp.txt
then
# no meta.xml file so we will skip this one
echo $line does not contain meta.xml.  Skipping.
broken=$(($broken+1))
else
# there is a meta.xml so valid file for us to list
echo $line >> bulklist2.txt

fi
fi
fi

done < "bulklist.txt"

echo ================================================
echo "Total possible OpenDocument matches: $a"
echo "Invalid files: $broken"
echo "Already in OOoSVN: $already"
import=$((a-already-broken))
echo "Number of files to be imported: $import"
echo ================================================