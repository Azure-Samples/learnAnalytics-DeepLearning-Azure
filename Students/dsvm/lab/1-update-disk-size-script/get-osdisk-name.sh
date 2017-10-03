#!/usr/bin/env bash

yourname=$(whoami)
class="dlclass"
vmname="dsvm"

ARG1=${1:-$yourname$class}
RG=$ARG1

VMNAME=${2:-$yourname$vmname}

# List managed disks on VM

az disk list \
	--resource-group "$RG" \
	--query '[*].{Name:name,Gb:diskSizeGb,Tier:accountType}' \
	--output table
