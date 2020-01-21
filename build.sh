#!/bin/bash
set -e
image="proton-native-cljs"
instance="$image--instance"
docker build . --tag "$image"
mkdir -p artifacts
docker create --name "$instance" "$image"
docker cp $instance:/proton-native-cljs/calculator artifacts/calculator
docker rm -f $instance
echo "wrote ./artifacts/calculator"
