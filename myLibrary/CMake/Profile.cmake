# - Add Profile in CMAKE_BUILD_TYPE if we are in Unix system
if (UNIX)
    set(CMAKE_CXX_FLAGS_PROFILE "-Wall -Wabi -pg -g" CACHE STRING
        "Flags used by the C++ compiler during profile builds."
        FORCE)
    set(CMAKE_C_FLAGS_PROFILE "-Wall -pedantic" CACHE STRING
        "Flags used by the C compiler during profile builds."
        FORCE)
    set(CMAKE_EXE_LINKER_FLAGS_PROFILE
        "-Wl" CACHE STRING
        "Flags used for linking binaries during profile builds."
        FORCE)
    set(CMAKE_SHARED_LINKER_FLAGS_PROFILE
        "-Wl" CACHE STRING
        "Flags used by the shared libraries linker during profile builds."
        FORCE)
    mark_as_advanced(
        CMAKE_CXX_FLAGS_PROFILE
        CMAKE_C_FLAGS_PROFILE
        CMAKE_EXE_LINKER_FLAGS_PROFILE
        CMAKE_SHARED_LINKER_FLAGS_PROFILE)
    # Update the documentation string of CMAKE_BUILD_TYPE for GUIs
    set(CMAKE_BUILD_TYPE "${CMAKE_BUILD_TYPE}" CACHE STRING
        "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel Profile."
        FORCE)
endif()


# - Define a target that try to generate a a png diagram of the profiling if mode profile is activated and gprof2dot and gprof are found, assume Tool module is already included
function(try_build_profile)
  
  find_package(GProf)
  
  if(UNIX AND GPROF_FOUND AND "${CMAKE_BUILD_TYPE}" STREQUAL "Profile" AND PYTHONINTERP_FOUND)  
    find_package(Gprof2Dot REQUIRED)

    # Cache variables that setting generation of the graphic for the profiling 
    set(PROFILE_OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/profile")
    file(MAKE_DIRECTORY "${PROFILE_OUTPUT_DIR}")
   
    set(PROFILE_GRAPHIC_FILE_TYPE "svg" 
      CACHE STRING 
      "Change the extension of the graphic profile image file(svg, svgz, png, gif, fig, ps, pcl, imap, cmapx, dia, mif, gif")
    
    # Get the location of the application binary
    get_target_property(APPLICATION_BIN ${PROJECT_NAME} LOCATION)
    
    add_custom_target(${PROJECT_OUTPUT_NAME}_profile DEPENDS ${PROJECT_OUTPUT_NAME})
    
  else()
      # Miss some tools, or not in profile mode
      if(PROFILE_OUTPUT_DIR)
        unset(PROFILE_OUTPUT_DIR CACHE)
        unset(PROFILE_GRAPHIC_FILE_TYPE CACHE)
      endif()
  endif()
    
endfunction(try_build_profile)