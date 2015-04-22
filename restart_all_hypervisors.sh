for i in `fuel node | grep compute | grep -v False | awk '{print$1}'`; do ssh node-$i service nova-compute restart;done
