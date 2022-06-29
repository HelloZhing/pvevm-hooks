#!/bin/bash

VMID="$1"

echo "waitting" >> $(dirname $0)/$VMID-hooks.log

sleep 10

TimeSec=0

until ! test -e "/var/run/qemu-server/$VMID.pid"
do
    if [ $[$TimeSec%3600] -eq 0 ]; then
        echo "VM $VMID is running "$(date "+%Y-%m-%d %H:%M:%S") >> $(dirname $0)/$VMID-hooks.log
    fi
    sleep 3
    let TimeSec+=3
done

echo 0000:00:02.0 > /sys/bus/pci/devices/0000\:00\:02.0/driver/unbind
echo 0000:00:1f.3 > /sys/bus/pci/devices/0000\:00\:1f.3/driver/unbind
echo 0000:00:14.0 > /sys/bus/pci/devices/0000\:00\:14.0/driver/unbind
echo 0000:00:02.0 > /sys/bus/pci/drivers/i915/bind
echo 0000:00:1f.3 > /sys/bus/pci/drivers/snd_hda_intel/bind
echo 0000:00:14.0 > /sys/bus/pci/drivers/xhci_hcd/bind

sleep 1

#$(dirname $0)/vfio-teardown.sh

echo "VM $VMID stopped "$(date "+%Y-%m-%d %H:%M:%S") >> $(dirname $0)/$VMID-hooks.log
