#!/bin/bash
errcnt=0

for curfile in /usr/bin/{*btrfs*,*xfs*,featherpad,ms-sys,nwipe,udp*,whdd,zerofree} /opt/firefox*/firefox*
do
    test -x ${curfile} || continue
    file --mime ${curfile} | grep -q x-pie-executable || continue

    if ldd ${curfile} | grep -q -F 'not found'
    then
        echo "ERROR: Program ${curfile} is missing libraries"
        ldd ${curfile}
        errcnt=$((errcnt + 1))
    fi

done

if [ ${errcnt} -eq 0 ]
then
    echo "SUCCESS: Have not found any missing library"
    exit 0
else
    echo "FAILURE: Have found ${errcnt} issues"
    exit 1
fi