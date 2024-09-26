#!/bin/bash

openssl genpkey -outform PEM -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out private.key
openssl req -new -nodes -key private.key -config sans.csr -nameopt utf8 -utf8 -out certificate.crt
cat certificate.crt | base64 -w 0 && echo