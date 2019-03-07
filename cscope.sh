#!/bin/bash
loc=$1
pushd $loc
find $loc -name '*.c' -o -name '*.h' > $loc/cscope.files
cscope -b
popd
