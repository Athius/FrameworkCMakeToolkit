cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

project(projectB CXX)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/CMake")

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
        DESTINATION "Demos/${PROJECT_NAME}"
        COMPONENT ${PROJECT_NAME})
        
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VENDOR "Romain LEGUAY")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Example test framework: demos ${PROJECT_NAME}")
set(CPACK_PACKAGE_VERSION_MAJOR "1")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}")
set(CPACK_SOURCE_IGNORE_FILES "/bin/;/.svn/;/.git/;${CPACK_SOURCE_IGNORE_FILES};/.project/.cproject/CMakeFiles/;")

set(CPACK_COMPONENTS_ALL "")

set(CPACK_OUTPUT_CONFIG_FILE "${CMAKE_CURRENT_BINARY_DIR}/CPackConfig.cmake")
set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "${CMAKE_CURRENT_BINARY_DIR}/CPackSourceConfig.cmake")

add_custom_target(${PROJECT_NAME}-package "cpack" "--config" "${CPACK_OUTPUT_CONFIG_FILE}")
add_custom_target(${PROJECT_NAME}-package_source "cpack" "--config" "${CPACK_SOURCE_OUTPUT_CONFIG_FILE}")

include(CPack)

cpack_add_component(${PROJECT_NAME}
                    DISPLAY_NAME "${PROJECT_NAME}")