for i in *.sdf.fps

do

echo "############################"
echo "Doing simsearch for batch $i"
simsearch --threshold 0.65 -q Quinabactin.fps $i >> QuinabactinResults.txt

sed '/^#/d' QuinabactinResults.txt | cut -c 6-20 | sed '/^$/d' | sed 's/^[ \t]*//' > OurList.txt


echo "############################"
echo "Done with simearch for batch $i"
echo "############################"

done
