#! /usr/bin/env python3
import re, sys, shutil, os, re

print("MAkinE AFX Collecting tool. Copyleft 2016 yorch")
args = sys.argv[1:]
name = args[0]

dest = input("Please enter the destination path for your collect:\n")

# tested on mac only

def get_files( text_file ):
    
    report = open(str( text_file ), 'r')
    report_lines = []
    
    for line in report:
        report_lines.append(line)

    files = []
    
    for line in report_lines:
        line_content = line
        if line_content.find("\t/") != -1:
            files.append(line_content[1:-1])
    
    return files

def get_seqs( text_file ):
    
    report = open(str( text_file ), 'r')
    report_lines = []
    
    for line in report:
        report_lines.append(line)

    seqs = []
    
    for line in report_lines:
        line_content = line
        if line_content.find("\tSequence") != -1:
            begin_path = line_content.find("at ")+3
            end_path = line_content.find(" with ") ### HACKISH: Try using regex to reliably finding out the end of the path.
            seqs.append(line_content[begin_path:end_path])
    
    return seqs


def copy_files( files , dest ):

    for f in files:
        
        the_file=os.path.basename(f)
        
        if os.path.isfile(f):
            if not os.path.exists(dest + os.sep + the_file ):
                print("Copying: " + the_file + " ---> " + dest)
                shutil.copy(f,dest);
            else:
                print("Skipping: " + the_file)
        else:
            if not os.path.exists(dest + os.sep + the_file ):
                print("Copying folder: " + the_file + " ---> " + dest + os.sep + the_file )
                shutil.copytree(f, dest +os.sep + the_file );
            else:
                print("Skipping folder: " + the_file)
            

#print(get_seqs( name ))
copy_files( get_seqs( name ), dest )
copy_files( get_files( name ), dest )

