#!/bin/bash

RELEASE_VERSION=v1.10.1-victorialogs

wget -N https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/${RELEASE_VERSION}/victoria-logs-linux-amd64-${RELEASE_VERSION}.tar.gz
tar xzf victoria-logs-linux-amd64-${RELEASE_VERSION}.tar.gz
