#!/bin/bash

VMID="$1"
igd_id="8086 $(lspci -n|grep '0:02.0'|cut -d ':' -f4|cut -c 1-4)"

echo "VM $VMID is starting" > $(dirname $0)/$VMID-hooks.log

#$(dirname $0)/vfio-startup.sh

sleep 1

echo 0000:00:02.0 > /sys/bus/pci/drivers/i915/unbind
if ! lsmod | grep "vfio_pci" &> /dev/null ; then
    modprobe vfio-pci
fi
echo $igd_id > /sys/bus/pci/drivers/vfio-pci/new_id
