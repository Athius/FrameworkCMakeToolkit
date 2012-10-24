# Macro to set a variable if it's not already set
macro(set_if_not_set name value)
  if(NOT DEFINED "${name}")
      set(${name} "${value}")
  endif()
endmacro(set_if_not_set name value)

# Set the project name
macro(set_project PROJECT_NAME)
  project(${PROJECT_NAME} ${ARGS})
endmacro(set_project PROJECT_NAME)

# Add the target with name ${LIBRARY_OUTPUT_NAME}
macro(try_build_library)

    # Variables to define application include/source directories, application output name and output directory.
    # Those variables can be overload if the user specify it inside the project's CMakeLists.txt.
    set_if_not_set(LIBRARY_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/include")
    set_if_not_set(LIBRARY_SOURCE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/src")
    set_if_not_set(LIBRARY_OUTPUT_NAME "${PROJECT_NAME}")
    set_if_not_set(LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE}")
    
    # Variables to other libraries
    # Those variables can be overload if the user specify it inside the project's CMakeLists.txt.
    set_if_not_set(ADDITIONAL_LIBRARIES "")
    set_if_not_set(ADDITIONAL_INCLUDE_DIRS "")

    include_directories(${LIBRARY_INCLUDE_DIRS} ${ADDITIONAL_INCLUDE_DIRS})
    
    file(GLOB_RECURSE header_files
         ${LIBRARY_INCLUDE_DIRS}/*.hpp
         ${LIBRARY_INCLUDE_DIRS}/*.hxx
         ${LIBRARY_INCLUDE_DIRS}/*.h)
         
    file(GLOB_RECURSE source_files
         ${LIBRARY_SOURCE_DIRS}/*.cpp
         ${LIBRARY_SOURCE_DIRS}/*.cxx)

    add_library(${LIBRARY_OUTPUT_NAME} STATIC ${source_files})

    set_target_properties(${LIBRARY_OUTPUT_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY "${LIBRARY_OUTPUT_DIRECTORY}"
                                                            ARCHIVE_OUTPUT_DIRECTORY "${LIBRARY_OUTPUT_DIRECTORY}")
    
    target_link_libraries(${LIBRARY_OUTPUT_NAME} ${ADDITIONAL_LIBRARIES})
   
endmacro(try_build_library)