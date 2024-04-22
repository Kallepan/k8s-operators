#!/bin/bash

go mod tidy
go mod download

###
# Taken from here: https://book.kubebuilder.io/quick-start.html
###
mkdir -p /tmp/kubebuilder && cd /tmp/kubebuilder
curl -L -o kubebuilder "https://go.kubebuilder.io/dl/latest/$(go env GOOS)/$(go env GOARCH)"
chmod +x kubebuilder && sudo mv kubebuilder /usr/local/bin/