#!/usr/bin/env sh

#
# Generates a self-signed certificate that is considered safe by chrome by making sure
# there is a SAN entry and by importing the certificate as trusted into the MacOS keychain
#

DIR=${1}
DIR=${DIR:=./storage/app/docker/}

IMPORT=0

if [ ! -f "${DIR}/${COMPOSE_HOSTNAME}.crt" ]; then
    # prevent chrome bitching about a "Subject Alternative Name missing"
    cat << EOF > $DIR/alternate.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${COMPOSE_HOSTNAME}
EOF

    # Generate a new private key
    openssl genrsa -out "${DIR}/${COMPOSE_HOSTNAME}.key" 2048

    # Generate a CSR using the private key for encryption
    openssl req -new -key "${DIR}/${COMPOSE_HOSTNAME}.key" -out "${DIR}/${COMPOSE_HOSTNAME}.csr" -subj "/C=BE/ST=Brussels/L=Brussels/O=VDAB/OU=development/CN=${COMPOSE_HOSTNAME}"

    # Sign the certificate
    openssl x509 -req -days 365 -in "${DIR}/${COMPOSE_HOSTNAME}.csr" -signkey "${DIR}/${COMPOSE_HOSTNAME}.key" -out "${DIR}/${COMPOSE_HOSTNAME}.crt" -extfile "$DIR/alternate.ext"

    IMPORT=1
fi

if [ "$IMPORT" = false ]; then
    security dump-trust-settings -d | grep -q "${COMPOSE_HOSTNAME}"
    EXISTS=$?
    if [ $EXISTS -eq 1 ]; then
        IMPORT=1
    fi
fi

if [ $IMPORT -eq 1 ]; then
    # Import the certificate as a trusted root
    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "${DIR}/${COMPOSE_HOSTNAME}.crt"
fi