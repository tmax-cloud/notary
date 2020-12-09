#!/bin/bash

set -e

if [ -z $SERVER_IMG ] || [ -z $SIGNER_IMG ]; then
    echo "You needs to excute following commands for env."
    echo "And if you didn't login registry to push images,"
    echo "you must login registry before run this shell script."
    echo ""
    echo -e "\texport SERVER_IMG=registry/username/notary_server"
    echo -e "\texport SIGNER_IMG=registry/username/notary_signer"
    echo ""
    echo -e "example:"
    echo -e "\texport SERVER_IMG=docker.io/testuser/notary_server"
    echo -e "\texport SIGNER_IMG=docker.io/testuser/notary_signer"
    echo ""
    exit 1
fi

NOTARY_VERSION=${NOTARY_VERSION:-0.6.2-rc1}

docker build -t $SERVER_IMG:$NOTARY_VERSION -f custom.server.minimal.Dockerfile .
docker build -t $SIGNER_IMG:$NOTARY_VERSION -f custom.signer.minimal.Dockerfile .

docker push $SERVER_IMG:$NOTARY_VERSION
docker push $SIGNER_IMG:$NOTARY_VERSION

