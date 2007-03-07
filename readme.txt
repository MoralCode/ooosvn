Requirements:
- OOo 1.1 or later, tested with 2.0.2 and 2.1
- Subversion.  Tested with 1.3 and 1.4, latest stable version is recommended.
- svnadmin, svnlook, zip, unzip

Installation:
This is BETA, use with caution.  This version is much tougher than previous
versions so the only chance for losing work with this version is if there is a
problem with one of the underlying programs, all of which are pretty mature and
are trusted by many thousands of people.

The package is now installed as an extension within this ZIP file.

1. The repository and working directory this extension uses is ~/.ooosvn, Create
the directory, then create the repository from the command line:

$ svnadmin create --fs-type fsfs [path]

where path is in the form /path/to/repository, on mine:
/home/ed/.ooosvn.  This needs to be correct or else
the whole system won't work.  If this doesn't work you probably have a problem
with SVN.  If you need to read up on subversion the guide is available here:
http://svnbook.red-bean.com/nightly/en/index.html

2. Extract the shellscripts (.sh files) in this ZIP into the root of your
repository, eg ~/.ooosvn.

3. Install the ooosvn-0.3.2.zip package using OOo's package manager, Tools >
Package Manager (Extension Manager after 2.1) .  This will install the BASIC
module and will give you the SVN menu.

Use:
The SVN menu gives all of the options to carry out on a document.  They're safe
in this version.

If you want to automate use of OOoSVN, assign the macros OnSavedSVN and
OnSavedAsSVN to the Saved and Saved As events (note past participle).  This is
not done automatically as most users will still only want to try this out and
I'm not sure the OOo extensions format allows for macros to be assigned to
events on installation.

Todo:
Yeah, proper documentation.
Loads of other things.

OOoSVN is now on Sourceforge:
http://sourceforge.net/projects/ooosvn/
Please report bugs and submit feature requests to the bug/feature trackers
available there.  Also do check for updated documentation and new releases.  If
you are interested in contributing, let me know.

This is still **very much under development**.
