#!/usr/bin/env bash

# deallocate (stop) virtual machine from incurring charges

rg=$1
vmname=$2

az vm deallocate --name $vmname \
	--resource-group $rg
