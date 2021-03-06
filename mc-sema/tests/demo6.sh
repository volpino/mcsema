#!/bin/bash

source env.sh

rm -f demo_test6.cfg demo_driver6.o demo_test6.o demo_test6_mine.o demo_driver6.exe

${CC} -ggdb -m32 -c -o demo_test6.o demo_test6.c

if [ -e "${IDA_PATH}/idaq" ]
then
    echo "Using IDA to recover CFG"
    ${BIN_DESCEND_PATH}/bin_descend_wrapper.py -func-map="demo6_map.txt" -entry-symbol=doWork -i=demo_test6.o 
else
    echo "Using bin_descend to recover CFG"
    ${BIN_DESCEND_PATH}/bin_descend -d -func-map="demo6_map.txt" -entry-symbol=doWork -i=demo_test6.o
fi

${CFG_TO_BC_PATH}/cfg_to_bc -i demo_test6.cfg -driver=demo6_entry,doWork,2,return,C -o demo_test6.bc

${LLVM_PATH}/opt -O3 -o demo_test6_opt.bc demo_test6.bc
${LLVM_PATH}/llc -filetype=obj -o demo_test6_mine.o demo_test6_opt.bc
${CC} -ggdb -m32 -o demo_driver6.exe demo_driver6.c demo_test6_mine.o
./demo_driver6.exe
