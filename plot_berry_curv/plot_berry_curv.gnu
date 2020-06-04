#!/usr/bin/gnuplot

xmin = 0
xmax = 1
ymin = -1/sqrt(3)
ymax = 2/sqrt(3)


#=======================================
reset 
set terminal pngcairo enhanced color font 'Helvetica,20' size 600, 600
set out 'Berry_curvature_map_band'.suffix.'.png'

set pm3d map
set size ratio -1
#set title title_name
unset key
set xlabel "k_x (2{/Symbol p}/a)" offset 0,0.3
set ylabel "k_y (2{/Symbol p}/a)" offset 0.3,0
set cblabel "Berry curvature" offset 0.7, 0
set xr [xmin:xmax]
set yr [ymin:ymax]
#set zr [-2:2]
set xtics offset 0,0.4 0.4
set ytics offset 0.4,0 0.4
set cbrange [-2:2]
set palette defined (-1 "blue", 0 "white", 1 "red")

splot 'berry_curv_'.suffix.'_plot.txt' u 1:2:3 
#=======================================


#=======================================
reset 
set terminal pngcairo enhanced color font 'Helvetica,20' size 600, 600
set out 'Berry_curvature_K.png'

unset key
set xlabel "k_y (2{/Symbol p}/a)" offset 0.3,0
set ylabel "Berry curvature" offset 0.7, 0
set xr [ymin:ymax]

plot 'berry_curv_'.suffix.'_K.txt' u 1:2


