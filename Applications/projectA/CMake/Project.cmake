# Macro to set a variable if it's not already set
macro(set_if_not_set name value)
  if(NOT DEFINED "${name}")
      set(${name} "${value}")
  endif()
endmacro(set_if_not_set name value)

# Set the project name
macro(set_project PROJECT_NAME)
  project(application_${PROJECT_NAME} ${ARGS})
endmacro(set_project PROJECT_NAME)

# Add the target with name ${APPLICATION_OUTPUT_NAME}
macro(try_build_application)

    # Variables to define application include/source directories, application output name and output directory.
    # Those variables can be overload if the user specify it inside the project's CMakeLists.txt.
    set_if_not_set(APPLICATION_INCLUDE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/include")
    set_if_not_set(APPLICATION_SOURCE_DIRS "${CMAKE_CURRENT_SOURCE_DIR}/src")
    set_if_not_set(APPLICATION_OUTPUT_NAME "${PROJECT_NAME}")
    set_if_not_set(APPLICATION_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE}")
    
    # Variables to other libraries
    # Those variables can be overload if the user specify it inside the project's CMakeLists.txt.
    set_if_not_set(ADDITIONAL_LIBRARIES "")
    set_if_not_set(ADDITIONAL_INCLUDE_DIRS "")

    find_package(myLibrary REQUIRED)
    
    include_directories(${APPLICATION_INCLUDE_DIRS} ${MYLIBRARY_INCLUDE_DIRS} ${ADDITIONAL_INCLUDE_DIRS})
    
    file(GLOB_RECURSE header_files
         ${APPLICATION_INCLUDE_DIRS}/*.hpp
         ${APPLICATION_INCLUDE_DIRS}/*.hxx
         ${APPLICATION_INCLUDE_DIRS}/*.h)
         
    file(GLOB_RECURSE source_files
         ${APPLICATION_SOURCE_DIRS}/*.cpp
         ${APPLICATION_SOURCE_DIRS}/*.cxx)

    add_executable(${APPLICATION_OUTPUT_NAME} ${source_files})
    if ("${MYLIBRARY_LIBRARIES}" STREQUAL "")
        target_link_libraries(${APPLICATION_OUTPUT_NAME} myLibrary ${ADDITIONAL_LIBRARIES})
    else()
        target_link_libraries(${APPLICATION_OUTPUT_NAME} ${MYLIBRARY_LIBRARIES} ${ADDITIONAL_LIBRARIES})
    endif()
    
    set_target_properties(${APPLICATION_OUTPUT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${APPLICATION_OUTPUT_DIRECTORY})
   
endmacro(try_build_application)