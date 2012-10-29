FrameworkCMakeToolkit
=====================

This project provides you some CMake scripts to help to build your C/C++ application.

### What you need?

* CMake 2.8.X (only tested with CMake 2.8.9)

* Some knowledge of CMake are required


### How to start?

Copy CMakeToolkit/CMake inside each project folders.

Copy CMakeToolkit/CMakeLists.txt.library in a library project and rename it CMakeLists.txt.

Copy CMakeToolkit/CMakeLists.txt.executable in a executable project and rename it CMakeLists.txt.

CMakeToolkit/CMakeLists.txt.root_folder and CMakeToolkit/CMakeLists.txt.subfolder are used if you have a tree like in the FrameworkTest example.


Features:
---------

### V 0.2:

* Put automatic name to project if it's not already set

### V 0.1:


* Build multiple projects (Application or Static library)

* Build documentation Doxygen/Latex/Pdf

* Make package (Binary/Source/Library/Pdf) for one or multiple projects

* Add target for profiling with GProf and build performance graph if Profile is put on CMAKE_BUILD_TYPE. (Just on Unix systems)

* Add target to build CxxTest.


Variable list:
--------------

### V 0.1:


*Project.cmake:*

* **PROJECT_INCLUDE_DIRS**                : Include directories to search .hpp, .hxx and .h files. 
		
		**Default value:** ${CMAKE_CURRENT_SOURCE_DIR}/include

* **PROJECT_SOURCE_DIRS**                 : Source directories to search .cpp, .cxx and .c files. 

		**Default value:** ${CMAKE_CURRENT_SOURCE_DIR}/src

* **PROJECT_OUTPUT_NAME**                 : Output name of the project. 

		**Default value:** ${PROJECT_NAME}

* **PROJECT_LIBRARY_OUTPUT_DIRECTORY**    : Library output directory. 

		**Default value:** ${CMAKE_CURRENT_BINARY_DIR}/lib/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE}

* **PROJECT_EXECUTABLE_OUTPUT_DIRECTORY** : Executable output directory. 

		**Default value:** ${CMAKE_CURRENT_BINARY_DIR}/bin/${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}/${CMAKE_BUILD_TYPE}

* **ADDITIONAL_LIBRARIES**                : Additional libraries to build the project. 

		**Default value:** ""

* **ADDITIONAL_INCLUDE_DIRS**             : Additional include directories to build the project. 

		**Default value:** ""



*Profile.cmake:*

Only available on Unix system.

* **CMAKE_CXX_FLAGS_PROFILE**             : Flags used by the C++ compiler during profile builds.

* **CMAKE_C_FLAGS_PROFILE**               : Flags used by the C compiler during profile builds.

* **CMAKE_EXE_LINKER_FLAGS_PROFILE**      : Flags used for linking binaries during profile builds.

* **CMAKE_SHARED_LINKER_FLAGS_PROFILE**   : Flags used by the shared libraries linker during profile builds.

* **PROFILE_OUTPUT_DIR**                  : Output directory for the profiling files



*Package.cmake:*

* **${PROJECT_OUTPUT_NAME}_VERSION_MAJOR**: Major version for the project.

* **${PROJECT_OUTPUT_NAME}_VERSION_MINOR**: Minor version for the project.

* **${PROJECT_OUTPUT_NAME}_VERSION_PATCH**: Patch version for the project.

* **${PROJECT_OUTPUT_NAME}_VERSION**      : Full Version for the project.

* **COMPONENT_NAMES**                     : List of all components to be installed inside the package.



*Test.cmake:*

* *None*

*Documentation.cmake:*

* **GENERATE_LATEX**                      : Generate Latex documentation or not.

* **USE_PDFLATEX**                        : Generate PDF version of latex documentation or not.


Macro list:
-----------

### V.0.2:

*Project.cmake:*

* set_auto_project_name:
	* Put an automatic project name based on the current source folder name.
	  	       Usage: set_auto_project_name()

* init_project_variables:
	* Initialize the project variables with default values if they are not already set.
	  	       Usage: init_project_variables()

* search_and_add_files_to_build_the_project:
	* Search headers, source files and add include directories and link directories.
	  	       Usage: search_and_add_files_to_build_the_project()


### V 0.1:


*Project.cmake:*

* set_if_not_set : 
	* Macro to set a variable if it's not already set.
		
			Usage: set_if_not_set(VAR [value1] [value2]...)

* set_project_with_parent_name_prefix : 
	* Set the project name with the parent directory name in prefix.
		
			Usage: set_project_with_parent_name_prefix(a_project_name)
									
* try_build_library : 
	* Add target '${PROJECT_OUTPUT_NAME}'to build a static library.
		
			Usage: try_build_library()
									
* try_build_application : 
	* Add target '${PROJECT_OUTPUT_NAME}' to build an application.
		
			Usage: try_build_application()
				

					
*Profile.cmake:*

* try_build_profile :
	* Add target '${PROJECT_OUTPUT_NAME}_profile' to generate an image (png,svg...) diagram of the profiling if mode profile is activated and gprof2dot and gprof are found.
		
			Usage: try_build_profile()



*Package.cmake:*

* set_project_name_version :
	* Set a version for the project
                
			Usage: set_project_name_version(MAJOR MINOR PATCH) 
                                    
* try_build_package : 
	* Add target '${PROJECT_OUTPUT_NAME}_package' to build binary package of the project.
	* Add target '${PROJECT_OUTPUT_NAME}_package_source' to build source package of the project.
	* Add target 'package' to build all binary packages.
	* Add target 'package_source' to build all source packages.
		
			Usage: try_build_package()



*Test.cmake:*

* try_build_test : 
	* Add target ${test_name}_run to build a cxxtest class and put this target in the 'test' target's dependencies.
		
			Usage: try_build_test("${TEST_NAME}" "${TEST_INCLUDE_DIR}" "${TEST_OUTPUT_CPP_DIR}" "${TEST_OUTPUT_CPP_FILE}" "${TEST_INPUT_FILES}" "${TEST_PROJECT_INCLUDE_DIRS}" "${TEST_LIBRARIES}")



*Documentation.cmake:*

* try_build_documentation : 
	* Add target '${PROJECT_OUTPUT_NAME}_doc' to generate html documentation.
	* Add target '${PROJECT_OUTPUT_NAME}_doc_pdf' to generate pdf documentation if latex and pdflatex are find.
	* Add target 'doc' to generate html documentation for all projects.
	* Add target '${PROJECT_OUTPUT_NAME}_package_doc_pdf' to generate and to put pdf documentation inside a package.
 	* Add target 'package_doc_pdf' to generate and to puts html documentation for all projects.
		
			Usage: try_build_documentation()


