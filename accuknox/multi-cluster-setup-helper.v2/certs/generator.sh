#!/bin/bash

DOMAIN="accuknox-multi-cluster-helper-webhook.agents.svc"  
KEY_FILE="private.key"
CERT_FILE="certificate.crt"
DAYS=365 

openssl genrsa -out $KEY_FILE 2048
openssl req -new -x509 -key $KEY_FILE -out $CERT_FILE -days $DAYS -subj "/C=US/ST=State/L=City/O=Organization/CN=$DOMAIN"
echo "caBundle: "
cat $CERT_FILE | base64 -w 0 && echo