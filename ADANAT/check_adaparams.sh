#!/bin/bash
export ADAPROGDIR=/opt/sag/Adabas 
cd /home/adamon/
. .profile 2 >/dev/null
case "$1" in
 Command)
	arch=datos1
	;;
 ASSO_IO)
	arch=datos1
	;;
 DATA_IO)
	arch=datos1
	;;
 WORK_IO)
	arch=datos1
	;;
 TEMP_IO)
	arch=datos1
	;;
 PLOG_IO)
	arch=datos1
	;;
 Throwbacks)
	arch=datos1
	;;  
 Users)
	arch=datos2
	;;
 Threads)
	arch=datos2
	;;
 WP1_Limit)
	arch=datos2
	;;
 Work_pool)
	arch=datos2
	;;
 ASSO)
	arch=datos2
	;;
 DATA)
	arch=datos2
	;;
 PLOG)
	arch=datos2
	;;
 *) echo "ERROR en ParAmetro - ADAbas"
    exit 1
esac

cd /home/adamon/nagios
/opt/sag/Adabas/adamon dbid=4 loops=2 disp=hi inter=2 > adamonresp1.tmp
tail -20 adamonresp1.tmp |head -9 >adamon1.dat
tail -8 adamonresp1.tmp |head -7|sed 's/ KB/K/g' >adamon2.dat
#Primer grupo de datos
cut -d':' -f1 adamon1.dat |sed 's/ *$//'|sed 's/ /_/g' >columna0.tmp
cut -d':' -f2 adamon1.dat |sed 's/^ *//'|cut -d' ' -f1 >columna1.tmp
cut -d':' -f2 adamon1.dat |sed 's/^ *//'|cut -d' ' -s -f2- |sed 's/^ *//' >columna2.tmp
paste -d, columna0.tmp columna1.tmp columna2.tmp >datos1.tmp
#Segundo grupo de datos
cut -d':' -f1 adamon2.dat |sed 's/^ //'|sed 's/ *$//'|sed 's/ /_/g' >columna0.tmp
cut -d':' -f2 adamon2.dat |sed 's/^ *//'|cut -d' ' -f1 >columna1.tmp
cut -d':' -f2 adamon2.dat |sed 's/^ *//'|cut -d' ' -f2- |sed 's/^ *//'|cut -d' ' -f1 >columna2.tmp
cut -d':' -f2 adamon2.dat |sed 's/^ *//'|cut -d' ' -f2- |sed 's/^ *//'|cut -d' ' -f2- |sed 's/^ *//' >columna3.tmp
paste -d, columna0.tmp columna1.tmp columna2.tmp columna3.tmp >datos2.tmp

case "$arch" in
	datos1)
		totals=`cat ./$arch.tmp |grep $1|cut -d',' -f2`
		ratio_s=`cat ./$arch.tmp |grep $1|cut -d',' -f3`
		echo "OK - $1: $ratio_s Ratio/Seg.(Total=$totals) | ratio_[s]=$ratio_s"
		exit 0
		;;
	datos2)
		size=`cat ./$arch.tmp |grep $1|cut -d',' -f2`
		highwater=`cat ./$arch.tmp |grep $1|cut -d',' -f3`
		ratio=`cat ./$arch.tmp |grep $1|cut -d',' -f4`
		echo "OK - $1: $highwater (Size=$size,Ratio=$ratio) | HighWater=$highwater"
		exit 0
		;;
esac
