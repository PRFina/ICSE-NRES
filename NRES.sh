#!/bin/bash
EXECUTABLE="nres_fz_clips"
PROGRAM="main.clp"
if [ -f src/$EXECUTABLE ]
then
    cd src
    ./$EXECUTABLE -f2 $PROGRAM
else
    echo "Can't run NRES because nres_fz_clips executable doesn't exists!"
fi

