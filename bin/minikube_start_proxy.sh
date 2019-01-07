#!/bin/bash

minikube start --logtostderr --docker-env HTTP_PROXY=10.0.2.2:3128 \
        --docker-env HTTPS_PROXY=10.0.2.2:3128 \
	--docker-env no_proxy="localhost, 127.0.0.1, 192.168.99.0/24" \
        --v 5 \
	--memory=8192 \
        --cpus=4 \
	--kubernetes-version=v1.11.3 \
        --disk-size=30g \
 	--extra-config=apiserver.enable-admission-plugins=\
           "LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,\
            ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook" \

