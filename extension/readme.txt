Requirements:
- OOo 1.1 or later, tested with 2.x and 3.0.0
- Subversion 1.3 or greater, latest stable version is recommended.
- svnadmin, svnlook, zip, unzip, sed

Installation:
This is BETA, use with caution.  This version is much tougher than previous
versions so the only chance for losing work with this version is if there is a
problem with one of the underlying programs, all of which are pretty mature and
are trusted by many thousands of people.

This ZIP file is now the extension, unlike with older versions.  Installation
should be more straight forward.

1. Install the ooosvn-0.3.9.zip package using OOo's package manager, Tools >
Package Manager (Extension Manager after 2.1) .  This will install the BASIC
modules and will give you the SVN menu.

2. If doing an upgrade it is strongly recommended that you run Tools > Add-Ons >
Install OOoSVN scripts to upgrade the scripts.  If this is a fresh install, use
SVN > Place document under version control for the first time and your home
repository, working directory and shell scripts will be created for you by the
new wizard.

Use:
The SVN menu gives all of the options to carry out on a document.  They're fairly safe
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

Thanks:
Yuval Aviel, Richard Bos, everyone who has reported bugs and tested
