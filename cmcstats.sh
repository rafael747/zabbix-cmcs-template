#!/bin/bash

#
# CMCS Wrapper to parse DVB stats for zabbix
#

# DVB Config
IP=192.168.0.10
PW="Novra-S2"

# Checking cmcs executable
if which cmcs > /dev/null && test -x `which cmcs`
then
	true
	# echo "cmcs ok!"
else
	echo "[ERROR] cmcs client not found in PATH!"
	exit 1
fi

# Get output from DVB
output=$(cmcs -ip $IP -pw $PW -shsat /dev/stdout|head -n1)

# Verify the command output
if echo "$output"|grep "Unable to communicate with receiver"
then
	exit 1
fi

# Parsing output
MAC=$(echo $output|cut -d',' -f 3)
FREQ=$(echo $output|cut -d',' -f 7|awk '{print $1}')
SYMR=$(echo $output|cut -d',' -f 9|awk '{print $1}')
VITR=$(echo $output|cut -d',' -f 11)
SIGL=$(echo $output|cut -d',' -f 13|sed 's/On/1/g'|sed 's/Off/0/g')
DATL=$(echo $output|cut -d',' -f 15|sed 's/On/1/g'|sed 's/Off/0/g')
UNCR=$(echo $output|cut -d',' -f 17|cut -d'/' -f1)
VBER=$(echo $output|cut -d',' -f 19|sed 's/0.0000e+00/0/')
CTN=$(echo $output|cut -d',' -f 21|tr -d 'dB')
SIGS=$(echo $output|cut -d',' -f 23|awk '{print $1}')


# which info should we print?
case $1 in
"MAC")
    echo $MAC
    ;;
"FREQ")
    echo $FREQ
    ;;
"SYMR")
    echo $SYMR
    ;;
"VITR")
    echo $VITR
    ;;
"SIGL")
    echo $SIGL
    ;;
"DATL")
    echo $DATL
    ;;
"UNCR")
    echo $UNCR
    ;;
"VBER")
    echo $VBER
    ;;
"CTN")
    echo $CTN
    ;;
"SIGS")
    echo $SIGS
    ;;
*)
    # Print all info
    echo "MAC: $MAC"
    echo "FREQ: $FREQ"
    echo "SYMR: $SYMR"
    echo "VITR: $VITR"
    echo "SIGL: $SIGL"
    echo "DATL: $DATL"
    echo "UNCR: $UNCR"
    echo "VBER: $VBER"
    echo "CTN: $CTN"
    echo "SIGS: $SIGS"
    ;;
esac

exit 0

