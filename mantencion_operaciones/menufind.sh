#!/usr/bin/bash
###Menu Busqueda

BCKDIR=/respaldo/tmpfiles
Fecha=`date +%Y%m%d_%H%M%S`

opfind()
	{
	case $opcion in
	1)	clear
		echo "Ingrese mes, año y directorio a buscar ej: Apr 2017 /fstemp2/DatosSeg02/backupEP/ "
		read mes year dir
		ls -ltr $dir | awk ' $8=="'$year'" {print $0} ' |awk ' $6=="'$mes'" {print $9} ' > $HOME/logs/filezip_$Fecha.log
		#cd $dir
		caso=1
		;;
	2) clear
		echo "Ingrese dia, año y directorio a buscar ej: 05 2016 /tmp/log"
		read dia year dir
		ls -ltr $dir |awk ' $6=="'$dia'" {print $9} ' > $HOME/logs/filezip_$Fecha.log
		#cd $dir
		caso=2
		;;
	3) clear
		echo "Ingrese dia, mes, año y directorio a buscar ej: 01 Jun 2016 /tmp/log"
		read dia mes year dir
		ls -ltr $dir | awk ' $8=="'$year'" {print $0} ' |awk ' $6=="'$mes'" {print $0} ' | awk ' $7=="'$dia'" {print $9} ' > $HOME/logs/filezip_$Fecha.log
		#cd $dir
		caso=3
		;;
	4) clear
		echo "Ingrese año y directorio a buscar ej: 2015 /tmp/log"
		read year dir
		ls -ltr $dir | awk ' $8=="'$year'" {print $9} ' > $HOME/logs/filezip_$Fecha.log
		#cd $dir
		caso=4
		;;
	5) clear
		echo "Ingrese mes, año y directorio a buscar ej: Apr 2017 /fstemp2/DatosSeg02/backupEP/ "
		read mes year dir
		ls -ltr $dir |awk ' $6=="'$mes'" {print $9} ' > $HOME/logs/filezip_$Fecha.log
		#cd $dir
		caso=5
		;;
	*) echo "Opcion erronea"
		exit
	;;
	esac
	}
	

menu()
{
	echo " ----------------------------------------------------------------------------- "
    	echo " "
	echo "        Menu de borrado de archivos "        
	echo "                          1 )  Busqueda por mes y año"
    	echo "                          2 )  Busqueda por dia"
    	echo "                          3 )  Busqueda por dia, mes y año"
    	echo "                          4 )  Busqueda por año"
    	echo "                          5 )  Busqueda por mes"
    	echo " ----------------------------------------------------------------------------- "
	echo " Ingrese opcion:"
	read op
	return $op
	}

caso=0
menu
opcion=$op
opfind
cd $dir
name=`echo $dir| sed 's:[^a-zA-Z]::g'`
if [ $caso -eq 1 ]
then
	echo "################# COMPRIMIENDO #################"
	tar -cf $BCKDIR/Backupfiles_$mes$year.tar -L $HOME/logs/filezip_$Fecha.log
	#countf=`wc -l $HOME/logs/filezip_$Fecha.log`
        #countta=`tar -tvf $BCKDIR/Backupfiles_$mes$year.tar`
        #echo "Numero de archivos en empaquetado es $countta y cantidad de lineas en archivo $countf"
	gzip $BCKDIR/Backupfiles_$mes$year.tar
#	nnom=`echo $dir | sed s:[^a-zA-Z]::g`
	mv $BCKDIR/Backupfiles_$mes$year.tar.gz $BCKDIR/Backupfiles_$name$mes$year.tar.gz
elif [ $caso -eq 2 ]
then
	echo "################# COMPRIMIENDO #################"
        tar -cf $BCKDIR/Backupfiles_$dia$year.tar -L $HOME/logs/filezip_$Fecha.log
        #countf=`wc -l $HOME/logs/filezip_$Fecha.log`
        #countta=`tar -tvf $BCKDIR/Backupfiles_$dia$year.tar`
        #echo "Numero de archivos en empaquetado es $countta y cantidad de lineas en archivo $countf"
        gzip $BCKDIR/Backupfiles_$dia$year.tar
        mv $BCKDIR/Backupfiles_$dia$year.tar.gz $BCKDIR/Backupfiles_$name$dia$year.tar.gz

elif [ $caso -eq 3 ]
then
	echo "################# COMPRIMIENDO #################"
        tar -cf $BCKDIR/Backupfiles_$mes$year.tar -L $HOME/logs/filezip_$Fecha.log
        #countf=`wc -l $HOME/logs/filezip_$Fecha.log`
        #countta=`tar -tvf $BCKDIR/Backupfiles_$mes$year.tar`
        #echo "Numero de archivos en empaquetado es $countta y cantidad de lineas en archivo $countf"
        gzip $BCKDIR/Backupfiles_$mes$year.tar
        mv $BCKDIR/Backupfiles_$mes$year.tar.gz $BCKDIR/Backupfiles_$name$mes$year.tar.gz

elif [ $caso -eq 4 ]
then
	echo "################# COMPRIMIENDO #################"
	tar -cf $BCKDIR/Backupfiles_$year.tar -L $HOME/logs/filezip_$Fecha.log
        #countf=`wc -l $HOME/logs/filezip_$Fecha.log`
        #countta=`tar -tvf $BCKDIR/Backupfiles_$year.tar`
        #echo "Numero de archivos en empaquetado es $countta y cantidad de lineas en archivo $countf"
        gzip $BCKDIR/Backupfiles_$year.tar
        mv $BCKDIR/Backupfiles_$year.tar.gz $BCKDIR/Backupfiles_$name$year.tar.gz

elif [ $caso -eq 5 ]
then
	echo "################# COMPRIMIENDO #################"
#	name=`echo $dir| sed 's:[^a-zA-Z]::g'`
	tar -cf $BCKDIR/Backupfiles_$mes$year.tar -L $HOME/logs/filezip_$Fecha.log
	#countf=`wc -l $HOME/logs/filezip_$Fecha.log`
	#countta=`tar -tvf $BCKDIR/Backupfiles_$mes$year.tar`
	#echo "Numero de archivos en empaquetado es $countta y cantidad de lineas en archivo $countf" 	
	gzip $BCKDIR/Backupfiles_$mes$year.tar
	mv $BCKDIR/Backupfiles_$mes$year.tar.gz $BCKDIR/Backupfiles_$name$mes$year.tar.gz
fi

y=1
while [ $y -eq 1 ]

do
    echo "Desea eliminar los archivos listados que ya fueron respaldados? [s/n]"
    read q
    clear
    if [ $q == s ]
    then
        #sh $HOME/myscripts/borrfiles.sh $MES $YEAR $DIR
		sed "s/^/rm -f /g" $HOME/logs/filezip_$Fecha.log > $HOME/logs/fileborr.sh
		cat $HOME/logs/fileborr.sh > $HOME/logs/fileborr._$Fecha.log
		chmod +x $HOME/logs/fileborr.sh
		sh $HOME/logs/fileborr.sh
		echo "Archivos Eliminados"
		rm -f $HOME/logs/fileborr.sh
        exit
    elif [ $q == n ]
    then
                echo "exit"
        exit
    else
                echo "Verifique las opciones de repuesta \n"
                echo " s = si, n = no"
                y=1
    fi
done
