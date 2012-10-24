function(try_build_documentation)

find_package(Doxygen)

if (DOXYGEN_FOUND)

	# Configure Doxyfile for html so as to replace PROJECT_NAME by actual project name
	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/CMake/Doxyfile-html.cmake ${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile-html @ONLY)
	
	# Copy Doxyfile in each project and replace all variable like @@PROJECT_NAME@_SOURCE_DIR@ by its value
	configure_file(${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile-html ${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile-html @ONLY)
	
	# Set variable so as to build the documentation with doxygen 	
	set(DOCUMENTATION_OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/doc/html/index.html)
	set(DOCUMENTATION_COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile-html)

	add_custom_target(${LIBRARY_OUTPUT_NAME}_doc 
							DEPENDS ${DOCUMENTATION_OUTPUT})

	# Build the doxydoc if project has changed	
	add_custom_command(OUTPUT  ${DOCUMENTATION_OUTPUT}
		           COMMAND ${DOCUMENTATION_COMMAND} 
		           DEPENDS ${LIBRARY_OUTPUT_NAME})
        
	add_dependencies(${LIBRARY_OUTPUT_NAME}_doc ${LIBRARY_OUTPUT_NAME}_doc)
endif()

endfunction(try_build_documentation)