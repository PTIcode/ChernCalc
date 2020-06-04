#!/bin/bash

file_name_in=$1
file_name_out=$2
pert=$3
Nband=$4
resolution=$5
kx=$6
ky=$7
suffix=$8


data=$file_name_out"_tm_"$suffix".dat"

path=$file_name_out"_"$suffix
rm -rf $path
mkdir $path
cp $file_name_in".ctl" $path/$file_name_in".ctl"
cd $path

mpb pert=$pert Nband=$Nband res=$resolution kx=$kx ky=$ky $file_name_in".ctl" >& $file_name_out"_"$suffix".out"

grep tmfreqs $file_name_out"_"$suffix".out" | sed 's/tmfreqs:,//' > $data

mpb-data -r -m 1 -n 100 $file_name_in"-epsilon.h5"
h5topng $file_name_in"-epsilon.h5:data-new"
#h5topng $file_name_in"-epsilon.h5"
h5totxt $file_name_in"-epsilon.h5" > epsilon.txt
rm $file_name_in"-epsilon.h5" 

#let "Nband_max = Nband + 1"

for i in `seq 1 1 $Nband`
do
#h5totxt -d z.r *b0$i.*.h5 > "ev_"$suffix"_"$i"_real.txt"
#h5totxt -d z.i *b0$i.*.h5 > "ev_"$suffix"_"$i"_imag.txt"
mv *b0$i.*.h5 "ev_"$suffix"_"$i".h5"
done

rm *.ctl
cp * ../
cd ../
rm -rf $path/


