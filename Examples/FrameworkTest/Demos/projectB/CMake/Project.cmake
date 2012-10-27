# Macro to set a variable if it's not already set.
# Usage: set_if_not_set(VAR [value1] [value2]...)
macro(set_if_not_set name)
  if(NOT DEFINED "${name}")
      set(${name} ${ARGN})
  endif()
endmacro(set_if_not_set name value)

# Set the project name with the parent directory name in prefix.
# Usage: set_project_with_parent_name_prefix(a_project_name)
macro(set_project_with_parent_name_prefix PROJECT_NAME)
  get_filename_component(parent_name ${CMAKE_CURRENT_SOURCE_DIR} PATH)
  get_filename_component(parent_name ${parent_name} NAME)
  string(TOLOWER ${parent_name} parent_name)
  
  project(${parent_name}_${PROJECT_NAME} ${ARGS})
endmacro(set_project_with_parent_name_prefix PROJECT_NAME)

# Add target '${PROJECT_OUTPUT_NAME}' to build a static library.
# Usage: try_build_library()
macro(try_build_library)

    # Variables to define application include/source directories, application output name and output directory.
    # Those variables can be overload if the user specify it inside the project's CMakeLists.txt.
    set_if_not_set(PROJECT_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/include")
    set_if_not_set(PROJECT_SOURCE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/src")
    set_if_not_set(PROJECT_OUTPUT_NAME "${PROJECT_NAME}")
    set_if_not_set(PROJECT_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE}")
      
    # Variables to other libraries
    # Those variables can be overload if the user specify it inside the project's CMakeLists.txt.
    set_if_not_set(ADDITIONAL_LIBRARIES "")
    set_if_not_set(ADDITIONAL_INCLUDE_DIRS "")

    include_directories(${PROJECT_INCLUDE_DIRS} ${ADDITIONAL_INCLUDE_DIRS})
    
    file(GLOB_RECURSE header_files
         ${PROJECT_INCLUDE_DIRS}/*.hpp
         ${PROJECT_INCLUDE_DIRS}/*.hxx
         ${PROJECT_INCLUDE_DIRS}/*.h)
         
    file(GLOB_RECURSE source_files
         ${PROJECT_SOURCE_DIRS}/*.cpp
         ${PROJECT_SOURCE_DIRS}/*.cxx)

    add_library(${PROJECT_OUTPUT_NAME} STATIC ${source_files})

    set_target_properties(${PROJECT_OUTPUT_NAME} PROPERTIES PROJECT_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_LIBRARY_OUTPUT_DIRECTORY}"
                                                            ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_LIBRARY_OUTPUT_DIRECTORY}")
    
    target_link_libraries(${PROJECT_OUTPUT_NAME} ${ADDITIONAL_LIBRARIES})
   
endmacro(try_build_library)

# Add target '${PROJECT_OUTPUT_NAME}' to build an application.
# Usage: try_build_application()
macro(try_build_application)

    # Variables to define application include/source directories, application output name and output directory.
    # Those variables can be overload if the user specify it inside the project's CMakeLists.txt.
    set_if_not_set(PROJECT_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/include")
    set_if_not_set(PROJECT_SOURCE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/src")
    set_if_not_set(PROJECT_OUTPUT_NAME "${PROJECT_NAME}")
    set_if_not_set(PROJECT_EXECUTABLE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE}")
    
    # Variables to other libraries
    # Those variables can be overload if the user specify it inside the project's CMakeLists.txt.
    set_if_not_set(ADDITIONAL_LIBRARIES "")
    set_if_not_set(ADDITIONAL_INCLUDE_DIRS "")
    
    include_directories(${PROJECT_INCLUDE_DIRS} ${ADDITIONAL_INCLUDE_DIRS})
    link_directories(${ADDITIONAL_LIBRARY_DIRS})
    
    file(GLOB_RECURSE header_files
         ${PROJECT_INCLUDE_DIRS}/*.hpp
         ${PROJECT_INCLUDE_DIRS}/*.hxx
         ${PROJECT_INCLUDE_DIRS}/*.h)
         
    file(GLOB_RECURSE source_files
         ${PROJECT_SOURCE_DIRS}/*.cpp
         ${PROJECT_SOURCE_DIRS}/*.cxx
         ${PROJECT_SOURCE_DIRS}/*.c)

    add_executable(${PROJECT_OUTPUT_NAME} ${source_files})

    target_link_libraries(${PROJECT_OUTPUT_NAME} ${ADDITIONAL_LIBRARIES})
    
    set_target_properties(${PROJECT_OUTPUT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${PROJECT_EXECUTABLE_OUTPUT_DIRECTORY})
   
    message(STATUS "Target ${PROJECT_OUTPUT_NAME} added")
   
endmacro(try_build_application)