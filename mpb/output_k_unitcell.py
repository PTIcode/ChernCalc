# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np
from math import sqrt, pi
import sys

kx = []
ky = []

Nkx = int(sys.argv[1])
Nky = int(sys.argv[2])

for nk1 in range(0,Nkx) :
	for nk2 in range(0,Nky) :
		if (nk1==0 and nk2==0) :
			nkx = 0#0.00005#1
			nky = 0
		else :
			kpath1 = nk1 * 1. / (Nkx)
			kpath2 = nk2 * 1. / (Nky)
			nkx = kpath1
			nky = kpath2

		kx.append(nkx)
		ky.append(nky)

f = open("k_unitcell.txt", "w")
for i in range(0, len(kx)):
		f.write( "_"+str(i)+"_x"+" "+str(kx[i])+"\n" )
		f.write( "_"+str(i)+"_y"+" "+str(ky[i])+"\n" )
f.close()



f2 = open("k_unitcell_plot.txt", "w")
for i in range(0, len(kx)):
		f2.write( str(kx[i])+" "+str(ky[i])+"\n" )
f2.close()
