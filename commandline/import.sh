#!/bin/bash
#Script to carry out initial import of document in SVN.
#Usage: import.sh [document path] [document filename] [full repository URL] [working directory path] [Document UUID to assign] [Optional Document UUID of parent document to make child document]
echo Document Path: $1 
echo Document filename: $2 
echo Repository URL: $3 
echo Working directory path: $4 
echo Document UUID: $5 
echo Parent Document UUID: $6
echo ================================================
mkdir -v $4/$5/
mkdir -v $4/$5/temp/
echo ================================================
if test -f "$1" 		# test that file exists
	then echo "$1" found		# confirmation of file existence
else
	echo "$1" not found.	# warn that file doesn't exist
fi
echo ================================================
unzip -o "$1" -d $4/$5/temp/ -x *.svn* # Spaces in filename fixed
cd $4/$5/temp/
echo Changed directory to:
pwd
# Get and write repo UUID
repo_uuid=`svnlook uuid $4`

echo ================================================

if grep -q "<meta:user-defined meta:name=\"Repository-UUID\" meta:value-type=\"string\">" meta.xml
# in case of 0.3 repo format
then
echo Updating repository UUID version 0.3 to 0.4
txtold="<meta:user-defined meta:name=\"RepositoryUUID\" meta:value-type=\"string\">.\{36\}<\/meta:user-defined>"
txtnew="<meta:user-defined meta:name=\"RepositoryUUID\">$repo_uuid<\/meta:user-defined>"
sed -i s/"$txtold"/"$txtnew"/ meta.xml

elif grep -q "<meta:user-defined meta:name=\"RepositoryUUID\">" meta.xml
# in case of 0.4 repo format
then
echo Updating Repository UUID: $repo_uuid
txtold="<meta:user-defined meta:name=\"RepositoryUUID\">.\{36\}<\/meta:user-defined>"
txtnew="<meta:user-defined meta:name=\"RepositoryUUID\">$repo_uuid<\/meta:user-defined>"
sed -i s/"$txtold"/"$txtnew"/ meta.xml

else
echo Inserting Repository UUID: $repo_uuid
txtold="<\/office:meta>"
txtnew="<meta:user-defined meta:name=\"RepositoryUUID\">$repo_uuid<\/meta:user-defined><\/office:meta>"
sed -i s/"$txtold"/"$txtnew"/ meta.xml

fi

if grep -q "<meta:user-defined meta:name=\"DocumentUUID\">" meta.xml

then
echo Updating Document UUID: $5
txtold="<meta:user-defined meta:name=\"DocumentUUID\">.\{36\}<\/meta:user-defined>"
txtnew="<meta:user-defined meta:name=\"DocumentUUID\">$5<\/meta:user-defined>"
sed -i s/"$txtold"/"$txtnew"/ meta.xml

else
echo Inserting Document UUID: $5
txtold="<\/office:meta>"
txtnew="<meta:user-defined meta:name=\"DocumentUUID\">$5<\/meta:user-defined><\/office:meta>"
sed -i s/"$txtold"/"$txtnew"/ meta.xml
fi

###ParentUUID processing

if grep -q "<meta:user-defined meta:name=\"ParentUUID\">" meta.xml

then
echo Updating Parent UUID: $6
txtold="<meta:user-defined meta:name=\"ParentUUID\">.\{36\}<\/meta:user-defined>"
txtnew="<meta:user-defined meta:name=\"ParentUUID\">$6<\/meta:user-defined>"
sed -i s/"$txtold"/"$txtnew"/ meta.xml

else
echo Inserting Parent UUID: $6
txtold="<\/office:meta>"
txtnew="<meta:user-defined meta:name=\"ParentUUID\">$6<\/meta:user-defined><\/office:meta>"
sed -i s/"$txtold"/"$txtnew"/ meta.xml

fi

###Document name processing

if grep -q "<meta:user-defined meta:name=\"DocName\">" meta.xml

then
echo Updating Document Name: $2
txtold="<meta:user-defined meta:name=\"DocName\">\([^<][^<]*\)<\/meta:user-defined>"
txtnew="<meta:user-defined meta:name=\"DocName\">$2<\/meta:user-defined>"
sed -i s/"$txtold"/"$txtnew"/ meta.xml

else
echo Inserting Document Name: $2
txtold="<\/office:meta>"
txtnew="<meta:user-defined meta:name=\"DocName\">$2<\/meta:user-defined><\/office:meta>"
sed -i s/"$txtold"/"$txtnew"/ meta.xml

fi

# delete junk tags
txtold="<meta:user-defined meta:name=\"RepositoryUUID\"\/>"
sed -i s/"$txtold"// meta.xml
txtold="<meta:user-defined meta:name=\"DocumentUUID\"\/>"
sed -i s/"$txtold"// meta.xml
txtold="<meta:user-defined meta:name=\"ParentUUID\"\/>"
sed -i s/"$txtold"// meta.xml
txtold="<meta:user-defined meta:name=\"DocName\"\/>"
sed -i s/"$txtold"// meta.xml

echo updated metadata
echo ================================================
# Import
svn import . $3/$5/trunk/ -m 'Initial Import'
rm -rf $4/$5/temp/
cd $4/
echo Changed directory to:
pwd
svn checkout $3/$5/
cd $4/$5/trunk/
echo Changed directory to:
pwd
pwd=`pwd`
if [ $pwd != "${4}/${5}/trunk" ]
then
echo "Error: Working copy is not where it should be!"
echo "Most likely cause is disallowed characters in document filename."
exit
fi
echo Changed directory to:
pwd
echo ================================================
zip -rDX "$1" * -x *.svn*