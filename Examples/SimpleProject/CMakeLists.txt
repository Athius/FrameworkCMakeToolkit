cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_SOURCE_DIR}/CMake" FORCE)

include(Project)

#project(simpleProject CXX)

# Add the target to build your application
try_build_application()
