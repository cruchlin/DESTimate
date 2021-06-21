#!/bin/sh

user=username						#your ComputeCanada username 
mem=64G							#memory allocation (64G should be enough for most small molecules)
time=00-23:59						#time allocation for ALL calculations (DD-HH:MM)
email=your.name@mail.mcgill.ca				#email address for slurm notifications
dir=/project/6002427/shared/DESTimate_TEMPLATES		#leave as default, unless you change the template locations

for n in ""
do
  cd ./$n
  sed "s/FILENAME/$n/g" $dir/singsp_header.templ > ./singsp_header.tmp
  sed "s/FILENAME/$n/g" $dir/tgs_header.templ > ./tgs_header.tmp
  sed "s/FILENAME/$n/g" $dir/sing_header.templ > ./sing_header.tmp
  sed "s/FILENAME/$n/g ; s/MEM/$mem/g ; s/TIME/$time/g ; s/EMAILADDRESS/$email/g" $dir/DESTimate.templ > ./DEST-$n.sh
  sbatch DEST-$n.sh
  cd .. 
done
  
squeue -u $user