orig_dir=$(pwd)
path=$(dirname $1)
dirname=$(basename $1)
cd $path;
find "$dirname"/ -type d -exec mkdir -p "$2"/{} \; -o -type f -exec touch "$2"/{} \;;
