 mkdir tmp 
 cd tmp 
 ar x ../libarpack.a 
 gcc -shared -o ../libarpack.so *.o -L${prefix64}/lib -llapack -lblas 
 cd .. 
 rm -Rf tmp 
