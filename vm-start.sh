#!/bin/bash

VMID="$1"

echo "VM $VMID is starting" > $(dirname $0)/$VMID-hooks.log

#$(dirname $0)/vfio-startup.sh

sleep 1

#echo 0000:00:02.0 > /sys/bus/pci/devices/0000\:00\:02.0/driver/unbind
#echo 0000:00:1f.3 > /sys/bus/pci/devices/0000\:00\:1f.3/driver/unbind
#echo 0000:00:02.0 > /sys/bus/pci/drivers/vfio-pci/bind
#echo 0000:00:1f.3 > /sys/bus/pci/drivers/vfio-pci/bind