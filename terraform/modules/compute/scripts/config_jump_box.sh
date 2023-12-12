#!/bin/bash

cat << EOF >> /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6=1
net.ipv4.ip_forward = 1
EOF

sysctl -p

apt -y update && apt -y upgrade

# NFtables
apt install nftables

cat << EOF > /etc/nftables.conf
#!/usr/sbin/nft -f

flush ruleset

table inet filter {
        chain input {
                type filter hook input priority 0;
        }
        chain forward {
                type filter hook forward priority 0;
        }
        chain output {
                type filter hook output priority 0;
        }
}

table inet nat {
	chain postrouting {
                type nat hook postrouting priority 0;
		oifname ens3 masquerade
	}
}
EOF

systemctl disable ufw
systemctl stop ufw
systemctl enable nftables
