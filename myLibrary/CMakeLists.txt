cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

project(myLibrary CXX)

include_directories(${CMAKE_SOURCE_DIR}/include)

file(GLOB_RECURSE header_files
     include/*.hpp)

file(GLOB_RECURSE source_files
     src/*.cpp)
     
add_library(${PROJECT_NAME} STATIC ${source_files})

set_target_properties(${PROJECT_NAME} PROPERTIES ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY} ${CMAKE_BINARY_DIR}/lib/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE})

install(TARGETS ${PROJECT_NAME}
        LIBRARY
        DESTINATION "myLibrary"
        COMPONENT libraries)
        
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VENDOR "Romain LEGUAY")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Example test framework")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}")
set(CPACK_SOURCE_IGNORE_FILES "/lib/;/.svn/;/.git/;${CPACK_SOURCE_IGNORE_FILES}")

set(CPACK_COMPONENTS_ALL "libraries")

include(CPack)