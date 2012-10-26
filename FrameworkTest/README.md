FrameworkTest
=====================

This project use FrameworkCMakeToolkit to build a library (myLibrary) and two others project using this library (Applications/projectA and Demos/projectB).


How to build?
-------------

### Requirement:

* CMake 2.8.X (only tested with CMake 2.8.9)

* Boost (to build projectA)

* C++ compiler (only with gcc)

Optional:

* CxxTest

* Gprof

* Doxygen

* Latex


### Build all project:

In the current directory:
   
   cmake .
   make

In a Build directory:
   
   mkdir Build && cd Build
   cmake ..
   make


### Build package:

To build all packages:

   make package

The packages can be found in each 'packages' folder inside each projects (myLibrary, Applications/projectA and Demos/projectB)


### Build documentation:

To build all documentation:

   make doc

The packages can be found in each 'doc' folder inside each projects. You can find two folders inside it: html and latex (if latex is found).

To build pdf documentation for projectA:

   make applications_projectA_doc_pdf

