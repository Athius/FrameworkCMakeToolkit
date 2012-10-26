# Search gprof
if (UNIX AND (CMAKE_BUILD_TYPE MATCHES "Profile"))
    find_package(PythonInterp)
    
    find_file(GPROF_EXECUTABLE gprof DOC "Time code profiler")
    	
    if(GPROF_EXECUTABLE)
        set(CMAKE_BUILD_TYPE Profile)
	    set(CMAKE_C_FLAGS_PROFILE "-pg ${CMAKE_C_FLAGS_DEBUG}")
	    set(CMAKE_CXX_FLAGS_PROFILE "-pg ${CMAKE_CXX_FLAGS_DEBUG}")
    else()
        message(FATAL_ERROR "Profiler tool not found")
    endif()
     
    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(GPROF DEFAULT_MSG
                                      GPROF_EXECUTABLE)
                                      
endif()