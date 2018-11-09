#!/bin/bash
sudo mount.cifs //mak-nas/pegasus /Volumes/pegasus -o credentials=/home/makine3d/.pgsscredentials,sec=ntlmv2,vers=2.0,gid=20,uid=1000,file_mode=0775,dir_mode=0775
