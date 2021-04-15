#!/bin/ash

    #create users
        for i in $USERS ; do
            NAME=$(echo $i | cut -d'|' -f1)
            PASS=$(echo $i | cut -d'|' -f2)
            UID=$(echo $i | cut -d'|' -f3)
            FOLDER="/ftp/${NAME}"

            if [ ! -z "$UID" ]; then
                UID_OPT="-u $UID"
            fi

            echo -e "$PASS\n$PASS" | adduser -h $FOLDER -s /sbin/nologin $UID_OPT $NAME > /dev/null 2>&1
            mkdir -p $FOLDER
            chown $NAME:$NAME $FOLDER
            unset NAME PASS FOLDER UID > /dev/null 2>&1
        done

    #fix pesky vsftpd white-space check
        sed -i 's,\r,,;s, *$,,' /etc/vsftpd/vsftpd.conf

    #start
        exec "$@"