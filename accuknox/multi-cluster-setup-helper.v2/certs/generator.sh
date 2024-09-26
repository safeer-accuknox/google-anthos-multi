#!/bin/bash

openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 365 -key ca.key -subj "/C=CN/ST=GD/L=SZ/O=Acme, Inc./CN=Acme Root CA" -out ca.crt

openssl req -newkey rsa:2048 -nodes -keyout private.key -subj "/C=CN/ST=GD/L=SZ/O=Acme, Inc./CN=accuknox-multi-cluster-helper-webhook.agents.svc" -out server.csr
openssl x509 -req -extfile <(printf "subjectAltName=DNS:accuknox-multi-cluster-helper-webhook.agents.svc") -days 365 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out certificate.crt



cat certificate.crt | base64 -w 0 && echo
rm ca.crt ca.key ca.srl server.csr