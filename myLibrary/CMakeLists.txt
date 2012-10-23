cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

project(myLibrary CXX)

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
        
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VENDOR "Romain LEGUAY")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Example test framework")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}")
set(CPACK_SOURCE_IGNORE_FILES "/lib/;/.svn/;/.git/;${CPACK_SOURCE_IGNORE_FILES};/.project/.cproject/CMakeFiles/;")

set(CPACK_COMPONENTS_ALL "")

set(CPACK_OUTPUT_CONFIG_FILE "${CMAKE_CURRENT_BINARY_DIR}/CPackConfig.cmake")
set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "${CMAKE_CURRENT_BINARY_DIR}/CPackSourceConfig.cmake")

add_custom_target(${PROJECT_NAME}-package "cpack" "--config" "${CPACK_OUTPUT_CONFIG_FILE}")
add_custom_target(${PROJECT_NAME}-package_source "cpack" "--config" "${CPACK_SOURCE_OUTPUT_CONFIG_FILE}")

include(CPack)

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