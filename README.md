GitHub-Repo: calaba / octave-3.8.2-enable-64-ubuntu-14.04
=========================================================

Octave 3.8.2 source code compiled with "--enable-64" flag (experimental switch to enable 64-bit indexing of memory objects) on x64 (64-bit) Ubuntu Linux Desktop 14.04 / 14.04.1 / 14.10 LTS. Successfull compilation and tests require some of the  libraries (BLAS, LAPACK, SuiteSparse, ARPACK, GLPK, ...) used by Octave to be re-compiled with 64-bit indexing support as well.


What are we trying to address by enabling 64-bit index enablement:
==================================================================

Source: https://lists.gnu.org/archive/html/help-octave/2010-07/msg00223.html

On 64-bit systems, Octave is limited to (approximately) the following array sizes:
    
    double:    16GB
    single:     8GB 
    {u,}int64: 16GB
    {u,}int32:  8GB
    {u,}int16:  4GB
    {u,}int8:   2GB

In each case, the limit is really 2^31-1 elements because of the default type of the value used for indexing arrays (signed 32-bit integer, corresponding to the size of a Fortran INTEGER value). 

Trying to create larger arrays will produce the following error:

>   octave:1> a = zeros (1024 * 1024 * 1024 * 3, 1, 'int8'); error: memory
>   exhausted or requested size too large for range of Octave's index
>   type -- trying to return to prompt

You will obtain this error even if your system has enough memory to create this array (4 GB in the above case).


How to compile Octave with 64-bit indexing (experimental switch --enable-64):
=============================================================================

1) Install Ubuntu Linux Desktop 14.04 / 14.04.1 / 14.10 from ISO distribution file (Installation CD-ROM can be downloaded from original distribution site http://mirror.anl.gov/pub/ubuntu-iso/DVDs/ubuntu/14.04/release/). The compilation and installation procedures might work on later/earlier 64-bit versions of Ubuntu Linux Desktop as well - just didn't have time to test it on those.

2) (optional) Update Ubuntu Linux Desktop with latest updates (Internet connection required)

3) Install git by running command 'sudo apt-get install git' from terminal window (Internet connection required)

4) Clone this repository (Internet connection required) into your folder of choice (i.e. into /opt folder) by executing: 

    (as root - sudo su)
    cd /opt
    sudo git clone https://github.com/calaba/octave-3.8.2-enable-64-ubuntu-14.04.git

It will download this repository to folder /opt/octave-3.8.2-enable-64-ubuntu-14.04 where you can execute the whole re-compilation of Octave and required libraries.

REMARK: Alternatively you can download the git repository to your user's HOME directory and compile it there ... 

5) Run 'all.sh' script in the terminal window - you can redirect the stderr output of the all.sh script to file - i.e. 'all-err.log'.

    (start Terminal)
    sudo su     
    cd /opt/octave-3.8.2-enable-64-ubuntu-14.04
    ./all.sh 2>all-err.log
    
REMARK: If you downloaded the git repository to your HOME directory then use cd '~/octave-3.8.2-enable-64-ubuntu-14.04' instead. You can compile the repository and libraries as non-root user but some commands (like installation of required tools/libraries and installation of the compiled libraries) require root access. To avoid beeing asked for sudo password multiple times during compilation - use for example 'sudo ls' command before you execute the 'all.sh' script.
    
IMPORTANT: Additional parameters for tuning the compilation and libraries installation process are in the file 'compile-params.in'. If you decide to play around and change any of the parameters in the file 'compile-params.in', there is no guarantee the automated compilation process won't break. There are following important parameters in the 'compile-params.in' file you should check and (if needed) change - before you start the compilation script 'all.sh'. Those are (use 'nano compile-params.in' to edit the compilation parameters):

Parameter: octave64_gitroot = ${HOME}/octave-3.8.2-enable-64-ubuntu-14.04

In the above example while compiling it in /opt directory set the git root folder accordingly to 'export octave64_gitroot = /opt/octave-3.8.2-enable-64-ubuntu-14.04'
        
Parameter: export prefix64=/usr/local

