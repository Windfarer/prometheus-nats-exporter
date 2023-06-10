#!/bin/bash

# Generate CA
openssl req -nodes -new -x509 -days 3650 -extensions v3_ca -keyout ca.key -out ca.pem -config openssl.cnf

# Generate CSRs
openssl req -nodes -new -keyout server.key -out server.csr -config openssl.cnf
openssl req -nodes -new -keyout client.key -out client.csr -config openssl.cnf

# Sign CSRs
openssl x509 -req -extensions v3_req -extfile openssl.cnf -in server.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out server.pem
openssl x509 -req -extensions v3_req -extfile openssl.cnf -in client.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out client.pem

# These are test certs, cleanup extaneous files
rm ca.key
rm *.csr
rm *.srl
