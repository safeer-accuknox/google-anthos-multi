#!/bin/bash

openssl genpkey -outform PEM -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out private.key

openssl req -new -nodes -key private.key -config csrconfig.txt -nameopt utf8 -utf8 -out cert.csr

openssl req -x509 -nodes -in cert.csr -days 365 -key private.key -config certconfig.txt -extensions req_ext -nameopt utf8 -utf8 -out certificate.crt
rm cert.csr
# cat certificate.crt | base64 -w 0 && echo