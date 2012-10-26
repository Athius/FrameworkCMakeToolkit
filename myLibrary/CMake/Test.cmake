# Add a target ${test_name}_run to build a cxxtest class and put this target in the 'test' target's dependencies.
# 
# Usage example:
# set(TEST_NAME ${PROJECT_OUTPUT_NAME}_testSum)
# set(TEST_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/test/include ${PROJECT_INCLUDE_DIRS})
# set(TEST_OUTPUT_CPP_DIR "test/src")
# set(TEST_OUTPUT_CPP_FILE TestSum.cpp)
#
# file(GLOB_RECURSE TEST_INPUT_FILES
#      ${CMAKE_CURRENT_SOURCE_DIR}/test/include/*.hpp
#      ${CMAKE_CURRENT_SOURCE_DIR}/test/include/*.h
#      ${CMAKE_CURRENT_SOURCE_DIR}/test/include/*.hxx
#      ${PROJECT_SOURCE_DIRS}/TestSum.cpp)
#      
# set(TEST_PROJECT_INCLUDE_DIRS  ${MYLIBRARY_INCLUDE_DIRS})
#
# if ("${MYLIBRARY_LIBRARIES}" STREQUAL "")
#     set(TEST_LIBRARIES myLibrary ${ADDITIONAL_LIBRARIES})
# else()
#     set(TEST_LIBRARIES ${MYLIBRARY_LIBRARIES} ${ADDITIONAL_LIBRARIES})
# endif()
#
# try_build_test("${TEST_NAME}" "${TEST_INCLUDE_DIR}" "${TEST_OUTPUT_CPP_DIR}" "${TEST_OUTPUT_CPP_FILE}" "${TEST_INPUT_FILES}" "${TEST_PROJECT_INCLUDE_DIRS}" "${TEST_LIBRARIES}")
# 
macro(try_build_test test_name test_input_include_dirs test_output_cpp_file test_input_files test_library_include_dirs test_libraries)
    
    find_package(CxxTest)
    
    if(CXXTEST_FOUND)
            
      # Enable testing for CTest     
      enable_testing()

      include_directories(${CXXTEST_INCLUDE_DIR} ${test_input_include_dirs} ${test_library_include_dirs})
      link_directories(${ADDITIONAL_LIBRARY_DIRS})
      
      # Add a target ${test_name} to build cxxtest
      cxxtest_add_test(${test_name} ${test_output_cpp_file} ${test_input_files})
      target_link_libraries(${test_name} ${test_libraries})
      
          
      add_custom_target(${test_name}_run "ctest" "-VV" DEPENDS ${test_name})
          
      # If the target 'test' doesn't exist, we create it
      if (NOT TARGET "test")
        add_custom_target(test)
      endif()
    
      # Add the dependency ${test_name} to the target 'test'
      add_dependencies(test ${test_name}_run)
            
    endif(CXXTEST_FOUND)
  
endmacro()
