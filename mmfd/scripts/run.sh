#!/bin/bash
set -x

mmfdif=""
for i in $MESHIFS
do
  mmfdif="$mmfdif -i $i"
done

# FIXME: This seems to belong here...
ip -6 r add ff05::2:1001/128 dev mmfd0 table local

mmfd -d -s /var/run/mmfd.sock $mmfdif