This is where the compiled libraries and octave will be installed - into sub-directories (/lib, /bin, /include, /share, ...) of this folder
        
Parameter: export octave64_SS_version=4.2.1

Which version of SuiteSparse library should be used. We recommend the default 4.2.1. Alternative 4.4.1 is also prepared for compilation but this won't include use of "CHOLMOD" library as in the versions of SuiteSparse 4.3.x the SuiteSparse API has chnaged which is causing compilation issues of Octave if CHOLMOD is used.
        
Parameter: export octave64_libs_compilation_test=N

You can alternatively swicth this to 'Y' in order to execute tests of compiled libraries. The overall compilation time will be then longer but you can check for errors and warning reported by the particular library tests after their compilation from source.
        
Parameter: export octave64_compilation_test=Y

By default we want Ocatve compilation process to run final tests. To speed up - you can switch to 'N'.    


The script 'all.sh' will execute following scripts in this order:

    a) Script '1-compile-install-prereq.sh' (Internet connection required)
    
This installs all required libraries and tools for compilation using apt-get command. The tools & libraries to be installed are approximetly 1 GB of size (for Ubuntu 14.04 LTS and 14.04.1 LTS) thus the whole download and installation procedure takes some time depending on your Internet connection speed and alos depending on speed of your HW. In case compilation without documentation ("--disable-docs") is only needed, you do not have to install texlive and can save approximately 580MB of texlive installation to be downloaded.
    
    b) Script '2-compile-unpack-src.sh' - unpacks all sources of used libraries and sources of Octave 3.8.2 (currently latest).
       
All sources are stored in archive files in subdirectory 'x64-libs\_archives' - those are orignal versions downloaded from their respective web sites (see below for links to original web sites). Feel free to replace them with your own downloaded files or newer versions of those used libraries. Remark: If you want use newer versions you might need to play with the automation script source codes to make sure the rest of the automated compilation works fine.
       
    c)  Script '3-compile-64-libs.sh' - Compiles & installs required libraries in mode to support 64-bit indexing.
    
In order to succeed with compilation of the libraries in 64-bit indexing mode it uses patches of the source code (mostly compiling options) which are stored in sub-directory 'x64-libs\_mods\<library_name>.mod' for each library. Those patches stored here might be version specific and might not work well if you decide to compile this repository with newer version(s).
    
    d) Script '4-compile-64-octave.sh' - Compiles Octave 3.8.2 sources with 64-bit indexing (option --enable-64) and uses the pre-compiled libraries from the step c) above.  
    
At the end of the Octave source code compilation it runs Octave internal tests (by calling 'make check' in octave source directory) - all test are supposed to succeed - this is the expected output at the end of the script after running make check:
    
            Summary: 
            
                  PASS     11561    (or 11543 if SuiteSparse 4.4.1 is used with switch '--without-cholmod')
                  FAIL         0
                  XFAIL        7
                  SKIPPED     36    (or 52 if SuiteSparse 4.4.1 is used with switch '--without-cholmod')

REMARK: All scripts above in steps a) to d) store full output (stdout and stderr) into file with same name as the script name and extension .log - i.e. 2-compile-unpack-src.log, 3-compile-64-libs.log, etc. You can check those for more details while troubleshooting issues.
    
    e) Script '5-run_64bit_octave.sh' - Runs compiled Octave with 64-bit indexing enabled in interactive mode. 
    
You can test whether it works as you need. I.e. you can test whether you can allocate large memory arrays which require 64-bit index for it's elements:
    
       octave:1> a = zeros (1024*1024*1024*3, 1, 'int8');
        
If you have enough of free memory (3GB of physical memory + swap file(s) size) then you should *NOT* get this error which you will get in octave with default 32-bit indexing:
        
        error: memory exhausted or requested size too large
        for range of Octave's index type 
    
In regular Octave with 32-bit indexing would the output of the above command:
    
        octave:15> a = zeros (2147483647, 1, 'int8');
        error: out of memory or dimension too large for Octave's index type

