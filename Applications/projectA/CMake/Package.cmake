function(try_build_package)
        
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VENDOR "Romain LEGUAY")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Example test framework")
set(CPACK_PACKAGE_VERSION_MAJOR "${${PROJECT_NAME}_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${${PROJECT_NAME}_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${${PROJECT_NAME}_VERSION_PATCH}")
set(CPACK_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}")
set(CPACK_SOURCE_IGNORE_FILES "/lib/;/.svn/;/.git/;${CPACK_SOURCE_IGNORE_FILES};/.project/.cproject/CMakeFiles/;")

set(CPACK_PACKAGE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/packages")

if (NOT ("${CMAKE_BUILD_TYPE}" STREQUAL ""))
    set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CMAKE_SYSTEM_NAME}-${CMAKE_BUILD_TYPE}")
endif()

set(CPACK_INSTALL_CMAKE_PROJECTS)
foreach(component ${COMPONENT_NAMES})
  list(APPEND CPACK_INSTALL_CMAKE_PROJECTS "${CMAKE_CURRENT_BINARY_DIR};${PROJECT_NAME};${component};/")
endforeach()

set(CPACK_OUTPUT_CONFIG_FILE "${CMAKE_CURRENT_BINARY_DIR}/CPackConfig.cmake")
set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "${CMAKE_CURRENT_BINARY_DIR}/CPackSourceConfig.cmake")

add_custom_target(application_${PROJECT_NAME}_package "cpack" "--config" "${CPACK_OUTPUT_CONFIG_FILE}")
add_custom_target(application_${PROJECT_NAME}_package_source "cpack" "--config" "${CPACK_SOURCE_OUTPUT_CONFIG_FILE}")

include(CPack)

endfunction(try_build_package)