GitHub-Repo: calaba / octave-3.8.2-enable-64-ubuntu-14.04
=========================================================

Octave 3.8.2 source code compiled with "--enable-64" flag (experimental switch to enable 64bit indexing of memory objects) on x64 Ubuntu Linux Desktop 14.04 LTS. Successfull compilation and tests required some of the used libraries (BLAS, LAPACK, ...) to be re-compiled with 64bit indexing as well.

How to compile Octave with 64-bit indexing (experimental switch --enable-64):
=============================================================================

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
    
Additional parameters for tuning the compilation and libraries installation process are in the file 'compile-params.in'. If you decide to play around and change any of the parameters in the file 'compile-params.in', there is no guarantee the automated compilation process won't break.
    
It will execute following scripts in this order:

    a) Script '1-compile-install-prereq.sh' 
    
This installs all required libraries and tools for compilation using apt-get command. The tools & libraries to be installed are approximetly 1 GB (for Ubuntu 14.04 LTS and 14.04.1 LTS) of size thus the whole download and installation procedure takes some time depending on your Internet connection speed and speed of your HW. In case compilation without documentation ("--disable-docs") is only needed, you do not have to install texlive and can save approximately 580MB texlive installation to be downloaded.
    
    b) Script '2-compile-unpack-src.sh' - unpacks all sources of used libraries and sources of Octave 3.8.2 (currently latest).
       
All sources are stored in archive files in subdirectory 'x64-libs\_archives' - those are orignal versions downloaded from their respective web sites (see below for links to original web sites). Feel free to replace them with your own downloaded files or newer versions of those used libraries. Remark: If you want use newer versions you might need to play with the automatuion script source codes to make sure the rest of the automated compilation works fine.
       
    c)  Script '3-compile-64-libs.sh' - Compiles & installs required libraries in mode to support 64-bit indexing.
    
In order to succeed with compilation of the libraries in 64-bit indexing mode it uses patches of the source code (mostly compiling options) which are stored in sub-directory 'x64-libs\_mods\<library_name>.mod' for each library. Those patches stored here might be version specific and might not work well if you decide to compile this repository with newer version(s).
    
    d) Script '4-compile-64-octave.sh' - Compiles Octave 3.8.2 sources with 64-bit indexing (option --enable-64) and uses the pre-compiled libraries from the step c) above.  
    
At the end of the Octave source code compilation it runs Octave internal tests (by calling 'make check' in octave source directory) - all test are sopposed to succeed - this is the expected output at the end of the script after running make check:
    
            <TODO> fill correct values:
            Summary: 
            
              PASS     11202
              FAIL         0
              XFAIL        7
              SKIPPED    395

REMARK: All scripts above in steps a) to d) store full output (stdout and stderr) into file with same name as the script name and extension .log - i.e. 2-compile-unpack-src.log, 3-compile-64-libs.log, etc. You can check those for more details while troubleshooting issues.
    
    e) Script '5-run_64bit_octave.sh' - Runs compiled Octave with 64-bit indexing enabled in interactive mode. 
    
You can test whether it works as you need. I.e. you can test whether you can allocate large memory arrays which require 64-bit index for it's elements:
    
       octave:1> a = zeros (1024*1024*1024*3, 1, 'int8');
        
If you have enough of free memory (3GB of physical memory + swap file(s) size) then you should not get this error which you will get in octave with default 32-bit indexing:
        
        error: memory exhausted or requested size too large
        for range of Octave's index type 
    
In regular Octave with 32-bit indexing the physical limit of the memory array index seems to be (2^31 - 31 bits), this is the output of memory allocation of 2GBs and (2GBs - 1 Byte) in regular octave 3.8.2:
    
        octave:15> a = zeros (2147483647, 1, 'int8');
        error: out of memory or dimension too large for Octave's index type
        octave:15> a = zeros (2147483646, 1, 'int8');
        octave:16> 

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


3rd party libraries - required to re-compile Octave with --enable-64:
=====================================================================

All libraries which are required by Octave are referred here:

    1) https://www.gnu.org/software/octave/doc/interpreter/External-Packages.html 

However only some of them require re-compilation with 64bit enabled indexing as mentioned here:

    2) https://www.gnu.org/software/octave/doc/interpreter/Compiling-Octave-with-64_002dbit-Indexing.html

and also here:

    3) http://octave.1599824.n4.nabble.com/make-test-failure-d1mach-i-out-of-bounds-td2286214.html

