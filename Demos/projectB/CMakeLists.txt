cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/CMake" FORCE)

include(Project)

set_project(projectB CXX)

try_build_application()

#find_package(myLibrary REQUIRED)
#
#include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include ${MYLIBRARY_INCLUDE_DIRS} ${ADDITIONAL_INCLUDE_DIRS})
#
#file(GLOB_RECURSE header_files
#     ${CMAKE_CURRENT_SOURCE_DIR}/include/*.hpp)
#     
#file(GLOB_RECURSE source_files
#     ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp)
#     
#add_executable(${PROJECT_NAME} ${source_files})
#if ("${MYLIBRARY_LIBRARIES}" STREQUAL "")
#    target_link_libraries(${PROJECT_NAME} myLibrary ${ADDITIONAL_LIBRARIES})
#else()
#    target_link_libraries(${PROJECT_NAME} ${MYLIBRARY_LIBRARIES} ${ADDITIONAL_LIBRARIES})
#endif()
#
#set_target_properties(${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE}")

install(TARGETS ${APPLICATION_OUTPUT_NAME}
        DESTINATION "Demos/${APPLICATION_OUTPUT_NAME}"
        COMPONENT ${APPLICATION_OUTPUT_NAME})
        
set(COMPONENT_NAMES ${APPLICATION_OUTPUT_NAME})  

include(Package)

try_build_package()
#cpack_add_component(${PROJECT_NAME}
#                    DISPLAY_NAME "${PROJECT_NAME}")

include(Documentation)

try_build_documentation()

include(Profile)

try_build_profile()

