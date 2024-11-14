#!/usr/bin/env bash
set -xe

: "${KUBE_CONFIG_DATA:="Cg=="}"
: "${AWS_ACCESS_KEY_ID:="change me"}"
: "${AWS_SECRET_ACCESS_KEY:="change me"}"

# Extract the base64 encoded config data and write this to the KUBECONFIG
echo "$KUBE_CONFIG_DATA" | base64 -d > /tmp/config

export KUBECONFIG=/tmp/config

bash -c "${*}"
