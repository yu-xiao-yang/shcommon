
codenames=('0111' '0112' '0113')
cityname=ShangHai


for  codename in ${codenames[*]}
do 
    sed -i "s/0111/${codename}/g"  replace.txt
    sed -i "s/JiangSu/${cityname}/g"  replace.txt

    echo "----------------"
done 