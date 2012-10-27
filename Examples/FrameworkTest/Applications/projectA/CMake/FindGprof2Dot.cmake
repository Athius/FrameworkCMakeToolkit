# Search gprof2dot.py or download it in ${CMAKE_CURRENT_BINARY_DIR}/third_party_tools/gprof2dot.py.
# This python script can create dot grah from gprof data.
if (UNIX)
    if ("${GPROF2DOT_EXECUTABLE}" STREQUAL "") 
        find_file(GPROF2DOT_EXECUTABLE gprof2dot.py HINTS ${GPROF2DOT_EXECUTABLE} DOC "gprof2dot.py file to convert gprof file to dot graph")
    
        if (NOT GPROF2DOT_EXECUTABLE)
            message(STATUS "Downloading gprof2dot.py file")
            set(GPROF2DOF_THIRD "${CMAKE_CURRENT_BINARY_DIR}/third_party_tools/gprof2dot.py")
            file(DOWNLOAD http://gprof2dot.jrfonseca.googlecode.com/git/gprof2dot.py ${GPROF2DOF_THIRD})
            unset(GPROF2DOT_EXECUTABLE CACHE)
            set(GPROF2DOT_EXECUTABLE "${GPROF2DOF_THIRD}" CACHE DOC "gprof2dot.py file to convert gprof file to dot graph")
        endif()
        
        include(FindPackageHandleStandardArgs)
        find_package_handle_standard_args(GPROF2DOT DEFAULT_MSG
                                          GPROF2DOT_EXECUTABLE)
    endif()                                          
endif()                                                           