cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/CMake" FORCE)

include(Project)

set_project(projectA CXX)

try_build_application()

install(TARGETS ${APPLICATION_OUTPUT_NAME}
        DESTINATION "Demos/${APPLICATION_OUTPUT_NAME}"
        COMPONENT ${APPLICATION_OUTPUT_NAME})
        
set(COMPONENT_NAMES ${APPLICATION_OUTPUT_NAME})  

include(Package)

try_build_package()

include(Documentation)

try_build_documentation()

include(Profile)

try_build_profile()

include(Test)

set(TEST_NAME ${APPLICATION_OUTPUT_NAME}_testSum)
set(TEST_INPUT_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/test/include ${APPLICATION_INCLUDE_DIRS})
set(TEST_OUTPUT_CPP_FILE TestSum.cpp)

file(GLOB_RECURSE TEST_INPUT_FILES
     ${CMAKE_CURRENT_SOURCE_DIR}/test/include/*.hpp
     ${CMAKE_CURRENT_SOURCE_DIR}/test/include/*.h
     ${CMAKE_CURRENT_SOURCE_DIR}/test/include/*.hxx
     ${APPLICATION_SOURCE_DIRS}/TestSum.cpp)
      
set(TEST_LIBRARY_INCLUDE_DIRS  ${MYLIBRARY_INCLUDE_DIRS})

if ("${MYLIBRARY_LIBRARIES}" STREQUAL "")
    set(TEST_LIBRARIES myLibrary ${ADDITIONAL_LIBRARIES})
else()
    set(TEST_LIBRARIES ${MYLIBRARY_LIBRARIES} ${ADDITIONAL_LIBRARIES})
endif()

try_build_test("${TEST_NAME}" "${TEST_INPUT_INCLUDE_DIRS}"  "${TEST_OUTPUT_CPP_FILE}" "${TEST_INPUT_FILES}" "${TEST_LIBRARY_INCLUDE_DIRS}" "${TEST_LIBRARIES}")

