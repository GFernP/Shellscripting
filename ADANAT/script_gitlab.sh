Fecha=`date  '+%d.%m.%Y %H:%M:%S'`
file=/opt/sag/Shell/GITrack.log
ver=`date +%s`

cd /opt/softwareag/Natural/fuser
git add .
git commit -m "$ver commit"
git push -u origin master  &> test.la

if cat test.la |grep -q "Everything up-to-date"
then 
    rm -f test.la
else
    echo "=======================================================" >> $file
    echo "$Fecha : Se detectan nuevos archivos en $PWD" >> $file
fi


cd /opt/softwareag/Natural/TST/fuser
git add .
git commit -m "$ver commit"
git push -u origin master  &> test.la

if cat test.la |grep -q "Everything up-to-date"
then 
    rm -f test.la
else
    echo "=======================================================" >> $file
    echo "$Fecha : Se detectan nuevos archivos en $PWD" >> $file
fi