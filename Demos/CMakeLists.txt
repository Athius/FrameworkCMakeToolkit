cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

macro(SUBDIRLIST result curdir)
  file(GLOB children RELATIVE ${curdir} ${curdir}/*)
  set(dirlist "")
  foreach(child ${children})
    if(IS_DIRECTORY ${curdir}/${child})
        set(dirlist ${dirlist} ${child})
    endif()
  endforeach()
  set(${result} ${dirlist})
endmacro()

SUBDIRLIST(SUBDIRS ".")

message(STATUS "${SUBDIRS}")

foreach(subdir ${SUBDIRS})
  add_subdirectory(${subdir})
endforeach(subdir ${SUBDIRS})