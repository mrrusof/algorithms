all:
	gcc -pedantic -DONLINE_JUDGE -o main.exe main.c

real: clean all
	for((i=0; i<1000; i++)); do \
	  (time ./main.exe <random.in) >random.out 2>&1; \
          grep real random.out | sed -e 's/real.*m//' -e 's/s//' >>random.real; \
        done

gcov: clean
	gcc -g -coverage -fprofile-instr-generate -fcoverage-mapping -pedantic -DONLINE_JUDGE -o main.exe main.c
	LLVM_PROFILE_FILE='main-%p.profraw' ./main.exe <random.in
	xcrun llvm-profdata merge -o main.profdata main*.profraw
	xcrun llvm-cov gcov main.exe
	xcrun llvm-cov show -show-line-counts -instr-profile main.profdata main.exe

clean:
	rm -rf *.exe *.dSYM *.profraw *.profdata *.gcno *.gcda *.gcov *.out *.real *~
