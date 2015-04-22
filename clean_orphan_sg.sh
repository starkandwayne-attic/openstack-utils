#!/usr/bin/env bash
ids=($( neutron security-group-rule-list | grep -Eo "^\| [0-9a-z\-]*" | sed -r 's/\| //g'| sed '1d' ))
 
for id in ${ids[@]}
do
 tenant_id=$(neutron security-group-rule-show ${id} | awk '/tenant_id/{ print $4}')
 
 if [[ "$tenant_id" = "" ]]
 then
    echo tenant_id is blank
 else
    if keystone tenant-list | grep -q ${tenant_id}
     then
        echo found tenant ${tenant_id} for id ${id}
    else
        echo did not find tenant ${tenant_id} for id ${id} - deleting rule...
        neutron security-group-rule-delete ${id}
    fi
 fi
done
 
ids=($( neutron security-group-list | grep -Eo "^\| [0-9a-z\-]*" | sed -r 's/\| //g'| sed '1d' ))
 
for id in ${ids[@]}
do
 tenant_id=$(neutron security-group-show ${id} | awk '/ tenant_id/{ print $4}')
 
 if [[ "$tenant_id" = "" ]]
 then
    echo tenant_id is blank
 else
    if keystone tenant-list | grep -q ${tenant_id}
     then
        echo found tenant ${tenant_id} for id ${id}
    else
        echo did not find tenant ${tenant_id} for id ${id} - deleting group...
        neutron security-group-delete ${id}
    fi
 fi
done
