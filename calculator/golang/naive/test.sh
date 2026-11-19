#!/bin/bash

for f in ../../tests/*.in; do
    f_no_ext=$(basename $f | sed 's/\.in//')
    expected_file=../../tests/$f_no_ext.out
    actual_file=/tmp/$f_no_ext.actual

    echo -n "$f_no_ext ... "

    go run main.go <$f >$actual_file 2>&1
    if [ $? != 0 ]; then
        echo FAIL
        continue
    fi

    diff $actual_file $expected_file
    if [ $? != 0 ]; then
        echo FAIL
        continue
    fi

    echo PASS
done
