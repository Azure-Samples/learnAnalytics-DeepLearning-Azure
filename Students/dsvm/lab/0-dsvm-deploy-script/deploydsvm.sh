#!/usr/bin/env bash
#title           :deploydsvm.sh
#description     :This script creates a Linux DSVM in Azure.
#author          :Ali Zaidi (github: akzaidi; contact alizaidi at microsoft dot com)
#date            :2017-08-04
#version         :0.2    
#usage           :bash deployDSVM.sh "username" "password" "resource-group" "location" "vmname" "sshadmin" "dns"
#notes           :Requires azure-CLI, and you must login prior to usage, az login.
#====================================================================================

# defining parameters to use in deployment
# uses username on bash profile and concatenates with resources

yourname=$(whoami)
username=${1:-$yourname}
class="dlclass"
vmsuffix="dsvm"

ARG2=${2:-"Password123!"}
PASSWORD=$ARG2

ARG3=${3:-$username$class}
RG=$ARG3

# available regions:
# https://azure.microsoft.com/en-us/regions/services/
ARG4=${4:-eastus}
LOC=$ARG4

ARG5=${5:-$username$vmsuffix}
VMNAME=$ARG5

ARG6=${6:-$username}
SSHADMIN=$ARG6

ARG7=${7:-$VMNAME}
DNS=$ARG7

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
    --image microsoft-ads:linux-data-science-vm-ubuntu:linuxdsvmubuntu:latest \
    --size Standard_NC6 \
    --admin-password "$PASSWORD"

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

# Open Port 6006 for TensorBoard

az network nsg rule create \
    --resource-group "$RG" \
    --nsg-name "$NSG" \
    --name rstudio-server \
    --protocol tcp \
    --priority 1003 \
    --destination-port-range 6006

# Open Port 8787 for RStudio-Server

az network nsg rule create \
    --resource-group "$RG" \
    --nsg-name "$NSG" \
    --name rstudio-server \
    --protocol tcp \
    --priority 1004 \
    --destination-port-range 8787

# save credentials to text file

printf "Saving credentials to creds.txt"

echo "VM Name = " $VMNAME >> creds.txt
echo "Username = " $SSHADMIN >> creds.txt
echo "Password = " $PASSWORD >> creds.txt
echo "DNS Name = " $DNS.$LOC.cloudapp.azure.com >> creds.txt
echo "Network Security Group = " $NSG >> creds.txt
echo "Resource Group = " $RG >> creds.txt
