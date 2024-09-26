#!/bin/bash

export APP="accuknox-multi-cluster-helper-webhook"
export NAMESPACE="agents"
export CSR_NAME="${APP}.${NAMESPACE}.svc"

openssl genrsa -out ${APP}.key 2048

cat >csr.conf<<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = ${APP}
DNS.2 = ${APP}.${NAMESPACE}
DNS.3 = ${CSR_NAME}
DNS.4 = ${CSR_NAME}.cluster.local
EOF
openssl req -new -key ${APP}.key -subj "/CN=${CSR_NAME}" -out ${APP}.csr -config csr.conf



mv ${APP}.key private.key
mv ${APP}.csr certificate.csr
echo "caBundle: "
cat certificate.csr | base64 -w 0 && echo