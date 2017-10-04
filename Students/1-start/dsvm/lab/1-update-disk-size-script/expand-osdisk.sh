#!/usr/bin/env bash
#title           :deploydsvm.sh
#description     :This script creates updates disk size on a Linux DSVM in Azure.
#author	         :Ali Zaidi (github: akzaidi; contact alizaidi at microsoft dot com)
#date            :2017-08-04
#version         :0.1    
#usage           :bash expand-osdisk.sh "os-size-in-GB" "resource-group" "vmname"
#notes           :Requires azure-CLI, and you must login prior to usage, az login.
#====================================================================================

OSSIZE=${1:-200}
RG=$2
VMNAME=$3

# Get Disk Name
read OSDISK disksize <<< $(./get-osdisk-name.sh $RG | grep "Os")

# Deallocate so resizing can be done

az vm deallocate \
    --resource-group "$RG" \
    --name "$VMNAME"

# Update OS Disk

az disk update \
    --resource-group "$RG" \
    --name "$OSDISK" \
    --size-gb "$OSSIZE"

# Restart VM

az vm start \
    --resource-group "$RG" \
    --name "$VMNAME"
