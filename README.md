GitHub-Repo: calaba / octave-3.8.2-enable-64-ubuntu-14.04
=========================================================

Description:  Octave 3.8.2 source code compiled with "--enable-64" flag (experimental switch to enable 64bit indexing of memory objects) on x64 Ubuntu Linux Desktop 14.04 LTS. Successfull compilation and tests required some of the used libraries (BLAS, LAPACK, ...) to be re-compiled with 64bit indexing as well.

Basic procedure to compile Octave with 64-bit indexing (experimental switch --enable-64):
=========================================================================================

1) Install Ubuntu Linux Desktop 14.04 from ISO distribution file (Installation CD-ROM can be downloaded from original distribution site http://mirror.anl.gov/pub/ubuntu-iso/DVDs/ubuntu/14.04/release/). The compilation and installation procedures might work on later versions of Ubuntu Linux Desktop as well - i.e. 14.04.1 or 14.10 - I just didn't have time to test those (yet).

2) (optional) Update Ubuntu Linux Desktop with latest updates (Internet connection required)

3) Install git by running command 'sudo apt-get install git' from terminal window (Internet connection required)

4) Clone this repository into your folder of choice (i.e. into /opt folder) by executing: 
    
    (as root - sudo su)
    cd /opt
    sudo git clone https://github.com/calaba/octave-3.8.2-enable-64-ubuntu-14.04.git
    
    It will download this repo to folder /opt/octave-3.8.2-enable-64-ubuntu-14.04 where you can execute the whole recompilation.

5) Run 'all.sh' script in the terminal window - you can redirect the stderr output of the all.sh script to file - i.e. 'all-err.log'.

    (start Terminal)
    sudo su
    cd /opt/octave-3.8.2-enable-64-ubuntu-14.04
    ./all.sh 2>all-err.log
    
    It will execute following scripts in this order:

    a) Script '1-compile-install-prereq.sh' 
    
        This installs all required libraries and tools for compilation using apt-get command. The tools & libraries to be installed are approximetly 900MB (for Ubuntu 14.04 LTS and 14.04.1 LTS) of size thus the whole download and installation procedure takes some time depending on your Internet connection speed and speed of your HW. 
    
    b) Script '2-compile-unpack-src.sh' - unpacks all sources of used libraries and sources of Octave 3.8.2 (currently latest).
       
       All sources are stored in archive files in subdirectory 'x64-libs\_archives' - those are orignal versions downloaded from their respective web sites (see below for links to original web sites). Feel free to replace them with your own downloaded files or newer versions of those used libraries. Remark: If you want use newer versions you might need to play with the automatuion script source codes to make sure the rest of the automated compilation works fine.
       
    c)  Script '3-compile-64-libs.sh' - Compiles & installs required libraries in mode to support 64-bit indexing.
    
       In order to succeed with compilation of the libraries in 64-bit indexing mode it uses patches of the source code (mostly compiling options) which are stored in sub-directory 'x64-libs\_mods\<library_name>.mod' for each library. Those patches stored here might be version specific and might not work well if you decide to compile this repository with newer version(s).
    
    d) Script '4-compile-64-octave.sh' - Compiles Octave 3.8.2 sources with 64-bit indexing (option --enable-64) and uses the pre-compiled libraries from the step c) above.  
    
        At the end of the Octave source code compilation it runs Octave internal tests (by calling 'make check' in octave source directory) - all test are sopposed to succeed - this is the expected output at the end of the script after running make check:
    
            Summary: <TODO> fill correct values:

                PASS     11202 - more
                FAIL         0
                XFAIL        7 - expected failures
                SKIPPED    395 - less
                
    REMARK: All scripts above in steps a) to d) store full output (stdout and stderr) into file with same name as the script name and extension .log - i.e. 2-compile-unpack-src.log, 3-compile-64-libs.log, etc. You can check those for more details while troubleshooting issues.
    
    e) Script '5-run_64bit_octave.sh' - Runs compiled Octave with 64-bit indexing enabled in interactive mode. 
    
        You can test whether it works as you need. I.e. you can test whether you can allocate large memory arrays which require 64-bit index for it's elements:
    
       octave:1> a = zeros (1024*1024*1024*3, 1, 'int8');
        
        If you have enough of free memory (3GB of physical memory + swap file(s) size) then you should not get this error which you will get in octave with default 32-bit indexing:
        
        error: memory exhausted or requested size too large
        for range of Octave's index type 
    
    In regular Octave with 32-bit indexing the physical limit of the memory array index seems to be (2^31 - 31 bits), this is the output of memory allocation of 2GBs and 2GBs - 1 Byte in regular octave 3.8.2:
    
        octave:15> a = zeros (2147483647, 1, 'int8');
        error: out of memory or dimension too large for Octave's index type
        octave:15> a = zeros (2147483646, 1, 'int8');
        octave:16> 

