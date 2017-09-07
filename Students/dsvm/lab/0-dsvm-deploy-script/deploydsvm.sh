#!/usr/bin/env bash
#title           :deploydsvm.sh
#description     :This script creates a Linux DSVM in Azure.
#author		     :Ali Zaidi (github: akzaidi; contact alizaidi at microsoft dot com)
#date            :2017-08-04
#version         :0.1    
#usage		     :bash deployDSVM.sh
#notes           :Requires azure-CLI, and you must login prior to usage, az login.
#====================================================================================

# defining parameters to use in deployment
# uses username on bash profile and concatenates with resources

yourname=$(whoami)
class="dlclass"
vmname="dsvm"

ARG1=${1:-$yourname$class}
RG=$ARG1

ARG2=${2:-southcentralus}
LOC=$ARG2

ARG3=${3:-$yourname$vmname}
VMNAME=$ARG3

ARG4=${4:-$yourname}
SSHADMIN=$ARG4

ARG5=${5:-$yourname$vmname}
DNS=$ARG5

nsgp="NSG"
NSG=$VMNAME$nsgp

# Create Resource Group

az group create -n "$RG" -l "$LOC"

# Create DSVM

az vm create \
    --resource-group "$RG" \
    --name "$VMNAME" \
    --admin-username "$SSHADMIN" \
    --public-ip-address-dns-name "$DNS" \
    --image microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntu:1.1.1 \
    --size Standard_NC6 \
    --generate-ssh-keys

# verify image SKU by searching dsvm skus
# az vm image list --all --output table --location eastus --publisher microsoft-ads


# Open Port 8000 for JupyterHub

az network nsg rule create \
    --resource-group "$RG" \
    --nsg-name "$NSG" \
    --name JupyterHub \
    --protocol tcp \
    --priority 1001 \
    --destination-port-range 8000

# Open Port 8888 for JupyterLab

az network nsg rule create \
    --resource-group "$RG" \
    --nsg-name "$NSG" \
    --name JupyterLab \
    --protocol tcp \
    --priority 1002 \
    --destination-port-range 8888

# Open Port 8787 for RStudio-Server

az network nsg rule create \
    --resource-group "$RG" \
    --nsg-name "$NSG" \
    --name rstudio-server \
    --protocol tcp \
    --priority 1003 \
    --destination-port-range 8787
