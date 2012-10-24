# - Set the version for the project
macro(set_project_version VERSION_MAJOR VERSION_MINOR VERSION_PATCH)
    set_if_not_set(${APPLICATION_OUTPUT_NAME}_VERSION_MAJOR ${VERSION_MAJOR})
    set_if_not_set(${APPLICATION_OUTPUT_NAME}_VERSION_MINOR ${VERSION_MINOR})
    set_if_not_set(${APPLICATION_OUTPUT_NAME}_VERSION_PATCH ${VERSION_PATCH})
    set_if_not_set(${APPLICATION_OUTPUT_NAME}_VERSION "${${APPLICATION_OUTPUT_NAME}_VERSION_MAJOR}.${${APPLICATION_OUTPUT_NAME}_VERSION_MINOR}.${${APPLICATION_OUTPUT_NAME}_VERSION_PATCH}") 
endmacro()

macro(try_build_package)
    set_project_version(1 0 0)
            
    set(CPACK_PACKAGE_NAME "${APPLICATION_OUTPUT_NAME}")
    set(CPACK_PACKAGE_VENDOR "Romain LEGUAY")
    set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Example test framework")
    set(CPACK_PACKAGE_VERSION_MAJOR "${${APPLICATION_OUTPUT_NAME}_VERSION_MAJOR}")
    set(CPACK_PACKAGE_VERSION_MINOR "${${APPLICATION_OUTPUT_NAME}_VERSION_MINOR}")
    set(CPACK_PACKAGE_VERSION_PATCH "${${APPLICATION_OUTPUT_NAME}_VERSION_PATCH}")
    set(CPACK_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}")
    set(CPACK_SOURCE_IGNORE_FILES "/lib/;/.svn/;/.git/;/.project/;/.cproject/;/CMakeFiles/;/*#/;/CMakeFiles/;/cmake_install.cmake/;/CMakeCache.txt/;/CPackConfig.cmake/;/CPackSourceConfig.cmake/;/Makefile/;/*.sln/;/.DS_Store/;/.gitignore/;")
    set(CPACK_SOURCE_INSTALLED_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR};.;${CMAKE_CURRENT_SOURCE_DIR}/include;./include;${CMAKE_CURRENT_SOURCE_DIR}/src;./src;${CMAKE_CURRENT_SOURCE_DIR}/CMake;./CMake") 

    set(CPACK_PACKAGE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/packages")
    
    if (NOT ("${CMAKE_BUILD_TYPE}" STREQUAL ""))
        set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CMAKE_SYSTEM_NAME}-${CMAKE_BUILD_TYPE}")
    endif()
    
    set(CPACK_INSTALL_CMAKE_PROJECTS)
    foreach(component ${COMPONENT_NAMES})
      list(APPEND CPACK_INSTALL_CMAKE_PROJECTS "${CMAKE_CURRENT_BINARY_DIR};${APPLICATION_OUTPUT_NAME};${component};/")
    endforeach()
    
    set(CPACK_OUTPUT_CONFIG_FILE "${CMAKE_CURRENT_BINARY_DIR}/CPackConfig.cmake")
    set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "${CMAKE_CURRENT_BINARY_DIR}/CPackSourceConfig.cmake")
    
    add_custom_target(${APPLICATION_OUTPUT_NAME}_package "cpack" "--config" "${CPACK_OUTPUT_CONFIG_FILE}")
    add_custom_target(${APPLICATION_OUTPUT_NAME}_package_source "cpack" "--config" "${CPACK_SOURCE_OUTPUT_CONFIG_FILE}")
    
    include(CPack)
                    
endmacro(try_build_package)