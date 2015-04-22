#!/bin/bash

while read p; do
	nova reset-state --active $p
	nova stop $p
done < all_vms.txt

nova list --all_tenants
