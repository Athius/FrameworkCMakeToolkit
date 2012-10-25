macro(try_build_documentation)

    # Variables to permits to Generate or not PDF documentation file if pdflatex is found
    set(GENERATE_LATEX NO)
    set(USE_PDFLATEX NO)
    
    find_package(Latex)
    if (LATEX_COMPILER)
        set(GENERATE_LATEX YES FORCE)
    endif()
    
    if (PDFLATEX_COMPILER)
        set(USE_PDFLATEX YES FORCE)
    endif()
    
    find_package(Doxygen)
    
    if (DOXYGEN_FOUND)
    
    	# Configure Doxyfile for html so as to replace PROJECT_OUTPUT_NAME by actual project name
    	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/CMake/Doxyfile-html.cmake ${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile-html @ONLY)
    	
    	# Copy Doxyfile in each project and replace all variable like @@PROJECT_OUTPUT_NAME@_SOURCE_DIR@ by its value
    	configure_file(${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile-html ${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile-html @ONLY)
    	
    	
    	
    	# Set variable so as to build the documentation with doxygen 	
    	set(DOCUMENTATION_OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/doc/html/index.html)
    	set(DOCUMENTATION_COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile-html)
    
    	add_custom_target(${PROJECT_OUTPUT_NAME}_doc 
    					  DEPENDS ${DOCUMENTATION_OUTPUT})
    
    	# Build the doxydoc if project has changed	
    	add_custom_command(OUTPUT  ${DOCUMENTATION_OUTPUT}
    		               COMMAND ${DOCUMENTATION_COMMAND} 
    		               DEPENDS ${PROJECT_OUTPUT_NAME})
        
        if (PDFLATEX_COMPILER AND LATEX_COMPILER)
        
            # Variables to define the name of the command and the command itself. 
            set(DOCUMENTATION_OUTPUT_PDF ${CMAKE_CURRENT_BINARY_DIR}/doc/latex/refman.pdf)
            set(DOCUMENTATION_COMMAND_PDF ${PDFLATEX_COMPILER} ${CMAKE_CURRENT_BINARY_DIR}/doc/latex/refman.tex)
                         
            # This command generates the documentation refman.pdf             
            add_custom_command(OUTPUT ${DOCUMENTATION_OUTPUT_PDF} WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/doc/latex
                               COMMAND ${DOCUMENTATION_COMMAND_PDF}
                               DEPENDS ${DOCUMENTATION_OUTPUT})
                                           
            add_custom_target(${PROJECT_OUTPUT_NAME}_doc_pdf DEPENDS "${DOCUMENTATION_OUTPUT_PDF}" )                   
            
            
            # Variables to define the name of the command and the two command definitions.
            set(DOCUMENTATION_OUTPUT_PACKAGE ${CMAKE_CURRENT_BINARY_DIR}/doc/latex/tmp/${PROJECT_OUTPUT_NAME}_doc.pdf)
            # Make a temp directory
            set(DOCUMENTATION_COMMAND_MKDIR ${CMAKE_COMMAND} -E make_directory tmp)
            # Copy refman.pdf in tmp/${PROJECT_OUTPUT_NAME}_doc.pdf
            set(DOCUMENTATION_COMMAND_COPY ${CMAKE_COMMAND} -E copy refman.pdf tmp/${PROJECT_OUTPUT_NAME}_doc.pdf)
            
            # This command create 'tmp' directory and copy refman.pdf inside it. 
            add_custom_command(OUTPUT ${DOCUMENTATION_OUTPUT_PACKAGE} WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/doc/latex
                               COMMAND ${DOCUMENTATION_COMMAND_MKDIR} 
                               COMMAND ${DOCUMENTATION_COMMAND_COPY}
                               DEPENDS ${PROJECT_OUTPUT_NAME}_doc_pdf)
            
            # We install the component 'doc' inside a 'doc' folder
            install(FILES ${DOCUMENTATION_OUTPUT_PACKAGE}
                    DESTINATION doc
                    COMPONENT doc)
                    
            # We set the different variables to juste have the pdf file inside the package.        
            set(CPACK_DOC_OUTPUT_CONFIG_FILE "${CMAKE_CURRENT_BINARY_DIR}/CPackDocConfig.cmake")
            set(CPACK_INSTALL_CMAKE_PROJECTS "${CMAKE_CURRENT_BINARY_DIR};${PROJECT_OUTPUT_NAME};doc;/")
            set(CPACK_COMPONENTS_ALL doc)
            set(CPACK_INSTALLED_DIRECTORIES "${CMAKE_CURRENT_BINARY_DIR}/doc/tmp;./doc")
            set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-doc")
            
            # We refresh the cpack variables.
            cpack_encode_variables()
            # We create a CPackDocConfig.cmake with the original CPackConf.cmake.in provided by CPack
            configure_file("${cpack_input_file}" "${CPACK_DOC_OUTPUT_CONFIG_FILE}" @ONLY IMMEDIATE)
            
            add_custom_target(${PROJECT_OUTPUT_NAME}_package_doc 
                              COMMAND "cpack" "--config" "${CPACK_DOC_OUTPUT_CONFIG_FILE}" 
                              DEPENDS ${DOCUMENTATION_OUTPUT_PACKAGE})
                        
            # If the target 'package_doc' doesn't exist, we create it
            # this target can build all the documentation (in pdf format) packages.
            if (NOT TARGET "package_doc")
                add_custom_target(package_doc)
            endif()
            
            # Add the dependency ${PROJECT_OUTPUT_NAME}_package_doc to the target 'package_doc'
            add_dependencies(package_doc ${PROJECT_OUTPUT_NAME}_package_doc)
                
        endif()
            
        # If the target 'doc' doesn't exist, we create it
        if (NOT TARGET "doc")
            add_custom_target(doc)
        endif()
        
        # Add the dependency ${PROJECT_OUTPUT_NAME}_doc to the target 'doc'
        add_dependencies(doc ${PROJECT_OUTPUT_NAME}_doc)
        
    endif()

endmacro(try_build_documentation)