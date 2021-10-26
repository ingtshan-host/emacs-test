#!/bin/bash
# say you have excitable file names scel2pyim here
# and a lot scel/*.scel file to convert to pyim/$same-pinyin-name.pyim
# then here is the script for batch converting
# all in and out remain in current dir
for file in scel/*.scel; do
    newfile="pyim/$(./hz2py.sh $(basename -- $file))"
    newfile="${newfile%%.*}.pyim"
    ./scel2pyim $file $newfile
    echo "${file%%.*}  var/pyim-dicts/${newfile}"
done
