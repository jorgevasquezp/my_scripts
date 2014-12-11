#! /usr/bin/env python3

import urllib.request,re,getopt,os,sys
argsx = "--platform=linux --arch=x64 --branch=gooseberry -p=linux -a=x64 -b=gooseberry".split()

try:
    print(sys.argv[1:])
    opts, args = getopt.getopt(argsx,"p:a:b:",["platform=","arch=","branch="])
    print(args)
    print('it worked')
except getopt.GetoptError as err:

    #print help information and exit:
    print(str(err)) # will print something like "option -a not recognized"
    #usage()
    print('it didn\'t worke')
    sys.exit(2)

class BBBD():
    def __init__(self):
        self.url="http://builder.blender.org/download"
        self.links = self.get_links()
    
    def get_links(self):
        ptn='(?<=href\=\")[^\"]*'
        source=urllib.request.urlopen(self.url).read().decode("utf-8")
        self.link=(re.findall(ptn,source))
        masked_links = []
        for l in range(0,len(self.link)):
            if self.link[l].find("blender") != -1:
                masked_links.append(self.link[l])
       
            
        self.link = masked_links

        return self.link
        
    def get_masked_links(self,*ptn):
        links = set(self.links)
        masked_links = set(links)
        for p in ptn:
            for l in links:
                if l.find(p) == -1:
                    if l in masked_links:
                        masked_links.remove(l)
        return masked_links
        
bd = BBBD()

for i in bd.get_masked_links('win',"64.","gooseberry"):
    print(bd.url+os.sep+i)


#~ for l in links:
    #~ print(url+os.sep+l,'/Users/makinegx15/Desktop'+os.sep+l)
    #~ urllib.request.urlretrieve(url+os.sep+l,'/Users/makinegx15/Desktop'+os.sep+l)
    #~ print('downloaded :'+l)
