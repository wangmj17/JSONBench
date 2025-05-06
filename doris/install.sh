#!/bin/bash
wget --timestamping https://apache-doris-releases.oss-accelerate.aliyuncs.com/${DORIS_PACKAGE}.tar.gz
mkdir ${DORIS_PACKAGE}
tar -xvf ./${DORIS_PACKAGE}.tar.gz --strip-components 1 -C ./${DORIS_PACKAGE}
