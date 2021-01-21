cmake_minimum_required(VERSION 3.16)

# #!/bin/bash
# # build OOoSVN from sourcefiles, as structured in SVN repo
# # Usage: sh buildscript [version]
# # eg.    sh buildscript 0.3.4

# # Remove existing files if they exist
# rm ooosvn-beta-$1.oxt
# rm ooosvn-command-line-only-$1.tar.gz

# cd extension


# The name of our project is "HELLO".  CMakeLists files in this project can
# refer to the root source directory of the project as ${HELLO_SOURCE_DIR} and
# to the root binary directory of the project as ${HELLO_BINARY_DIR}.
project (ooosvn)

# Recurse into the "Hello" and "Demo" subdirectories.  This does not actually
# cause another cmake executable to run.  The same process will walk through
# the project's entire directory structure.
add_subdirectory (extension)

# INSTALL(PROGRAMS shellscripts/commit.sh DESTINATION lib/${PROJECT_NAME})

SET(SOURCES commit import listdocuments listversions revert tag thumbnails userguide) 
FOREACH(source ${SOURCES})
  INSTALL(PROGRAMS shellscripts/${source}.sh DESTINATION lib/${PROJECT_NAME})
ENDFOREACH(source)