Following libraries are used to compile Octave with 64-bit indexing:
--------------------------------------------------------------------

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
    
    Metis-4.0.1
    -----------

    As mentioned above - Metis 4.0.1 doesn't compile in Ubuntu Desktop 14.04 - thus using Metis 4.0.3


References to Octave compilation troubleshooting Web Sites:
==========================================================

While working on this Octave compilation challenge I had to research a lot of issues which I was facing while trying to succeed with the 64-bit indexing enabled Octave. There were many trials and errors. I wouldn't succeed (or would give up wasting my time) wouldn't it be many various posts on the Internet addressing same/similiar issues I was facing. It is not in my power to mention all of those sites which helped me to get some clues how to workaround som of the compilation or testing issues. Here below I am listing at least some of them ...

1) https://lists.gnu.org/archive/html/octave-bug-tracker/2014-08/msg00210.html

2) https://lists.gnu.org/archive/html/octave-bug-tracker/2014-08/msg00218.html

3) http://ubuntuforums.org/showthread.php?t=1200824

4) http://octave.1599824.n4.nabble.com/Re-jni-h-file-not-found-td4660656.html

5) https://software.intel.com/en-us/forums/topic/362169

6) http://www.flaterco.com/kb/Octave.html

7) http://octave.1599824.n4.nabble.com/Octave-2-9-9-Compile-Problem-on-Linux-i686-td1605865.html

8) http://simon.bonners.ca/blog///blog5.php/installing-arpack-1-0-8-in-octave-for-ub-10

Octave Sources compilation 32-bit indexing mode (default):
==========================================================

