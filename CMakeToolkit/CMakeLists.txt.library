cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/CMake" FORCE)

include(Project)

project(myLibrary CXX)

set(MYLIBRARY_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/include CACHE DOC "Include dir for myLibrary")
set(MYLIBRARY_SOURCE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/src CACHE DOC "Source dir for myLibrary")
set(MYLIBRARY_LIBRARY_DIRS ${PROJECT_LIBRARY_OUTPUT_DIRECTORY} CACHE DOC "Library include dir for myLibrary")

try_build_library()

install(TARGETS ${PROJECT_OUTPUT_NAME}
        LIBRARY
        ARCHIVE DESTINATION "lib"
        COMPONENT libraries)

install(FILES ${header_files}
        DESTINATION "include"
        COMPONENT library_headers)
        
set(COMPONENT_NAMES libraries library_headers)

include(Package)

set_project_name_version(1 0 0)

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

include(Test)

set(TEST_NAME ${PROJECT_OUTPUT_NAME}_testSum)
set(TEST_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/test/include)
set(TEST_OUTPUT_CPP_FILE TestSum.cpp)

file(GLOB_RECURSE TEST_INPUT_FILES
     ${TEST_INCLUDE_DIR}/*.hpp
     ${TEST_INCLUDE_DIR}/*.h
     ${TEST_INCLUDE_DIR}/*.hxx)
      
set(TEST_LIBRARY_INCLUDE_DIRS  ${MYLIBRARY_INCLUDE_DIRS})
set(TEST_LIBRARIES ${PROJECT_OUTPUT_NAME})

try_build_test("${TEST_NAME}" "${TEST_INPUT_INCLUDE_DIRS}"  "${TEST_OUTPUT_CPP_FILE}" "${TEST_INPUT_FILES}" "${TEST_LIBRARY_INCLUDE_DIRS}" "${TEST_LIBRARIES}")