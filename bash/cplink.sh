#!/bin/bash
for link
do
  loc="$(dirname "$link")"
  #echo 'loc = ' $loc
  dir="$(readlink "$link")"
  #echo 'dir = ' $dir
  mv "$dir" "$link"
  #echo rm "$link"
done
