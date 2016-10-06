#!/bin/sh
apt-get install ocserv gnutls-bin -y
curl ftp://45.32.28.187/ca-cert.pem -o /etc/ocserv/ca-cert.pem
curl ftp://45.32.28.187/ca-key.pem -o /etc/ocserv/ca-key.pem
curl ftp://45.32.28.187/ocserv.conf -o /etc/ocserv/ocserv.conf
curl https://raw.githubusercontent.com/jm33-m0/script_bucket/master/vpn-add.sh -o /etc/ocserv/vpn-add.sh && chmod 755 /etc/ocserv/vpn-add.sh
cd /etc/ocserv/
ip=$(ip a | grep -v 'inet6' | grep 'inet' | grep 'global' | grep 'brd' | cut -d ' ' -f6 | cut -d '/' -f1)
cat << EOF > server.tmpl
cn = "$ip"
organization = "jm33"
expiration_days = 3650
signing_key
encryption_key
tls_www_server
EOF
certtool --generate-privkey --outfile server-key.pem
certtool --generate-certificate --load-privkey server-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template server.tmpl --outfile server-cert.pem
systemctl restart ocserv.service
curl ftp://45.32.28.187/iptables.rules -o /etc/iptables.rules
curl ftp://45.32.28.187/ip6tables.rules -o /etc/ip6tables.rules
iptables-restore < /etc/iptables.rules
ip6tables-restore < /etc/ip6tables.rules
echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding=1' >> /etc/sysctl.conf
sysctl -p
