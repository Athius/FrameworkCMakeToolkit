find_path(MYLIBRARY_INCLUDE_DIR Sum.hpp)
find_library(MYLIBRARY_LIBRARY_NAMES myLibrary)

set(MYLIBRARY_INCLUDE_DIRS ${MYLIBRARY_INCLUDE_DIR})
set(MYLIBRARY_LIBRARIES ${MYLIBRARY_LIBRARY_NAMES})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(myLibrary DEFAULT_MSG
                                  MYLIBRARY_LIBRARIES MYLIBRARY_INCLUDE_DIRS)