#! /usr/bin/env python3

import urllib.request,re,getopt,os,sys
ver = 0.1
msg = "bbbd v" + str(ver) + ", a Python Blender Build-bot version downloader script." 
msg_use = "Usage: bbbd [ARGUMENTS]"
 
def main():
    print(msg)
    try:
        args=sys.argv[1:]
        opts, args = getopt.getopt(args,"p:a:b:",["platform=","arch=","branch="])
        
    except getopt.GetoptError as err:
        #print help information and exit:
        print(str(err)) # will print something like "option -a not recognized"
        #usage()
        sys.exit(2)

    url="http://builder.blender.org/download"
    identifiers=['linux','win','OSX','64.','86.']
    
    def get_branches():
        branches = []
        for i in opts:
            if i[0] == "-b":
                branches.append(i[1])
        
        return branches
    
    def get_links():
        ptn='(?<=href\=\")[^\"]*'
        source=urllib.request.urlopen(url).read().decode("utf-8")
        link=(re.findall(ptn,source))
        masked_links = []
        num_branches = len(get_branches())
        
        if(num_branches == 0):
            for l in range(0,len(link)):
                if link[l].find("blender") == 0:
                    masked_links.append(link[l])
        elif (num_branches>0):
            for l in range(0,len(link)):
                if link[l].find("blender") != -1:
                    masked_links.append(link[l])
        link = masked_links

        return link
        
    def get_masked_links(*ptn):
        
        links = set(get_links())
        masked_links = set(links)
        
        for p in ptn:
            for l in links:
                if l.find(p) == -1:
                    if l in masked_links:
                        masked_links.remove(l)
        return masked_links
            
    masks = []
    
    if ('-p', 'linux') in opts or ('--platform','linux') in opts:
        masks.append(identifiers[0])
    if ('-p', 'win') in opts or ('--platform','win') in opts:
        masks.append(identifiers[1])
    if ('-p', 'mac') in opts or ('--platform','mac') in opts:
        masks.append(identifiers[2])  
    if ('-a', 'x64') in opts or ('--arch','x64') in opts:
        masks.append(identifiers[3]) 
    if ('-a', 'x32') in opts or ('--arch','x32') in opts:
        masks.append(identifiers[4])            
    
    print(get_branches())
    
    for i in opts:
        if i[0] == "-b" and i[1] != "all" :
            masks.append(i[1])
    print(opts)    
    for i in get_masked_links(*masks):
        print(url+os.sep+i)
    
if __name__:
    main()

#~ for l in links:
    #~ print(url+os.sep+l,'/Users/makinegx15/Desktop'+os.sep+l)
    #~ urllib.request.urlretrieve(url+os.sep+l,'/Users/makinegx15/Desktop'+os.sep+l)
    #~ print('downloaded :'+l)
