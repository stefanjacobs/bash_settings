#!/bin/bash

RESOLV=/etc/resolv.conf

if grep -q "bku.db.de" "$RESOLV"; then
        # echo "I am in VPN"
	RESULT=0;
else
        # echo "I am not in VPN";
	RESULT=1;
fi

exit $RESULT;
