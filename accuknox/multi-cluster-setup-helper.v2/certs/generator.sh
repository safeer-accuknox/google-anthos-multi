#!/bin/bash

openssl req -x509 -sha256 -newkey rsa:2048 -keyout private.key -out certificate.crt -days 1024 -nodes -config csr.config
cat certificate.crt | base64 -w 0 && echo