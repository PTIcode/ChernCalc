#!/bin/bash 

# var for main.sh : file_name_in file_name_out pert Nband resolution kx ky suffix
# ev file : ev_i.h5 ==>  i : nki
# txt file : ev_i_j.txt ==> i : nki, j : nband
# i=0->(Nkx+1)*(Nky+1)
# j=1->Nband

max_run=30
filename_in="kagome"
filename_out="kagome_pert"
pert=1.1
Nband=1
resolution=30
Nkx=30
Nky=30

echo "$Nband $resolution $Nkx $Nky" > params.txt

python output_k_unitcell.py $Nkx $Nky
let "Nk_tot = 2 * Nkx * Nky - 1"

gnuplot plot_k_unitcell.gnu

iter=0
i=0

for ki in `seq 0 2 $Nk_tot`;
do
if [ $iter -gt $max_run ]
then 
	wait 
	iter=0
fi
suffix=$i
kx=$(grep "_"$i"_x" k_unitcell.txt | sed "s/_"$i"_x//")
ky=$(grep "_"$i"_y" k_unitcell.txt | sed "s/_"$i"_y//")
./main_mpb.sh $filename_in $filename_out $pert $Nband $resolution $kx $ky $suffix & 

let "iter = iter + 1"
let "i = i + 1"
done

wait

mkdir f_output/
mkdir f_data/
mkdir f_txt/
mkdir f_ev/

cp params.txt f_ev/
cp epsilon.txt f_ev/
cp *.png f_ev/

mv *.out f_output/
mv *.dat f_data/
mv *.txt f_txt/
mv *.h5 f_ev/

cd f_txt/

#let "Nband_max = Nband - 1"
#for i in `seq 0 1 $Nband_max`
#do
#band_folder="f_txt_band"$i
#mkdir $band_folder/
#mv ev_*_$i.txt $band_folder/
#cp params.txt $band_folder/
#done

cd ../





#echo "===positive perturbed case..."
#./main_mpb.sh kagome kagome_pert_p 0.9

echo "finished"
