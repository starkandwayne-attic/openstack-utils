for i in `fuel node | grep "10.4." | awk '{print$1}'`; do ssh node-$i date  ;done
