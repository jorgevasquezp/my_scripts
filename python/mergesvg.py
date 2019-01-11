#!/usr/bin/python
import svgutils.compose as c
import svgutils.transform as st
import sys,os

outfile = sys.argv[-1]
infiles = sys.argv[1:-1]

insvgs = [c.SVG(i) for i in infiles]
figure = c.Figure(
        "512px", "512px",
        *insvgs
      )
figure.save( os.getcwd()+os.sep+outfile )
#print ('Number of arguments:', len(sys.argv), 'arguments.')
#print ('Argument List:', str(sys.argv))

