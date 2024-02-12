#!/usr/bin/env bash

hosts="$1"
shift

[[ -z "$hosts" ]] && { echo "No hosts to deploy"; exit 1; }

for host in ${hosts//,/ }; do
    nixos-rebuild switch --flake .\#$host --build-host $host --target-host $host --use-remote-sudo --use-substitutes $@
done
