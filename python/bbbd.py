import urllib.request,re,getopt

def get_links(**options):
    url="http://builder.blender.org/download"
    ptn='(?<=href\=\")[^\"]*'
    source=urllib.request.urlopen(url).read().decode("utf-8")
    links=(re.findall(ptn,source))
    masked_links = []
    for l in range(0,len(links)):
        if links[l].find("blender") != -1:
            masked_links.append(links[l])
    try:
        opt = options.get()
    except TypeError:
        opt = "none"
    return masked_links
links = get_links()

for l in links:
    print(l)
