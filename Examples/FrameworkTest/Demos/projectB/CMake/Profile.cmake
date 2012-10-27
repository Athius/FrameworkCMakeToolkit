# Add Profile in CMAKE_BUILD_TYPE if we are in Unix system
if (UNIX)
    set(CMAKE_CXX_FLAGS_PROFILE "-Wall -Wabi -pg -g" CACHE STRING
        "Flags used by the C++ compiler during profile builds."
        FORCE)
    set(CMAKE_C_FLAGS_PROFILE "-Wall -pedantic -pg -g" CACHE STRING
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


# Add a target '${PROJECT_OUTPUT_NAME}_profile' to generate an image (png,svg...) diagram of the profiling if mode profile is activated and gprof2dot and gprof are found.
# Usage: try_build_profile()
function(try_build_profile)
  
  find_package(GProf)
  
  if(UNIX AND GPROF_FOUND AND "${CMAKE_BUILD_TYPE}" STREQUAL "Profile" AND PYTHONINTERP_FOUND)  
    find_package(Gprof2Dot REQUIRED)

    # Cache variables that setting generation of the graphic for the profiling 
    set_if_not_set(PROFILE_OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/profile")
    file(MAKE_DIRECTORY "${PROFILE_OUTPUT_DIR}")
   
    set(PROFILE_GRAPHIC_FILE_TYPE "svg" 
      CACHE STRING 
      "Change the extension of the graphic profile image file(svg, svgz, png, gif, fig, ps, pcl, imap, cmapx, dia, mif, gif")
    
    # Get the location of the application binary
    get_target_property(APPLICATION_BIN ${PROJECT_NAME} LOCATION)
    
    set(GMON_OUT "${PROFILE_OUTPUT_DIR}/gmon.out")
    set(PROFILE_TXT "${PROFILE_OUTPUT_DIR}/profile.txt")
    set(PROFILE_DOT "${PROFILE_OUTPUT_DIR}/profile.dot")
    set(PROFILE_GRAPH "${PROFILE_OUTPUT_DIR}/profile.${PROFILE_GRAPHIC_FILE_TYPE}")
    
    # Rule for generating file gmon.out, run the application
    add_custom_command(OUTPUT ${GMON_OUT}
      COMMAND ${APPLICATION_BIN} ${APPLICATION_PARAMETERS}
      DEPENDS ${PROJECT_OUTPUT_NAME})
    
    # Rule for generating file profile.txt, run gprof on gmon.out
    add_custom_command(OUTPUT ${PROFILE_TXT}
      COMMAND ${GPROF_EXECUTABLE} -z ${APPLICATION_BIN} > ${PROFILE_TXT}
      DEPENDS ${GMON_OUT})
    
    # Rule for generating file profile.dot, run gprof2dot.py on profile.txt
    add_custom_command(OUTPUT ${PROFILE_DOT}
      COMMAND python ${GPROF2DOT_EXECUTABLE} -n 0.09 -e 0.01 -o ${PROFILE_DOT} ${PROFILE_TXT}
      DEPENDS ${PROFILE_TXT})
      
    # Rule for generating graph profile profile.png, run Dot on profile.dot
    add_custom_command(OUTPUT ${PROFILE_GRAPH}
      COMMAND  ${DOXYGEN_DOT_EXECUTABLE} ${PROFILE_DOT} -T${PROFILE_GRAPHIC_FILE_TYPE} -o ${PROFILE_GRAPH}
      DEPENDS ${PROFILE_DOT}) 
    
    # Target for generating graphic of the profiling as an image file
    add_custom_target(${PROJECT_OUTPUT_NAME}_profile DEPENDS ${PROFILE_GRAPH})
    else()
      # Miss some tools, or not in profile mode
      if(PROFILE_OUTPUT_DIR)
        unset(PROFILE_OUTPUT_DIR CACHE)
        unset(PROFILE_GRAPHIC_FILE_TYPE CACHE)
      endif()
    endif()
    
endfunction(try_build_profile)