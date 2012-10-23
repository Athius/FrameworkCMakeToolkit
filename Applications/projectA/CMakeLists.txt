cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

project(projectA CXX)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/CMake" FORCE)

if (NOT (EXISTS ${MYLIBRARY_INCLUDE_DIRS}))
    find_package(myLibrary)
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include ${MYLIBRARY_INCLUDE_DIRS})

file(GLOB_RECURSE header_files
     ${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp)
     
file(GLOB_RECURSE source_files
     ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp)
     
add_executable(${PROJECT_NAME} ${source_files})
if (EXISTS ${MYLIBRARY_SOURCE_DIRS})
    target_link_libraries(${PROJECT_NAME} myLibrary)
else()
    target_link_libraries(${PROJECT_NAME} ${MYLIBRARY_LIBRARIES})
endif()    

set_target_properties(${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE}")


install(TARGETS ${PROJECT_NAME}
        DESTINATION "Applications/${PROJECT_NAME}"
        COMPONENT application-${PROJECT_NAME})

set(COMPONENT_NAMES application-${PROJECT_NAME})
        
include(Package)

try_build_package()

include(Documentation)

try_build_documentation()

include(Profile)

try_build_profile()        