#!/bin/bash

allTests=0
failedTest=0

function okOut {
    if [ $? = 0 ] ; then
        echo OK
    else
        allTests=$[allTests+1]
        echo FAIL
    fi
}

for f in tests/*.ast; do
    file=${f%.*}
    echo "Test $(basename ${file}): "
    tmp=${allTests}
    if [[ $(basename ${file}) != *_bad ]] ; then
        printf " - Format = "
        [ "$(tail -n 2 ${file}.ast | head -n 1)" == "Format: OK" ]; okOut
        printf " - Typing = "
        [ "$(tail -n 1 ${file}.ast)" == "Typing: OK" ]; okOut
        printf " - Running assembly = "
        java -jar tammachine.jar ${file}.tamo > ${file}.res 2> /dev/null; okOut
        printf " - Comparing output = "
        diff <(sed -e '$a\' ${file}.res) <(sed -e '$a\' ${file}.out); okOut
    else
        printf " - Failing = "
        [ "$(tail -n 2 ${file}.ast | head -n 1 | tail -c 3 | head -c 2)" != "$(tail -n 1 ${file}.ast | tail -c 3 |
        head -c 2)" ] || [ $(cat ${file}.ast | sed '/^\s*$/d' | wc -l) -lt 3 ]; \
        okOut
    fi
    if [ ${allTests} -ne ${tmp} ] ; then
        failedTest=$[failedTest+1]
    fi
    echo ''
done

printf "Tests: "
[ ${failedTest} = 0 ]; okOut
printf "On %d Tests, %d Succeded and %d Failed\n" $(ls -1 tests/*.ast | wc -l) $[$(ls -1 tests/*.ast | wc -l)-failedTest] ${failedTest}

[ ${failedTest} = 0 ]; exit $?
