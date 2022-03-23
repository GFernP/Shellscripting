#CambiosPRG.sh
#
#FIX 1 03/01/17, se elimina respaldo a SCB y se agregan los respaldos de BATCH, MCD y STDCST.
#set -x
Fecha=`date +%Y%m%d`
#Dir=Cambios-$Fecha


#find *.N* -mtime 1 -exec cp {} /home/tsisve/$Dir \;
DIRAPP=/opt/sisve/nat/fusernjx/
DIRBCKSISVE=/fstemp2/backupnatlibs/NJX/SISVE
DIRBCKBATCH=/fstemp2/backupnatlibs/NJX/BATCH
DIRBCKMCD=/fstemp2/backupnatlibs/NJX/MCD
DIRBCKSTDCST=/fstemp2/backupnatlibs/NJX/STDCST

findsisve(){
cd $DIRAPP
find SISVE/SRC/*.N* -mtime -35 -exec ls -l {} \; > $DIRBCKSISVE/natlibhisto-$Fecha.log
x=`cat $DIRBCKSISVE/natlibhisto-$Fecha.log |wc -l`
if [ $x -ge 1 ]
then
return 1
else
return 0
fi
}

findbatch(){
cd $DIRAPP
find BATCH/SRC/*.N* -mtime -35 -exec ls -l {} \; > $DIRBCKBATCH/natlibhisto-$Fecha.log
x=`cat $DIRBCKBATCH/natlibhisto-$Fecha.log |wc -l`
if [ $x -ge 1 ]
then
return 1
else
return 0
fi
}

findmcd(){
cd $DIRAPP
find MCD/SRC/*.N* -mtime -35 -exec ls -l {} \; > $DIRBCKMCD/natlibhisto-$Fecha.log
x=`cat $DIRBCKMCD/natlibhisto-$Fecha.log |wc -l`
if [ $x -ge 1 ]
then
return 1
else
return 0
fi
}

findstdcst(){
cd $DIRAPP
find STDCST/SRC/*.N* -mtime -35 -exec ls -l {} \; > $DIRBCKSTDCST/natlibhisto-$Fecha.log
x=`cat $DIRBCKSTDCST/natlibhisto-$Fecha.log |wc -l`
if [ $x -ge 1 ]
then
return 1
else
return 0
fi
}

logsisve(){
cat $DIRBCKSISVE/natlibhisto-$Fecha.log >> $DIRBCKSISVE/natlibhistosisve.log
cat $DIRBCKSISVE/natlibhisto-$Fecha.log| awk ' {print $9} ' > $DIRBCKSISVE/tmpnatlib.tmp
echo "\n" >> $DIRBCKSISVE/natlibhistosisve.log
echo "Las ultimas Librerias modificadas, fueron respaldadas el $Fecha" >> $DIRBCKSISVE/natlibhistosisve.log
echo "********************************************************************" >> $DIRBCKSISVE/natlibhistosisve.log
}

logbatch(){
cat $DIRBCKBATCH/natlibhisto-$Fecha.log >> $DIRBCKBATCH/natlibhistobatch.log
cat $DIRBCKBATCH/natlibhisto-$Fecha.log| awk ' {print $9} ' > $DIRBCKBATCH/tmpnatlib.tmp
echo "\n" >> $DIRBCKBATCH/natlibhistobatch.log
echo "Las ultimas Librerias modificadas, fueron respaldadas el $Fecha" >> $DIRBCKBATCH/natlibhistobatch.log
echo "********************************************************************" >> $DIRBCKBATCH/natlibhistobatch.log
}

logmcd(){
cat $DIRBCKMCD/natlibhisto-$Fecha.log >> $DIRBCKMCD/natlibhistomcd.log
cat $DIRBCKMCD/natlibhisto-$Fecha.log| awk ' {print $9} ' > $DIRBCKMCD/tmpnatlib.tmp
echo "\n" >> $DIRBCKMCD/natlibhistomcd.log
echo "Las ultimas Librerias modificadas, fueron respaldadas el $Fecha" >> $DIRBCKMCD/natlibhistomcd.log
echo "********************************************************************" >> $DIRBCKMCD/natlibhistomcd.log
}

logstdcst(){
cat $DIRBCKSTDCST/natlibhisto-$Fecha.log >> $DIRBCKSTDCST/natlibhistostdcst.log
cat $DIRBCKSTDCST/natlibhisto-$Fecha.log| awk ' {print $9} ' > $DIRBCKSTDCST/tmpnatlib.tmp
echo "\n" >> $DIRBCKSTDCST/natlibhistostdcst.log
echo "Las ultimas Librerias modificadas, fueron respaldadas el $Fecha" >> $DIRBCKSTDCST/natlibhistostdcst.log
echo "********************************************************************" >> $DIRBCKSTDCST/natlibhistostdcst.log
}

cpsisve(){
for i in `cat $DIRBCKSISVE/tmpnatlib.tmp`
do
cp $i $DIRBCKSISVE
done
}

cpmcd(){
for i in `cat $DIRBCKMCD/tmpnatlib.tmp`
do
cp $i $DIRBCKMCD
done
}

cpbatch(){
for i in `cat $DIRBCKBATCH/tmpnatlib.tmp`
do
cp $i $DIRBCKBATCH
done
}

cpstdcst(){
for i in `cat $DIRBCKSTDCST/tmpnatlib.tmp`
do
cp $i $DIRBCKSTDCST
done
}

compdelsisve(){
cd $DIRBCKSISVE
tar -cf bcknatlibsisve-$Fecha.tar *.N*
gzip bcknatlibsisve-$Fecha.tar
rm -f *.N*
rm -f tmpnatlib.tmp
rm -f natlibhisto-$Fecha.log
#sudo chown sag.sag bcknatlibsisve-$Fecha.tar.gz
#sudo chown sag.sag natlibhistosisve.log
}

compdelbatch(){
cd $DIRBCKBATCH
tar -cf bcknatlibbatch-$Fecha.tar *.N*
gzip bcknatlibbatch-$Fecha.tar
rm -f *.N*
rm -f tmpnatlib.tmp
rm -f natlibhisto-$Fecha.log
#sudo chown sag.sag bcknatlibbatch-$Fecha.tar.gz
#sudo chown sag.sag natlibhistobatch.log
}

compdelmcd(){
cd $DIRBCKMCD
tar -cf bcknatlibmcd-$Fecha.tar *.N*
gzip bcknatlibmcd-$Fecha.tar
rm -f *.N*
rm -f tmpnatlib.tmp
rm -f natlibhisto-$Fecha.log
#sudo chown sag.sag bcknatlibmcd-$Fecha.tar.gz
#sudo chown sag.sag natlibhistomcd.log
}

compdelstdcst(){
cd $DIRBCKSTDCST
tar -cf bcknatlibstdcst-$Fecha.tar *.N*
gzip bcknatlibstdcst-$Fecha.tar
rm -f *.N*
rm -f tmpnatlib.tmp
rm -f natlibhisto-$Fecha.log
#sudo chown sag.sag bcknatlibstdcst-$Fecha.tar.gz
#sudo chown sag.sag natlibhistostdcst.log
}

findsisve
if [ $? -eq 1 ]
then
        logsisve
        cpsisve
        compdelsisve
else
        rm -f $DIRBCKSISVE/natlibhisto-$Fecha.log
fi

findbatch
if [ $? -eq 1 ]
then
        logbatch
        cpbatch
        compdelbatch
else
        rm -f $DIRBCKBATCH/natlibhisto-$Fecha.log
fi

findmcd
if [ $? -eq 1 ]
then
        logmcd
        cpmcd
        compdelmcd
else
        rm -f $DIRBCKMCD/natlibhisto-$Fecha.log
fi

findstdcst
if [ $? -eq 1 ]
then
        logstdcst
        cpstdcst
        compdelstdcst
else
        rm -f $DIRBCKSTDCST/natlibhisto-$Fecha.log
fi

exit
