#!/usr/bin/env bash
#title           :deploydsvm.sh
#description     :This script creates updates disk size on a Linux DSVM in Azure.
#author		 	 :Ali Zaidi (github: akzaidi; contact alizaidi at microsoft dot com)
#date            :2017-08-04
#version         :0.1    
#usage		 	 :bash expand-osdisk.sh 
#notes           :Requires azure-CLI, and you must login prior to usage, az login.
#====================================================================================

yourname=$(whoami)
class="dlclass"
vmname="dsvm"

RG=$yourname$class

VMNAME=$yourname$vmname

OSDISK=$1
OSSIZE=${2:-200}


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