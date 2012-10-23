find_file(GPROF2DOT_FILE gprof2Dot.py)

#set(GPROF2DOT ${GPROF2DOT_FILE})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GPROF2DOT DEFAULT_MSG
                                  GPROF2DOT_FILE)