6) If you are satisfied with Octave compilation with enabled 64bit indexing you can cd to Octave sources directory (octave-3.8.2) and install Octave by running command 'sudo make install'. 

    sudo su
    cd /opt/octave-3.8.2-enable-64-ubuntu-14.04/octave-3.8.2
    make install
    
After successfull installation you can type 'octave' from any terminal window to run your 64-bit indexing enabled Octave. 

REMARK: It might be necessary to set environment variables LD_LIBRARY_PATH and LD_RUN_PATH to the folder where the 64-bit indexing enabled libraries were installed. In the 'config-params.in' file in thos repo the folder for the libraries is stored in the environment variable ${prefix64}/lib (i.e. /usr/local/lib). Thus those commands might be handy to be included in the user profile:

    export LD_LIBRARY_PATH=${prefix64}/lib
    export LD_RUN_PATH=${prefix64}/lib

Enjoy! Richard Calaba (calaba@gmail.com)

(And feel free to improve this repo, make it more/better automated, less version dependent and bugs-free!)

Virtual Applicance - VM image - with pre-compiled Octave 3.8.2 on Ubuntu Desktop 14.10 LTS:
===========================================================================================

If you were so patient to read the readme till here -> then there is a small reward in case you do not want to run the whole compilation on your own (approximately 3 hours (depending on your interent and HW speed) - including installation of the Ubuntu / Updates / git repository and needed tools). Without any guarantee on security / stability and what so ever - here is the OVA file to get your Octave 3.8.2 with 64-bit indexing enabled. 

Download here (4.3 GB): https://drive.google.com/file/d/0Bz5GkHbD3o7KN012dFVodnNfbTg/view?usp=sharing
    
                        (The default password of the both 'root' user and 'octave' user is 'password')


3rd party libraries - required to re-compile Octave with --enable-64:
=====================================================================

All libraries which are required by Octave are referred here:

    1) https://www.gnu.org/software/octave/doc/interpreter/External-Packages.html 

However only some of them require re-compilation with 64-bit enabled indexing, as mentioned for example here:

    2) https://www.gnu.org/software/octave/doc/interpreter/Compiling-Octave-with-64_002dbit-Indexing.html

and also here:

    3) http://octave.1599824.n4.nabble.com/make-test-failure-d1mach-i-out-of-bounds-td2286214.html

Following libraries are used to compile Octave with 64-bit indexing:
--------------------------------------------------------------------

Octave 3.8.2 Sources:
---------------------

Home:               http://www.gnu.org/software/octave/download.html

Octave Source Code: ftp://ftp.gnu.org/gnu/octave/octave-3.8.2.tar.gz


SS-4.2.1/SuiteSparse-4.2.1.tar.gz or SS-4.4.1/SuiteSparse-4.4.1.tar.gz
----------------------------------------------------------------------

Home:           http://faculty.cse.tamu.edu/davis/suitesparse.html

Library Source: http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.2.1.tar.gz
Library Source: http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.4.1.tar.gz

If you use Suite Sparse 4.4.1 without disabling use of the cholmod library (./configure --without-cholmod) then you will get following errors during Octave sources compilation (due to change of API interface in versions SuiteSparse 4.3.x and above):

> 
> array/CSparse.cc:5667:19: error: 'cholmod_common' has no member named 'print_function'
>                cm->print_function = 0;
>                    ^
> array/CSparse.cc:5672:19: error: 'cholmod_common' has no member named 'print_function'
>                cm->print_function =&SparseCholPrint;
>                    ^
> array/CSparse.cc:5676:15: error: 'cholmod_common' has no member named 'complex_divide'
>            cm->complex_divide = CHOLMOD_NAME(divcomplex);
>                ^
> array/CSparse.cc:5677:15: error: 'cholmod_common' has no member named 'hypotenuse'
>            cm->hypotenuse = CHOLMOD_NAME(hypot);
> 
... and more ...

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


SS-4.2.1/metis-4.0.1.tar.gz or SS-4.4.1/metis-4.0.3.tar.gz
----------------------------------------------------------

