#!/bin/bash
set -x

if [[ -z $WGSECRET ]] || [[ -z $NEXTNODE ]] || [[ -z $CLIENTPREFIX ]] ||
  [[ -z $NODEPREFIX ]] || [[ -z $WHOLENET ]]
then
  echo WGSECRET, NEXTNODE, CLIENTPREFIX, NODEPREFIX, WHOLENET must be defined. Check your env-file.
  exit
fi

# Install Wireguard. This has to be done dynamically since the kernel
# module depends on the host kernel version.
apt update
apt install -y linux-headers-$(uname -r)
apt install -y wireguard

#setup ip rules
#FIXME: who needs this?
/scripts/iprules $NODEPREFIX $CLIENTPREFIX

# Shared Secret
echo ${WGSECRET} > ${PRIVATEKEY}

# start wireguard broker
wg-broker-server
