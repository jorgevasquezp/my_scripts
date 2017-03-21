#! /usr/bin/env python3
import re, sys, shutil, os, re, codecs
import xml.etree.ElementTree as ET

print("MAkinE AFX Collecting tool. Copyleft 2016 yorch")
args = sys.argv[1:]
name = args[0]



dest = input("Please enter the destination path for your collect:\n")

# tested on mac only

#def get_files( text_file ):
    
    #re_ptn=re.compile("(?<=fullpath\=\")[^\"]*")
    
    #report = open(str( text_file ), 'r')
    #report_text = str(report.read())
    
    #matches= re_ptn.findall(report_text)
        
    #return matches

def get_files( text_file ):
    
    ET.register_namespace("", "http://www.adobe.com/products/aftereffects")
    
    with open(name, 'r') as xml_file:
        xml_tree = ET.parse(xml_file)
    root = xml_tree.getroot()
    
    for Pin in root.iter("{http://www.adobe.com/products/aftereffects}Item"): #<Pin> elements seem to contain file references
        for fileRef in Pin.iter("{http://www.adobe.com/products/aftereffects}fileReference"):
            filepath = fileRef.attrib["fullpath"]
            isFile = os.path.isfile(fileRef.attrib["fullpath"])
            
            if isFile:
                copy_file( filepath , dest )
                fileRef.set("fullpath",dest + os.path.basename(filepath))
            else:
                fileRef.set("fullpath",dest + os.path.basename(filepath))
        #print( "asasas", Pin[0].attrib["bdata"] )
            #fileRef.set("fullpath",dest + os.path.basename(filepath))
    print('writing to', os.path.dirname(name)+os.sep+os.path.basename(name).split(".")[0]+"_collected"+ os.path.extsep + os.path.basename(name).split(".")[1])
    print('alternatively write to', dest+'..'+os.sep+ os.path.basename(name))
    
    #xml_tree.write(os.path.dirname(name)+os.sep+os.path.basename(name).split(".")[0]+"_collected"+ os.path.extsep + os.path.basename(name).split(".")[1],encoding="utf-8")
    xml_tree.write( dest+'..'+os.sep+ os.path.basename(name) ,encoding="utf-8")
    
    #for item in root.iter("{http://www.adobe.com/products/aftereffects}fileReference"):
        
        #filepath = item.attrib["fullpath"]
        #isFile = os.path.isfile(item.attrib["fullpath"])
        #if isFile:
            #item.set("fullpath",dest + os.path.basename(filepath))
        #print(item.attrib, isFile )
    #xml_tree.write(os.path.dirname(name)+os.sep+os.path.basename(name).split(".")[0]+"_collect"+ os.path.extsep + os.path.basename(name).split(".")[1],encoding="utf-8")
    #xml_file.close()
    
    return 
    
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

def copy_file( f , dest ):
    
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

def copy_files( files , dest ):

    for f in files:
        copy_file( f , dest )
        
            

#for i in get_files( name ):
#    print(i)
#copy_files( get_seqs( name ), dest )
#copy_files( get_files( name ), dest )
get_files( name)

for i in range(0,4):
    print('\a')
    
print('DONE')

