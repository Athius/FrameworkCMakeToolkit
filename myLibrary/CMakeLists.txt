cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/CMake" FORCE)

include(Project)

set_project(myLibrary CXX)

set(MYLIBRARY_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/include CACHE STRING "Include dir for myLibrary")
set(MYLIBRARY_SOURCE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/src CACHE STRING "Source dir for myLibrary")

try_build_library()

install(TARGETS ${LIBRARY_OUTPUT_NAME}
        LIBRARY
        ARCHIVE DESTINATION "lib"
        COMPONENT libraries)

install(FILES ${header_files}
        DESTINATION "include"
        COMPONENT library_headers)
        
set(COMPONENT_NAMES libraries library_headers)

include(Package)

set_project_version(1 0 0)

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