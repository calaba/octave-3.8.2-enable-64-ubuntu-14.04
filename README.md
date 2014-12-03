octave-3.8.2-enable-64-ubuntu-14.04
===================================

Octave 3.8.2 compiled with --enable-64 (experimental switch) on x64 Ubuntu Linux Desktop 14.04

Basic procedure to compile Octave with 64-bit indexing (experimental switch --enable-64):
=========================================================================================

1) Install Ubuntu Linux Desktop 14.04 from ISO distribution file
2) (optional) Update Ubuntu Linux Desktop with latest updates
3) Install git by running command 'sudo apt-get install git' from terminal window (needs Internet connection)
4) Clone this repository into your folder of choice by executing: 
    sudo git clone https://github.com/calaba/octave-3.8.2-enable-64-ubuntu-14.04.git
5) Run 'sudo all.sh' script in terminal window - it will:

    a) Install all required libraries and tools for compilation using apt - executes script '1-compile-install-prereq.sh' 
    
    b) Unpacks all sources of used libraries and Octave 3.8.2 - executes script '2-compile-unpack-src.sh' 
       All sources are stored in archives in subdirectory x64-libs\_archives - those are orignal versions downloaded from their respective web sites. Feel free to replace them with your own downloaded files or newer versions of the used libraries. If you want use newer versions you might need to play with the script source codes to make sure the rest of the automated compilation works fine.
       
       TODO: add here list of all library archives and their original web sites
       
    c) Compiles & installs required libraries in mode to support 64-bit indexing - executes script '3-compile-64-libs.sh'.
       In order to succeed with compilation of the libraries in 64bit indexing mode it uses patches of the source code (mostly compiling options) which are stored in sub-directory x64-libs\_mods\<library_name>.mod for each library. Those patches might be library version specific and might not work well if you decide to compile this repository with newer version(s).
    
    d) Compiles Octave 3.8.2 sources with 64bit indexing (option --enable-64) and uses the precompiled libraries from step c) abpove. Executes script '4-compile-64-octave.sh'. At the end of Octave compilation it runs Octave tests (by calling 'make check' in ocatve source directory) - all test are sopposed to succeed.
    
    TODO: <Include test output here>
    
    e) Runs compiled Octave with 64bit indexing enabled in interactive mode - executes script '5-run_64bit_octave.sh' . You can test whether it works as you need. I.e. you can test whether you can allocate memory arrays which require 64bit index for it's elements:
    
       octave:1> a = zeros (1024*1024*1024*3, 1, 'int8');
        
        If you have enough of free memory (physical memory + swap file(s)) then you should not get this error which you will get octave with default 32bit indexing:
        
        error: memory exhausted or requested size too large
        for range of Octave's index type 
    
    
    REMARK: All scripts above in steps a) to d) store full output (stdout and stderr) into file with same name as the script name and extension .log - i.e. 2-compile-unpack-src.log, 3-compile-64-libs.log, etc.
    
6) If you are satisfied with Octave compilation with enabled 64bit indexing you can cd to Ocatve sources directory (octave-3.8.2) and install Ocatve bu running command 'sudo make install'. After successfull installation you can type 'octave' from any terminal window to run your 64bit indexing enabled Octave. 

Enjoy! And feel free to improve this repo, make it more/better automated, less version dependent and bugs-free!
Richard Calaba (calaba@gmail.com)

TODO: <include references to various sites resolving some of the issues while compiling Libs or Octave sources>

