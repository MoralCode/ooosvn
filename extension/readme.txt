Requirements:
- A Unix/Linux system.  OOoSVN will not work under Windows as yet.  MacOSX has
been reported as working if the required packages are installed but is
unsupported as I don't have a Mac to test on.
- OOo 2.3.0 or later or LibreOffice, tested with LibreOffice 3.5.4.  Problems
have previously been found using OOoSVN under go-OOo.
- Subversion 1.3 or greater, latest stable version is recommended.
- bash, coreutils, findutils, zip, unzip, grep, awk, sed 4.0

Installation:
This is BETA, use with caution.

The OOoSVN is available for download as an .oxt file.  This is the
OpenOffice.org extension format.  Use of the .oxt format eases installation a
lot:

1. Install the ooosvn-0.4.2.oxt package using OOo's package manager, Tools >
Extensions.  This will install the BASIC modules and will give you the SVN menu.
 With OOo 2.4 or later and OOoSVN 0.3.10 or later, the extension can be updated
from within the Package Manager, including by checking packages against the OOo
Extensions repository.

2. If doing an upgrade it is STRONGLY RECOMMENDED that you run Tools > Add-Ons >
Install OOoSVN scripts to upgrade the scripts in the working directory.  If this
is a fresh install, use SVN > Place document under version control for the first
time and your home repository, working directory and shell scripts will be
created for you by the first run wizard.

Use:
Installing the .oxt package gets you an SVN menu in OOo.  From this menu you can
access all of the functionality of OOoSVN.

Some understanding of the basic concepts of SVN are advised before using this
software.

- Place Document Under Version Control - Imports the current document to SVN.

- Commit changes - Commit saved changes to the current document into SVN.

- Active version info - gives output of svn info on the working copy of the
current document, plus some additional information.

- Document log - gives svn log on current document.

- Compare with older/newer version - Uses the OOo 'compare documents' feature to
graphically compare the working copy of the document with any other in SVN.

- Revert to older/newer version - Roll back/forwards to another version of the
current document.

- Graphically browse versions and revert - makes use of the thumbnail files in
ODF files to present a set of views of each revision of a document, allowing you
to select by visual features.

- Recover lost document - Generates a list of every document in the working
directory, allowing any previous version of any document previously checked into
OOoSVN to be pulled back.

- Bulk import - provides a wizard to recursively search and import ODF files of
different types on your computer in bulk.  The easiest way to get working with
OOoSVN straightaway.

- View last operation log - Provides feedback on the last SVN operation.  Useful
for troubleshooting.

- If you want to automate use of OOoSVN, assign the macros OnSavedSVN and
OnSavedAsSVN to the 'Document has been Saved' and 'Document has been Saved As'
events (note past participle) in Tools > Customise > Events.  This is not done
automatically as most users will still only want to try this out and I'm not
sure the OOo extensions format allows for macros to be assigned to events on
installation.

Todo:
Yeah, proper documentation.
Loads of other things.

OOoSVN is now on Sourceforge:
http://sourceforge.net/projects/ooosvn/
Please report bugs and submit feature requests to the bug/feature trackers
available there.  Also do check for updated documentation and new releases.  If
you are interested in contributing, let me know.

This is still **very much under development**.

Thanks:
Yuval Aviel, Richard Bos, everyone who has reported bugs and tested
