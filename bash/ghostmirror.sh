find "$1"/ -type d -exec mkdir -p "$2"/{} \; -o -type f -exec touch "$2"/{} \;;
