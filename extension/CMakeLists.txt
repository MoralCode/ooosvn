
# # Write version number to description.xml
# txtold="<version value=\".*\"\/>"
# echo $txtold
# txtnew="<version value=\"$1\"\/>"
# echo $txtnew
# sed s/"$txtold"/"$txtnew"/g description.xml > description2.xml
# mv description2.xml description.xml



#compress extension
# zip -rDX ../ooosvn-beta-$1.oxt * -x *.svn*
# #For some reason I can't get file exclusion working with 7za, otherwise I'd use it for smaller file sizes

# build The .tar.gz command line only version
# cd bashscripts
# # Copy the gpl across
# cp ../gpl.txt gpl.txt
# tar -pczf ../../ooosvn-command-line-only-$1.tar.gz *.sh *.txt
# # Remove the GPL again, it doesn't need to be duplicated in the tree.
# rm gpl.txt

SET(SOURCES commit import listdocuments listversions revert tag thumbnails userguide) 
FOREACH(source ${SOURCES})
  INSTALL(PROGRAMS shellscripts/${source}.sh DESTINATION lib/${PROJECT_NAME})
ENDFOREACH(source)