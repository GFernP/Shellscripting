#
export fch=`date  '+%d/%m/%y'`
if [ $# -ne 2 ]
then
  echo "Usage : genfdt <dbid> <file> \n"
else


  VERS=`echo $ADAVERS | cut -c1-2`

  if [ $VERS = "v3" ]
  then
    genfdt3 $1 $2
  else
    adarep db=$1  file=$2 | awk '
    BEGIN { start="false" }
    /AIX/    { fch1 = $2 }
    /database/ { dbid = $3 }
    /Database/ { file =  $4
                 name = substr($5,2,16)
                  }
    /Records/  { registro =  $3 }

    { if ($1 == "Container")
      {
        start="true"
        print fch1  "|" file "|" name "|"  registro

      }
}
'
  fi
fi

