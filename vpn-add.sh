#!/bin/sh
echo -n 'Username: '
read user
export name=$(echo $user | base64)
export file=$(echo $name | md5sum | cut -d '-' -f1)
cat << EOF > user.tmpl
cn = "lwk"
unit = "vpn"
expiration_days = 9999
signing_key
tls_www_client
EOF
certtool --generate-privkey --outfile user-key.pem
certtool --generate-certificate --load-privkey user-key.pem --load-ca-certificate ca-cert.pem --load-ca-privkey ca-key.pem --template user.tmpl --outfile user-cert.pem
certtool --to-p12 --load-privkey user-key.pem --pkcs-cipher 3des-pkcs12 --load-certificate user-cert.pem --outfile user.p12 --outder
cp ./user.p12 /etc/ocserv/$user$file.p12
rm user*
