#!/bin/bash

openssl req -out certificate.crt  -newkey rsa:2048 -nodes -keyout private.key -config san.cnf
cat certificate.crt | base64 -w 0 && echo