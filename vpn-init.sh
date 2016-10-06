#!/bin/sh
apt-get install ocserv -y
curl https://ruzuo.cf/ca-cert.pem -o /etc/ocserv/ca-cert.pem
curl https://ruzuo.cf/ca-key.pem -o /etc/ocserv/ca-key.pem
curl https://ruzuo.cf/ocserv.conf -o /etc/ocserv/ocserv.conf
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
echo -n 'Proceed to add your first user? [y/n]'
read re
if [ "$re" -eq "y" ]; then
    sh vpn-add.sh
else
    exit 0
fi
