#!/bin/bash

SRC_DIR="bin"
DEST_DIR="src"
EXEC_DEST="nres_fz_clips"

case "$(uname -s)" in 
    Linux)
        EXEC_SRC="nres_fz_clips_lnx"
        ;;
    Darwin)
        EXEC_SRC="nres_fz_clips_mac"
        ;;
esac

cp $SRC_DIR/$EXEC_SRC $DEST_DIR/$EXEC_DEST
if [ $? -eq 0 ]; then
    echo "NRES is installed, type ./NRES.sh"
else
    echo "Something wrong appened!"
fi