Metis library is optionally needed for SuiteSparse compilation, the SuiteSparse 4.4.1 README is mentioning use of Metis 4.0.1 however Metis 4.0.1 doesn't compile by defualt so I used Metis 4.0.3 which seemd to work fine. 

For the SuiteSparse 4.2.1 we use the Metis 4.0.1 with some modifications as documented on the Internet in order to get it compiled.

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

Not used libraries (feel free to plug them in):
-----------------------------------------------

In addition in the sub-folder '_not_used' of the folder where all the source archives of used libraries are located there there are following libraries:

ATLAS atlas3.10.2.tar.bz2 (BLAS / LAPACK replacement) 
-----------------------------------------------------

Home:   https://sourceforge.net/projects/math-atlas/files/

Source: http://sourceforge.net/projects/math-atlas/files/Stable/3.10.2/atlas3.10.2.tar.bz2/download
  
Arpack-Ng - newer and more optimized ARPACK version
---------------------------------------------------

Home:       https://github.com/opencollab/arpack-ng

Source:     http://forge.scilab.org/index.php/p/arpack-ng/downloads/get/arpack-ng_3.1.5.tar.gz
    

References to Octave compilation troubleshooting Web Sites:
==========================================================

You can tweak this compilation process by changing parameters in file 'compile-params.in'. The main parameter is the location of the shared libraries which need to be recompiled for Octave to run in 64-bit indexing mode. Besides this parameter you can tune the compilation process to speed it up or slow it down by specifying whether you want (skip) testing of the compiled libraries and Octave. You can also specify that you do not want to compile documentation or add any other (experimental) compilation option of Octave (./configure --help). Be carefull while changing the setting in this file. If you do any changes in the file 'compile-params.in' and the compilation process seems working okay (congratulations),  I still rcommmend to check the generated output log files (*.log) to make sure there are no new warnings and errors generated and taht the octave internal tests do not skip more tests (SKIPPED) and the number of failed tests (FAIL) doesn't increase. 

While working on this Octave compilation challenge I had to research a lot of issues which I was facing while trying to succeed with the 64-bit indexing enabled Octave. There were many trials and errors. I wouldn't succeed (or would give up wasting my time) wouldn't it be many various posts on the Internet addressing same/similiar issues I was facing. It is not in my power to mention all of those sites which helped me to get some clues how to workaround som of the compilation or testing issues. Here below I am listing at least some of them ...

1) https://lists.gnu.org/archive/html/octave-bug-tracker/2014-08/msg00210.html

2) https://lists.gnu.org/archive/html/octave-bug-tracker/2014-08/msg00218.html

3) http://ubuntuforums.org/showthread.php?t=1200824

4) http://octave.1599824.n4.nabble.com/Re-jni-h-file-not-found-td4660656.html

5) https://software.intel.com/en-us/forums/topic/362169

6) http://www.flaterco.com/kb/Octave.html

7) http://octave.1599824.n4.nabble.com/Octave-2-9-9-Compile-Problem-on-Linux-i686-td1605865.html

8) http://simon.bonners.ca/blog///blog5.php/installing-arpack-1-0-8-in-octave-for-ub-10

9) http://blog.csdn.net/tiandaonuaa/article/details/6376882

10) http://wiki.chpc.ac.za/howto:compiling_octave

Octave Sources compilation 32-bit indexing mode (default):
==========================================================

For troubleshooting purposes if you wanna compare what is happening in the logs being produced while compiling Octave 3.8.2 from it's sources on Ubuntu 14.04 / 14.04.1 - here adding step-by-step scenario how to compile Octave with standard options (without the --enable-64 indexing):

1) Install Ubuntu Linux Desktop 14.04 from ISO distribution file (Installation CD-ROM can be downloaded from original distribution site http://mirror.anl.gov/pub/ubuntu-iso/DVDs/ubuntu/14.04/release/). The compilation and installation procedures might work on later versions of Ubuntu Linux Desktop as well.

2) (optional) Update Ubuntu Linux Desktop with latest updates (Internet connection required)

