#!/bin/bash
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -subj '/CN=*.${1}' -nodes
kubectl create secret tls tls-cert \
--key key.pem \
--cert cert.pem -n ${2}
rm *.pem
