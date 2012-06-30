#!/bin/bash
#Script to list all documents within a working dir
#Usage: listdocuments.sh [working directory path]
echo "Listing Documents in $1"
echo ================================================
if test -d "$1/documentlist/" 		# test that directory exists
  then echo Flushing document list cache # Flush the documentlist cache
  rm -rf "$1/documentlist/"
fi
mkdir "$1/documentlist/"

# List all directories that match the OOoSVN structure
for documentdir in `find $1 -maxdepth 2 -mindepth 2 -iname .svn | cut -d'/' -f5`
do

# First check that content.xml exists.  If it doesn't then this is by definition NOT a valid file so we will skip
if test -f "$1/$documentdir/trunk/content.xml"
  then
### Reading DocName
if test -f "$1/$documentdir/trunk/meta.xml" 		# test that meta exists
  then
  testmeta=`grep "<meta:user-defined meta:name=\"DocName\">" "$1/$documentdir/trunk/meta.xml" | wc -l`

  if [ $testmeta = "1" ]
    then
    docname=`awk '/<meta:user-defined meta:name=\"DocName\">/,/<\/meta:user-defined>/' "$1/$documentdir/trunk/meta.xml" | sed 's/\(.*\)\(<meta:user-defined meta:name=\"DocName\">\)\(.*\)\(<\/meta:user-defined>\)\(.*\)/\3/' | sed 's/\(.*\)\..*/\1/'`
    docname="${docname}-"
  else
  docname=""
fi
fi

# Remove document extensions from 0.3 files
documentdir2=`echo "$documentdir" | sed 's/\(.*\)\..*/\1/'`

# Document extension detection
docext=""
if test -f "$1/$documentdir/trunk/mimetype"
then

mimetype=""
mimetype=`grep application/vnd "$1/$documentdir/trunk/mimetype"`
# OpenDocument mimetypes
if [[ $mimetype == "application/vnd.oasis.opendocument.text" ]]
then
docext=".odt"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.spreadsheet" ]]
then
docext=".ods"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.presentation" ]]
then
docext=".odp"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.graphics" ]]
then
docext=".odg"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.chart" ]]
then
docext=".odc"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.formula" ]]
then
docext=".odf"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.image" ]]
then
docext=".odi"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.text-master" ]]
then
docext=".odm"
fi
if [[ $mimetype == "application/vnd.sun.xml.base" ]]
then
docext=".odb"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.base" ]]
then
docext=".odb"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.database" ]]
then
docext=".odb"
fi
# ODF templates
if [[ $mimetype == "application/vnd.oasis.opendocument.text-template" ]]
then
docext=".ott"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.spreadsheet-template" ]]
then
docext=".ots"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.presentation-template" ]]
then
docext=".otp"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.graphics-template" ]]
then
docext=".otg"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.chart-template" ]]
then
docext=".otc"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.formula-template" ]]
then
docext=".otf"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.image-template" ]]
then
docext=".oti"
fi
if [[ $mimetype == "application/vnd.oasis.opendocument.text-web" ]]
then
docext=".oth"
fi
# OOo 1.x .sx* support
if [[ $mimetype == "application/vnd.sun.xml.writer" ]]
then
docext=".sxw"
fi
if [[ $mimetype == "application/vnd.sun.xml.calc" ]]
then
docext=".sxc"
fi
if [[ $mimetype == "application/vnd.sun.xml.impress" ]]
then
docext=".sxi"
fi
if [[ $mimetype == "application/vnd.sun.xml.draw" ]]
then
docext=".sxd"
fi
if [[ $mimetype == "application/vnd.sun.xml.math" ]]
then
docext=".sxm"
fi
if [[ $mimetype == "application/vnd.sun.xml.text-master" ]]
then
docext=".sxg"
fi
# OOo 1.x .st* templates
if [[ $mimetype == "application/vnd.sun.xml.writer.template" ]]
then
docext=".stw"
fi
if [[ $mimetype == "application/vnd.sun.xml.calc.template" ]]
then
docext=".stc"
fi
if [[ $mimetype == "application/vnd.sun.xml.impress.template" ]]
then
docext=".sti"
fi
if [[ $mimetype == "application/vnd.sun.xml.draw.template" ]]
then
docext=".std"
fi
if [[ $mimetype == "application/vnd.sun.xml.writer.web" ]]
then
docext=".stw"
fi
fi


# now write out the documentlink
echo "$documentdir" > "$1/documentlist/$docname$documentdir2$docext"
# find the date
timestamp=`svn info "$1/$documentdir/" | grep 'Last Changed Date' | cut -c20-38 | sed s/-//g | sed s/' '//g | sed s/:// | sed s/:/./`
touch -t $timestamp "$1/documentlist/$docname$documentdir2$docext"
fi

done
count=`ls -l "$1/documentlist" | wc -l`
echo $((count-1)) documents found
echo ================================================