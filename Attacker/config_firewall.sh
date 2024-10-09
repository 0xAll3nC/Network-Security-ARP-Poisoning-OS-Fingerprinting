iptables -t nat -A PREROUTING -s 10.0.0.1 -d 10.0.0.4 -p tcp --dport 80 -j DNAT --to-destination 10.0.0.3:8000
