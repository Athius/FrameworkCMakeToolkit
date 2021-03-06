cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/CMake" FORCE)

find_package(myLibrary REQUIRED)

include(Project)

set_project_with_parent_name_prefix(projectB CXX)

set(ADDITIONAL_LIBRARIES myLibrary)
set(ADDITIONAL_INCLUDE_DIRS ${MYLIBRARY_INCLUDE_DIRS})
set(ADDITIONAL_LIBRARY_DIRS ${MYLIBRARY_LIBRARY_DIRS})

try_build_application()

install(TARGETS ${PROJECT_OUTPUT_NAME}
        DESTINATION "Demos/${PROJECT_OUTPUT_NAME}"
        COMPONENT ${PROJECT_OUTPUT_NAME})
        
set(COMPONENT_NAMES ${PROJECT_OUTPUT_NAME})  

include(Package)

try_build_package()

include(Documentation)

try_build_documentation()

include(Profile)

try_build_profile()

include(Test)

set(TEST_NAME ${PROJECT_OUTPUT_NAME}_testSum)
set(TEST_INPUT_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/test/include ${APPLICATION_INCLUDE_DIRS})
set(TEST_OUTPUT_CPP_FILE TestSum.cpp)

file(GLOB_RECURSE TEST_INPUT_FILES
     ${CMAKE_CURRENT_SOURCE_DIR}/test/include/*.hpp
     ${CMAKE_CURRENT_SOURCE_DIR}/test/include/*.h
     ${CMAKE_CURRENT_SOURCE_DIR}/test/include/*.hxx
     ${PROJECT_SOURCE_DIRS}/TestSum.cpp)
      
set(TEST_LIBRARY_INCLUDE_DIRS  ${MYLIBRARY_INCLUDE_DIRS})

set(TEST_LIBRARIES ${ADDITIONAL_LIBRARIES})

try_build_test("${TEST_NAME}" "${TEST_INPUT_INCLUDE_DIRS}"  "${TEST_OUTPUT_CPP_FILE}" "${TEST_INPUT_FILES}" "${TEST_LIBRARY_INCLUDE_DIRS}" "${TEST_LIBRARIES}")
try_build_test("${TEST_NAME}2" "${TEST_INPUT_INCLUDE_DIRS}" "${TEST_OUTPUT_CPP_FILE}" "${TEST_INPUT_FILES}" "${TEST_LIBRARY_INCLUDE_DIRS}" "${TEST_LIBRARIES}")
