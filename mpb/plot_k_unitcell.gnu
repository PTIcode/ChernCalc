#!/usr/bin/gnuplot

set term pngcairo enhanced font 'Helvetica,25' size 1200,900
set out 'k_unitcell.png'

plot 'k_unitcell_plot.txt' u 1:2 w p pt 5 lc rgb 'blue'