3) Download Octave sources (ftp://ftp.gnu.org/gnu/octave/octave-3.8.2.tar.gz) and extract it to /opt directory (as root)

4) Run the script 'sudo 1-compile-install-prereq.sh' - it will install required tools and libs for compilation. It might install too much ... (1 GB)

5) In addition install manually standard libraries required by Octave:

    (as root)
    sudo apt-get -y install  libblas-dev liblapack-dev libqhull-dev libglpk-dev libqrupdate-dev libsuitesparse-dev 
    sudo apt-get -y install  libarpack2 libarpack2-dev
    
6) (workaround) If the above apt-get install libarpack2 libarpack2-dev doesn't work) - compile ARPACK from sources and install it. Get the '/x64-libs/_archives/ARPACK/ARPACK' sub-directory of this Repo - copy it to the /opt directory. Then  make & instal the ARPACK library as follows:

    (as root - assuming ARPACK flder and files and the make_so_lib.sh script are copied into /opt/ARPACK)
    sudo su
    cd /opt/ARPACK
    nano ARmake.inc
    --> edit the ARmake.inc file 
    --> find 'home = $(HOME)/ARPACK' and replace it with 'home = /opt/ARPACK'
    --> find 'ARPACKLIB  = $(home)/libarpack_$(PLAT).a' and repalce it with 'ARPACKLIB  = $(home)/libarpack.a'
    --> find 'FC      = f77' and replace it with 'FC      = gfortran'
    --> find 'FFLAGS  = -O -cg89' and replace it with 'FFLAGS  = -O -fPIC'
    --> find 'MAKE    = /bin/make' and replace it with 'MAKE    = /usr/bin/make'
    --> Then save the file ARmake.inc
    make lib
    --> create so lib
    mkdir tmp 
    cd tmp 
    ar x ../libarpack.a 
    gcc -shared -o ../libarpack.so *.o -L/usr/local/lib -llapack -lblas 
    cd .. 
    rm -Rf tmp 
    --> copy libs to /usr/local/lib
    cp -f libarpack.a /usr/local/lib
    cp -f libarpack.so /usr/local/lib

7) Configure the Octave sources for compilation:

    (as root)
    cd /opt/octave-3.8.2
    export JAVA_HOME=/usr/lib/jvm/default-java
    export LD_LIBRARY_PATH=/usr/local/lib
    export LD_RUN_PATH=/usr/local/lib
    ./configure > configure.log
    
You will get following error/warning output:

    root@ubuntu:/opt/octave-3.8.2# ./configure > configure.log
    configure: WARNING: UNEXPECTED: found nth_element working in g++ 4.8.2.  Has it been patched on your system?
    configure: WARNING: UNEXPECTED: found nth_element working in g++ 4.8.2.  Has it been patched on your system?
    root@ubuntu:/opt/octave-3.8.2# 

8) Make Octave

    (as root)
    make > make.log

You will get following error/warning output:

>     root@ubuntu:/opt/octave-3.8.2# make > make.log
>     Makefile:2848: warning: overriding commands for target `check'
>     Makefile:2410: warning: ignoring old commands for target `check'
>     Makefile:2848: warning: overriding commands for target `check'
>     Makefile:2410: warning: ignoring old commands for target `check'
>   ... many others ...

8) Test Octave

    (as root)
    make check

    You will get following test output at the end:
    
    Summary:

      PASS     11561
      FAIL         0
      XFAIL        7
      SKIPPED     36
        See the file test/fntests.log for additional details.
      
    See the file test/fntests.log for additional details.
    Expected failures (listed as XFAIL above) are known bugs.
    Please help improve Octave by contributing fixes for them.

    The 36 SKIPPED test packages are all because of the experimental feature of LVVM based Just-In-Time (JIT) compiling. 
    
    If you are getting more SKIPPED tests - then you are missing some libraries for optional functionality!
    
    REMARK: If you want to play with Just-In-Time compiling in Octave - use "--jit-enable" switch in ./configure script (use ./configure --help for more options and help). Some more details about compiling Octave with JIT - see following blog http://blogs.bu.edu/mhirsch/2013/12/compiling-octave-3-8/ .

