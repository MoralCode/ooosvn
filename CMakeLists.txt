cmake_minimum_required(VERSION 3.16)

# The name of our project is "HELLO".  CMakeLists files in this project can
# refer to the root source directory of the project as ${HELLO_SOURCE_DIR} and
# to the root binary directory of the project as ${HELLO_BINARY_DIR}.
project (ooosvn)

# Recurse into the "Hello" and "Demo" subdirectories.  This does not actually
# cause another cmake executable to run.  The same process will walk through
# the project's entire directory structure.
add_subdirectory (shellscripts)

# INSTALL(PROGRAMS shellscripts/commit.sh DESTINATION lib/${PROJECT_NAME})

SET(SOURCES commit import listdocuments listversions revert tag thumbnails userguide) 
FOREACH(source ${SOURCES})
  INSTALL(PROGRAMS shellscripts/${source}.sh DESTINATION lib/${PROJECT_NAME})
ENDFOREACH(source)

