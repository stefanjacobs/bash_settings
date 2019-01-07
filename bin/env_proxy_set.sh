#!/bin/bash

export http_proxy=http://localhost:3128
export https_proxy=$http_proxy
export no_proxy="localhost, 127.0.0.1, 192.168., .db.de, localdomain, local"
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$https_proxy
export NO_PROXY=$no_proxy


