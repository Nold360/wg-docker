#!/bin/bash
set -x
PATH=$PATH:/usr/local/bin

l3roamdif=""
for i in $MESHIFS
do
  l3roamdif="$l3roamdif -m $i"
done

l3roamd -d -s /var/run/l3roamd.sock -p $NODEPREFIX -p $CLIENTPREFIX $l3roamdif -t 11 -a $OWNIP -4 0:0:0:0:0:ffff::/96
