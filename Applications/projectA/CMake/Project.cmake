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

# Add the target with name ${PROJECT_OUTPUT_NAME}
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

# Add the target with name ${PROJECT_OUTPUT_NAME}
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
         ${PROJECT_SOURCE_DIRS}/*.cxx)

    add_executable(${PROJECT_OUTPUT_NAME} ${source_files})
#    if ("${MYLIBRARY_LIBRARIES}" STREQUAL "")
        target_link_libraries(${PROJECT_OUTPUT_NAME} ${ADDITIONAL_LIBRARIES})
#    else()
#        target_link_libraries(${PROJECT_OUTPUT_NAME} ${ADDITIONAL_LIBRARIES} ${MYLIBRARY_LIBRARIES})
#    endif()
    
    set_target_properties(${PROJECT_OUTPUT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${PROJECT_EXECUTABLE_OUTPUT_DIRECTORY})
   
endmacro(try_build_application)