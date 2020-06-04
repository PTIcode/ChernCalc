#!/bin/bash

suffix='1'
Nky=30

name="berry_curv_"$suffix

rm $name"_plot.txt"
awk -v n=$Nky '1 ; NR % n == 0 {print ""}' $name".txt" > $name"_plot.txt"

gnuplot -e "suffix='$suffix'" plot_berry_curv.gnu 
