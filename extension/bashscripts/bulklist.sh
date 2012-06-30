#!/bin/bash
#Script to carry out listing of all valid OpenDocument files in a path which are not in OOoSVN.
#Usage: bulklist.sh [path] [OOoSVN working directory] [Filetypes] [Excludes]
# Filetypes: any number of t, s, p, g, b or f, each matching an ODF type, eg. 't' for .odt.
# Excludes: any number of s or h, s to exclude subdirectories (non-recursive), h to exclude hidden files and directories
# Example: 'sh bulklist.sh tspgbf sh' will search for *.odt, *.ods, *.odp, *.odg, *.odb and *.odf files, non-recursively, without hidden files or directories

# list all writable files with correct extensions recursively, minus .ooosvn/
cd "$2"
echo ================================================
echo "Generating OpenDocument file list for:"
echo "$1"
echo ================================================
echo File types:
# Extract the file types specified and put together the find parameters

filetypes=""
odt=""

if [[ "$3" == *t* ]]
  then
  echo .odt - OpenDocument Text
  filetypes=${filetypes}"-iname \"*.odt\""
fi

if [[ "$3" == *s* ]]
  then
  echo .ods - OpenDocument Spreadsheet
  filetypes=${filetypes}" -o -iname \"*.ods\""
fi

if [[ "$3" == *p* ]]
  then
  echo .odp - OpenDocument Presentation
  filetypes=${filetypes}" -o -iname \"*.odp\""
fi

if [[ "$3" == *g* ]]
  then
  echo .odg - OpenDocument Graphics
  filetypes=${filetypes}" -o -iname \"*.odg\""
fi

if [[ "$3" == *b* ]]
  then
  echo .odb - OpenDocument Database
  filetypes=${filetypes}" -o -iname \"*.odb\""
fi

if [[ "$3" == *f* ]]
  then
  echo .odf - OpenDocument Formula
  filetypes=${filetypes}" -o -iname \"*.odf\""
fi

# Tidy up the filetypes string

if [[ "$filetypes" == " -o "* ]]
  then
  filetypes2=${filetypes:4}
else
  filetypes2=$filetypes
fi

echo ================================================
echo Exclusions:
# Extract recursive and hidden options from the command line parameters

recursive=""

if [[ "$4" == *s* ]]
  then
  echo Subdirectories - Search will be non-recursive
  recursive="-maxdepth 1"
fi

hidden=""

if [[ "$4" == *h* ]]
  then
  echo Hidden files and directories
  hidden=" ! -iname \".*\" \) \( ! -path \"*/.*\" \)"
  else
  hidden="\) \( ! -path \"*.ooosvn*\" \)"
fi

echo ================================================

#remove leftover files
rm bulklist.txt &> /dev/null
rm bulklist2.txt &> /dev/null
echo "Listing any invalid files, check to see if they are corrupt:"

# Echo the parameters to find.  Messy but the best way to get all characters mangled correctly!
echo "$1" "$recursive" -perm -u=w -xtype f '\('  "$filetypes2" "$hidden" | xargs find > bulklist.txt

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