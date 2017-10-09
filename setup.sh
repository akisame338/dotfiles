#!/bin/bash
CWD=`pwd`
DOT_FILES=`find $CWD -type f | grep -E "$CWD/\." | grep -v -E "$CWD/\.git/" | sed s:$CWD/::g`
for file in $DOT_FILES
do
    ln -sfnv $CWD/$file $HOME/$file
done