6) If you are satisfied with Octave compilation with enabled 64bit indexing you can cd to Octave sources directory (octave-3.8.2) and install Octave by running command 'sudo make install'. 

    sudo su
    cd /opt/octave-3.8.2-enable-64-ubuntu-14.04/octave-3.8.2
    make install
    
    After successfull installation you can type 'octave' from any terminal window to run your 64-bit indexing enabled Octave. 

Enjoy! Richard Calaba (calaba@gmail.com)
(And feel free to improve this repo, make it more/better automated, less version dependent and bugs-free!)

Additional References To 3rd party libraries used while compiling Octave with 64bit indexing:
=============================================================================================

All libraries which are required by Octave are referred here:

    https://www.gnu.org/software/octave/doc/interpreter/External-Packages.html 

However only some of them require re-compilation with 64bit enabled indexing as mentioned here:

    https://www.gnu.org/software/octave/doc/interpreter/Compiling-Octave-with-64_002dbit-Indexing.html

and also here:

    http://octave.1599824.n4.nabble.com/make-test-failure-d1mach-i-out-of-bounds-td2286214.html

Based on the links above I used following libraries to compile Octave 3.8.2 with 64-bit indexing:
=================================================================================================

Octave 3.8.2 Sources:
---------------------
Home:               http://www.gnu.org/software/octave/download.html
Octave Source Code: ftp://ftp.gnu.org/gnu/octave/octave-3.8.2.tar.gz


SuiteSparse-4.4.1.tar.gz
------------------------
Home:           http://faculty.cse.tamu.edu/davis/suitesparse.html
Library Source: http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.4.1.tar.gz

Arpack96 (ARPACK folder)
------------------------
Home:           http://www.caam.rice.edu/software/ARPACK/
Library Source: http://www.caam.rice.edu/software/ARPACK/download.html#ARPACK

blas.tgz - REFERENCE BLAS 3.5.0
-------------------------------
Home:           http://www.netlib.org/blas/
Library Source: http://www.netlib.org/blas/blas.tgz

lapack-3.5.0.tgz
----------------
Home:           http://www.netlib.org/lapack/
Library Source: http://www.netlib.org/lapack/lapack-3.5.0.tgz

glpk-4.55.tar.gz
----------------
Home:           http://www.gnu.org/software/glpk/
Library Source: http://ftp.gnu.org/gnu/glpk/glpk-4.55.tar.gz

metis-4.0.3.tar.gz
------------------
(Metis is needed for SuiteSparse compilation, the SuiteSparse 4.4.1 README is mentioning use of Metis 4.0.1 however Metis 4.0.1 doesn't compile in Ubuntu 14.04. However the Metis 4.0.3 compiles fine)
Home:           http://glaros.dtc.umn.edu/gkhome/metis/metis/download
Library Source: http://glaros.dtc.umn.edu/gkhome/fsroot/sw/metis/OLD
                http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/OLD/metis-4.0.3.tar.gz
                http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/OLD/metis-4.0.1.tar.gz

qhull-2012.1-src.tgz
--------------------
Home:           http://www.qhull.org/
Library Source: http://www.qhull.org/download/qhull-2012.1-src.tgz

qrupdate-1.1.2.tar.gz
---------------------
Home:           https://sourceforge.net/projects/qrupdate/
Library Source: http://sourceforge.net/projects/qrupdate/files/qrupdate/1.2/qrupdate-1.1.2.tar.gz/download

Not used libraries - feel free to plug them in:
===============================================

In addition in the sub-folder '_not_used' of the folder where all the source archives of used libraries are located there there are following libraries:

    ATLAS atlas3.10.2.tar.bz2 (BLAS / LAPACK replacement) 
    -----------------------------------------------------
    Home:   https://sourceforge.net/projects/math-atlas/files/
    Source: http://sourceforge.net/projects/math-atlas/files/Stable/3.10.2/atlas3.10.2.tar.bz2/download
        
    Arpack-Ng - newer and more optimized ARPACK version
    ---------------------------------------------------
    Home:       https://github.com/opencollab/arpack-ng
    Source:     http://forge.scilab.org/index.php/p/arpack-ng/downloads/get/arpack-ng_3.1.5.tar.gz
    
    Metis-4.0.1
    -----------
    As mentioned above - Metis 4.0.1 doesn't compile in Ubuntu Desktop 14.04 - thus using Metis 4.0.3


References to Web Sites mentioning some of the workarounds while compiling Octave or one it's required libraries:
=================================================================================================================

1) https://lists.gnu.org/archive/html/octave-bug-tracker/2014-08/msg00210.html
2) https://lists.gnu.org/archive/html/octave-bug-tracker/2014-08/msg00218.html
2) http://ubuntuforums.org/showthread.php?t=1200824
3) http://octave.1599824.n4.nabble.com/Re-jni-h-file-not-found-td4660656.html
4) https://software.intel.com/en-us/forums/topic/362169
5) http://www.flaterco.com/kb/Octave.html
6) http://octave.1599824.n4.nabble.com/Octave-2-9-9-Compile-Problem-on-Linux-i686-td1605865.html
7) TODO add more ... ???
