#!/bin/bash
# servidor de salida

fecha=`date +%y%m%d_%H%M%S`
flog=`date +%d%m%y`
LOG=/tmp/log/tmp_debugmail_$flog.log
UTIME=`date +%s`
OUTL=/tmp/out_$UTIME_$$.mail
FROM_EMAIL_ADDRESS="casillas.correos@correos.cl"
FRIENDLY_NAME="CorreosChile"

# destinatario del mensaje
TO_EMAIL_ADDRESS=$1      #
CC_EMAIL_ADDRESS=$2
EMAIL_SUBJECT=$3           #"prueba para envio de correo con mailx desde consola"
EMAIL_BODY=$4     #  "Aqui va el contenido del correo."
EMAIL_ATTACHMENT=$5      #/home/sag/install.log
#HTML="Content-Type: text/html; charset=ISO-8859-1; format=flowed"
nombre="${EMAIL_ATTACHMENT##*/}"

if echo "$CC_EMAIL_ADDRESS" |grep -q "@"
then
    if echo "$EMAIL_SUBJECT" | grep -q "Estadistica Generacion Historiales"
    then
        HLOG=/tmp/log/notifistathisto_$flog.log
        echo $fecha >> $HLOG   
        echo $TO_EMAIL_ADDRESS >> $HLOG
        echo $CC_EMAIL_ADDRESS >> $HLOG
        echo $EMAIL_SUBJECT >> $HLOG
        echo $EMAIL_BODY >> $HLOG
        echo $EMAIL_ATTACHMENT >> $HLOG
        echo "$0|$$|$#|$?|$!" >> $HLOG
        echo "*************************************" >> $HLOG
        cp $EMAIL_ATTACHMENT /respaldo/bck_attach_histo/
    elif echo "$EMAIL_ATTACHMENT" |grep -q "@"
    then
        echo $fecha >> $LOG
        echo $TO_EMAIL_ADDRESS >> $LOG
        echo $CC_EMAIL_ADDRESS >> $LOG
        echo $EMAIL_SUBJECT >> $LOG
        echo $EMAIL_BODY >> $LOG
        echo $EMAIL_ATTACHMENT >> $LOG   #/tmp/debugmail.log
        echo "$0|$$|$*|$#|$?|$!" >> $LOG
        echo "*************************************" >> $LOG
        echo "$EMAIL_BODY" > $OUTL
        mailx -s "$EMAIL_SUBJECT" -r "$FROM_EMAIL_ADDRESS($FRIENDLY_NAME)" -c $CC_EMAIL_ADDRESS $TO_EMAIL_ADDRESS <$OUTL
        rm -f $OUTL
    else
        echo $fecha >> $LOG   #/tmp/debugmail.log
        echo $TO_EMAIL_ADDRESS >> $LOG   #/tmp/debugmail.log
        echo $CC_EMAIL_ADDRESS >> $LOG   #/tmp/debugmail.log
        echo $EMAIL_SUBJECT >> $LOG   #/tmp/debugmail.log
        echo $EMAIL_BODY >> $LOG   #/tmp/debugmail.log
        echo $EMAIL_ATTACHMENT >> $LOG   #/tmp/debugmail.log
        echo "$0|$$|$*|$#|$?|$!" >> $LOG   #/tmp/debugmail.log
        echo "*************************************" >> $LOG   #/tmp/debugmail.log
        echo "$EMAIL_BODY" > $OUTL
        if echo "$EMAIL_ATTACHMENT" |grep -q "/"
        then
            cp $EMAIL_ATTACHMENT /tmp
            cd /tmp
            for i in $EMAIL_ATTACHMENT
            do
                fixATTACH=`echo $i |awk -F "/" '{print $NF}'`
                uuencode $fixATTACH $fixATTACH >> $OUTL
                rm -f $fixATTACH
            done
        fi
        mailx -s "$EMAIL_SUBJECT" -r "$FROM_EMAIL_ADDRESS($FRIENDLY_NAME)" -c $CC_EMAIL_ADDRESS $TO_EMAIL_ADDRESS <$OUTL
        rm -f $OUTL
    fi
else
    TO_EMAIL_ADDRESS4=$1
    EMAIL_SUBJECT4=$2
    EMAIL_BODY4=$3
    EMAIL_ATTACHMENT4=$4
    if echo "$EMAIL_ATTACHMENT" |grep -q "@"
    then
        echo $fecha >> $LOG
        echo $TO_EMAIL_ADDRESS4 >> $LOG
        echo $EMAIL_SUBJECT4 >> $LOG
        echo $EMAIL_BODY4 >> $LOG
        echo $EMAIL_ATTACHMENT4 >> $LOG   #/tmp/debugmail.log
        echo "$0|$$|$*|$#|$?|$!" >> $LOG
        echo "*************************************" >> $LOG
        echo "$EMAIL_BODY4" > $OUTL
        mailx -s "$EMAIL_SUBJECT4" -r "$FROM_EMAIL_ADDRESS($FRIENDLY_NAME)" $TO_EMAIL_ADDRESS4 <$OUTL
        rm -f $OUTL
    else
        echo $fecha >> $LOG
        echo $TO_EMAIL_ADDRESS4 >> $LOG
        echo $EMAIL_SUBJECT4 >> $LOG
        echo $EMAIL_BODY4 >> $LOG
        echo $EMAIL_ATTACHMENT4 >> $LOG
        echo "$0|$$|$*|$#|$?|$!" >> $LOG
        echo "*************************************" >> $LOG
        echo "$EMAIL_BODY4" > $OUTL
        if echo "$EMAIL_ATTACHMENT4" |grep -q "/"
        then
            cp $EMAIL_ATTACHMENT4 /tmp
            cd /tmp
            for i in $EMAIL_ATTACHMENT4
            do
                fixATTACH=`echo $i |awk -F "/" '{print $NF}'`
                uuencode $fixATTACH $fixATTACH >> $OUTL
                rm -f $fixATTACH
            done
        fi
        mailx -s "$EMAIL_SUBJECT4" -r "$FROM_EMAIL_ADDRESS($FRIENDLY_NAME)" $TO_EMAIL_ADDRESS4 <$OUTL
        rm -f $OUTL
    fi
fi

## todo lo que pongamos en el echo, sera el contenido del correo
##(uuencode $EMAIL_ATTACHMENT $nombre;echo "$EMAIL_BODY" )| mailx -s "$EMAIL_SUBJECT" -r "$FROM_EMAIL_ADDRESS($FRIENDLY_NAME)" -c $CC_EMAIL_ADDRESS $TO_EMAIL_ADDRESS
#