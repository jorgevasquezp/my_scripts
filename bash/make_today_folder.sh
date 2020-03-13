#!/usr/bin/bash
TODAY_FOLDER=$(date +"%m%d%y")
if [ ! -d "$TODAY_FOLDER" ]; then
  mkdir "$TODAY_FOLDER"
fi