For troubleshooting purposes if you wanna compare what is happening in the logs being produced while compiling Octave 3.8.2 from it's sources on Ubuntu 14.04 / 14.04.1 - here adding step-by-step scenari how to compile Octave with standard options (without the --enable-64 indexing):

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

    root@ubuntu:/opt/octave-3.8.2# make > make.log
    Makefile:2848: warning: overriding commands for target `check'
    Makefile:2410: warning: ignoring old commands for target `check'
    Makefile:2848: warning: overriding commands for target `check'
    Makefile:2410: warning: ignoring old commands for target `check'
    system/.libs/libsystem.a(system_libsystem_la-file-ops.o): In function `octave_tempnam(std::string const&, std::string const&, std::string&)':
    /opt/octave-3.8.2/liboctave/system/file-ops.cc:664: warning: the use of `tempnam' is dangerous, better use `mkstemp'
    parse-tree/lex.cc:3922:13: warning: unused parameter 'yyscanner' [-Wunused-parameter]
     static void yy_fatal_error (yyconst char* msg , yyscan_t yyscanner)
                 ^
    parse-tree/lex.cc:4254:7: warning: unused parameter 'yyscanner' [-Wunused-parameter]
     void *octave_alloc (yy_size_t  size , yyscan_t yyscanner)
           ^
    parse-tree/lex.cc:4259:7: warning: unused parameter 'yyscanner' [-Wunused-parameter]
     void *octave_realloc  (void * ptr, yy_size_t  size , yyscan_t yyscanner)
           ^
    parse-tree/lex.cc:4271:6: warning: unused parameter 'yyscanner' [-Wunused-parameter]
     void octave_free (void * ptr , yyscan_t yyscanner)
          ^
          
    In file included from octave-value/ov-cx-diag.cc:32:0:
    octave-value/ov-base-diag.cc: In member function 'octave_value octave_base_diag<DMT, MT>::do_index_op(const
    octave_value_list&, bool)':
    octave-value/ov-base-diag.cc:103:38: warning: typedef 'el_type' locally defined but not used [-Wunused-local-typedefs]
       typedef typename DMT::element_type el_type;
                                  ^
    In file included from octave-value/ov-flt-cx-diag.cc:30:0:
    octave-value/ov-base-diag.cc: In member function 'octave_value octave_base_diag<DMT, MT>::do_index_op(const
    octave_value_list&, bool)':
    octave-value/ov-base-diag.cc:103:38: warning: typedef 'el_type' locally defined but not used [-Wunused-local-typedefs]
       typedef typename DMT::element_type el_type;
                                      ^
    In file included from octave-value/ov-flt-re-diag.cc:30:0:
    octave-value/ov-base-diag.cc: In member function 'octave_value octave_base_diag<DMT, MT>::do_index_op(const
    octave_value_list&, bool)':
    octave-value/ov-base-diag.cc:103:38: warning: typedef 'el_type' locally defined but not used [-Wunused-local-typedefs]
       typedef typename DMT::element_type el_type;
                                      ^
    octave-value/ov-perm.cc: In member function 'virtual bool octave_perm_matrix::save_ascii(std::ostream&)':
    octave-value/ov-perm.cc:263:39: warning: typedef 'idx_int_type' locally defined but not used [-Wunused-local-typedefs]
       typedef octave_int<octave_idx_type> idx_int_type;
                                           ^
    octave-value/ov-perm.cc: In member function 'virtual bool octave_perm_matrix::load_ascii(std::istream&)':
    octave-value/ov-perm.cc:280:39: warning: typedef 'idx_int_type' locally defined but not used [-Wunused-local-typedefs]
       typedef octave_int<octave_idx_type> idx_int_type;
                                           ^
    In file included from octave-value/ov-re-diag.cc:31:0:
    octave-value/ov-base-diag.cc: In member function 'octave_value octave_base_diag<DMT, MT>::do_index_op(const
    octave_value_list&, bool)':
    octave-value/ov-base-diag.cc:103:38: warning: typedef 'el_type' locally defined but not used [-Wunused-local-typedefs]
       typedef typename DMT::element_type el_type;
                                          ^

    
       src/octave-gui.cc:91:1: warning: unused parameter 'msg' [-Wunused-parameter]
    Warning: dropping duplicate messages in 'languages/be_BY.qm':
    
    * Context: files_dock_widget
    * Source: Find Files...
    
    Warning: dropping duplicate messages in 'languages/de_DE.qm':
    
    * Context: files_dock_widget
    * Source: Find Files...
    
    Warning: dropping duplicate messages in 'languages/en_US.qm':
    
    * Context: files_dock_widget
    * Source: Find Files...
    
    Warning: dropping duplicate messages in 'languages/es_ES.qm':
    
    * Context: files_dock_widget
    * Source: Find Files...
    
    Warning: dropping duplicate messages in 'languages/fr_FR.qm':
    
    * Context: files_dock_widget
    * Source: Find Files...
    
    Warning: dropping duplicate messages in 'languages/nl_NL.qm':
    
    * Context: files_dock_widget

   * Source: Find Files...

    Warning: dropping duplicate messages in 'languages/pt_BR.qm':
    
    * Context: files_dock_widget
    * Source: Find Files...
    
    Warning: dropping duplicate messages in 'languages/pt_PT.qm':
    
    * Context: files_dock_widget
    * Source: Find Files...
    
    Warning: dropping duplicate messages in 'languages/ru_RU.qm':
    
    * Context: files_dock_widget
    * Source: Find Files...
    
    Warning: dropping duplicate messages in 'languages/uk_UA.qm':
    
    * Context: files_dock_widget
    * Source: Find Files...
    
    In file included from main.cc:70:0:
    main.cc: In function ‘bool display_available(std::string&)’:
    main.cc:108:52: warning: use of old-style cast [-Wold-style-cast]
               Screen *screen = DefaultScreenOfDisplay (display);
                                                        ^
    main.cc:108:52: warning: use of old-style cast [-Wold-style-cast]
               Screen *screen = DefaultScreenOfDisplay (display);
                                                        ^
    warning: [options] bootstrap class path not set in conjunction with -source 1.3
    1 warning
    warning: [options] bootstrap class path not set in conjunction with -source 1.3
    1 warning
    warning: [options] bootstrap class path not set in conjunction with -source 1.3
    1 warning
    warning: [options] bootstrap class path not set in conjunction with -source 1.3
    Note: org/octave/JDialogBox.java uses or overrides a deprecated API.
    Note: Recompile with -Xlint:deprecation for details.
    1 warning
    Makefile:2848: warning: overriding commands for target `check'
    Makefile:2410: warning: ignoring old commands for target `check'
    Makefile:2565: warning: overriding commands for target `check'
    Makefile:2153: warning: ignoring old commands for target `check'
    Makefile:2565: warning: overriding commands for target `check'
    Makefile:2153: warning: ignoring old commands for target `check'
    Makefile:2848: warning: overriding commands for target `check'
    Makefile:2410: warning: ignoring old commands for target `check'
    root@ubuntu:/opt/octave-3.8.2# 

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

    The 36 SKIPPED test packages are all because of the experimental feature of LVVM based Just-In-Time compiling. 
    If you are getting more SKIPPED tests - then you are missing some libraries for optional functionality!




    
    
    
    



