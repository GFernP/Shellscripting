#!/bin/bash

#set -x
 
function validar_ip()
 {
   local  ip=$ipd
   local  stat=1
   if [ $ip =~ '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$' ]
    then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
 	&& ${ip[2]} -le 255 &&  ${ip[3]} -le 255 ]]
        stat=$?
   fi
return $stat
 }
b=1
while [ $b -eq 1 ]
do
	echo "Ingrese IP del servidor Jboss: "
		read ipd
		clear
		if validar_ip ipd
		then
			a=1
			while [ $a -eq 1 ]
			do
			echo "Elija nodo a detener 1)nodo1, 2)nodo2, 3)todos 4)elegir nuevo servidor 5)Salir\n"
			read opnod
			clear
				if test $opnod == "1"
				then
					ssh sisve@$ipd "export TERM=xterm; ls -ld /html1"
					rc=$?
					if test $rc == "0"
					then
						echo "OK"
						sleep 3
						clear
						exit
					else
						echo "Hubo un error"
						sleep 3
						clear
						exit
					fi
				elif test $opnod == "2"
				then
					ssh sisve@$ipd "export TERM=xterm; ls -ld /html2"
					rc=$?
					if test $rc == "0"
					then
						echo "OK"
						sleep 3
						clear
						exit
					else
						echo "Hubo un error"
						sleep 3
						clear
						exit
					fi
				elif test $opnod == "3"
				then
					ssh sisve@$ipd "export TERM=xterm; ls -ld /html1"
					ssh sisve@$ipd "export TERM=xterm; ls -ld /html2"
					rc=$?
					if test $rc == "0"
					then
						echo "OK"
						sleep 3
						clear
						exit
					else
						echo "Hubo un error"
						sleep 3
						clear
						exit
					fi
				elif test $opnod == "4"
				then
					a=0
					b=1
				elif test $opnod == "5"
				then
				echo "Saliendo"
				exit
				else
					echo "Opcion equivocada favor indicar opcion (1,2,3,4 o 5)"
					a=1
					sleep 3
					clear
				fi
			done
		else
			echo "ip no valida"
			b=1
		fi
	
done
