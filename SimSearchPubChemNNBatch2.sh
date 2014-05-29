rm  *.fps
########

gsutil ls gs://pubchem_fps/Compound*.sdf.fps | sed -n '1,705p' > WorkList_FPS0
gsutil ls gs://pubchem_fps/Compound*.sdf.fps | sed -n '706,1410p' > WorkList_FPS1
gsutil ls gs://pubchem_fps/Compound*.sdf.fps | sed -n '1411,2115p' > WorkList_FPS2
gsutil ls gs://pubchem_fps/Compound*.sdf.fps | sed -n '2116,2816p' > WorkList_FPS3

########
filecontent=(`cat "WorkList_FPS1"`)
########
for f in "${filecontent[@]}"
##
do
##
echo "Copying $f to search"

gsutil -m cp $f .

echo "############################"
echo "Starting simsearch for batch $f"


##
#Target=(`echo $f | sed 's/gs:\/\/pubchem\///g'`)
Target=(`ls *.fps`)
Name=(`ls *.fps | sed 's/\.sdf.fps/_nnm.txt/g'`)
##

simsearch -k 88 --NxN "$Target" > "$Name"


gsutil -m cp -R "$Name" gs://swapmeet/
rm "$Name"
rm "$Target"

##
echo "############################"
echo "Done with simsearch for batch $f"
echo "############################"


rm *.fps
####
done
