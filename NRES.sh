#!/bin/bash
 
if [ -f src/fz_clips ]
then
    cd src
    ./fz_clips -f2 main.clp
else
    echo "Can't run NRES because FUZZYClips executable doesn't exists!"
fi

