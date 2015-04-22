for i in `nova service-list  | grep 'nova-compute' | grep down | cut -d '|' -f 4`; do ssh $i service nova-compute restart; done
