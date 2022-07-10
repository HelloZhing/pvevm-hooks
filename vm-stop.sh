#!/bin/bash

VMID="$1"
ia_addr="0000:$(lspci|grep 'Audio'|grep 'Intel'|cut -c 1-7)"
usb_addr="0000:$(lspci|grep 'USB'|grep 'Intel'|cut -c 1-7)"
igd_id="8086 $(lspci -n|grep '0:02.0'|cut -d ':' -f4|cut -c 1-4)"

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

echo 0000:00:02.0 > /sys/bus/pci/drivers/vfio-pci/unbind
echo $ia_addr > /sys/bus/pci/drivers/vfio-pci/unbind
#echo $usb_addr > /sys/bus/pci/drivers/vfio-pci/unbind
echo $igd_id > /sys/bus/pci/drivers/vfio-pci/remove_id
echo 0000:00:02.0 > /sys/bus/pci/drivers/i915/bind
echo $ia_addr > /sys/bus/pci/drivers/snd_hda_intel/bind
#echo $usb_addr >/sys/bus/pci/drivers/xhci_hcd/bind

sleep 1

#$(dirname $0)/vfio-teardown.sh

echo "VM $VMID stopped "$(date "+%Y-%m-%d %H:%M:%S") >> $(dirname $0)/$VMID-hooks.log
