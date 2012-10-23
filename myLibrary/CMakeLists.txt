cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

project(myLibrary CXX)

set(${PROJECT_NAME}_VERSION_MAJOR 1)
set(${PROJECT_NAME}_VERSION_MINOR 0)
set(${PROJECT_NAME}_VERSION_PATCH 0)
set(${PROJECT_NAME}_VERSION "${${PROJECT_NAME}_VERSION_MAJOR}.${${PROJECT_NAME}_VERSION_MINOR}.${${PROJECT_NAME}_VERSION_PATCH}") 

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/CMake" FORCE)

set(MYLIBRARY_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/include CACHE STRING "Include dir for myLibrary")
set(MYLIBRARY_SOURCE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/src CACHE STRING "Source dir for myLibrary")

include_directories(${MYLIBRARY_INCLUDE_DIRS})

file(GLOB_RECURSE header_files
     include/*.hpp)

file(GLOB_RECURSE source_files
     src/*.cpp)
     
add_library(${PROJECT_NAME} STATIC ${source_files})

set_target_properties(${PROJECT_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE}"
                                                 ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE}")

install(TARGETS ${PROJECT_NAME}
        LIBRARY
        ARCHIVE DESTINATION "lib"
        COMPONENT libraries)

install(FILES ${header_files}
        DESTINATION "include"
        COMPONENT library_headers)
        
set(COMPONENT_NAMES libraries library_headers)

include(Package)

try_build_package()

cpack_add_component_group(libs
                          DISPLAY_NAME "Required Libraries")

cpack_add_component(libs
                    DISPLAY_NAME "myLibrary"
                    GROUP libs
                    REQUIRED)
                    
cpack_add_component(library_headers
                    DISPLAY_NAME "Headers"
                    GROUP libs
                    REQUIRED)

include(Documentation)

try_build_documentation()

include(Profile)

try_build_profile()