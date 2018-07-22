#!/bin/bash
[ ! -v LOG_LEVEL ]  && LOG_LEVEL=6

function log ( ) {
        level=$1
        message=$2
	if [ "${level}" -gt "${LOG_LEVEL}" ]
	then
		return
	fi
        case $level in
                1)
                        header='[FATAL]';;
                2)
                        header='[ERROR]';;
                3)
                        header='[WARN]';;
                4)
                        header='[INFO]';;
                5)
                        header='[DEBUG]';;
                6)
                        header='[TRACE]';;
        esac
        header="[$(date +'%Y-%m-%d %H:%M:%S')]    ${header}"
        echo $header $message >&2
}


log 4 "start of the script"
log 6 "loglevel test"
#logger -p local0.notice starting generating data

echo "line_number:data"
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | \
awk 'BEGIN { line = 1 }
        $0 { print line ":" $0 ; line = line + 1 }
        line == 11 { exit }
'

log 4 "end of the script"
#logger -p local0.notice end of data generation

