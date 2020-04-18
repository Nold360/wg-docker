#!/bin/bash
set -x

if [[ -z $NEXTNODE ]] || [[ -z $CLIENTPREFIX ]] || [[ -z $NODEPREFIX ]] || [[ -z $WHOLENET ]]
then
  echo NEXTNODE, CLIENTPREFIX, NODEPREFIX, WHOLENET must be defined. Check your env-file.
  exit
fi

#setup ip rules
/scripts/iprules $NODEPREFIX $CLIENTPREFIX

babelifs=""
if [[ -z $MESHIFS ]]
then
  babelifs=babeldummydne
else
  babelifs=$MESHIFS
fi

babeld -I "" -C "ipv6-subtrees true" \
  -C "reflect-kernel-metric true" \
  -C "export-table 10" \
  -C "import-table 11" \
  -C "import-table 12" \
  -C "local-port-readwrite 33123" \
  -C "default enable-timestamps true" \
  -C "default max-rtt-penalty 96" \
  -C "default rtt-min 25" \
  -C "out ip $NEXTNODE/128 deny" \
  -C "redistribute ip $NEXTNODE/128 deny" \
  -C "redistribute ip $CLIENTPREFIX eq 128 allow" \
  -C "redistribute ip $CLATPREFIX eq 96 allow" \
  -C "redistribute ip $PLATPREFIX eq 96 allow" \
  -C "redistribute ip $NODEPREFIX eq 128 allow" \
  -C "redistribute src-ip $WHOLENET ip 2000::/3 allow" \
  -C "redistribute ip ::/0 allow" \
  -C "redistribute ip 2000::/3 allow" \
  -C "redistribute local deny" \
  -C "install pref-src $OWNIP" \
"$(for i in $babelifs
do
  echo -n " -C \"interface $i type wired rxcost 10 update-interval 60\""
done)"

