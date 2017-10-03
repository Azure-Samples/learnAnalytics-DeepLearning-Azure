#!/usr/bin/env bash

rgname=$1

printf "Deleting resource group %s\n $rgname
az group delete --name $rgname --yes
