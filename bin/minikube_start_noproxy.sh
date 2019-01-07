#!/bin/bash

minikube start \
        --logtostderr \
        --v 5 \
	--memory=8192 \
        --cpus=4 \
	--kubernetes-version=v1.11.3 \
        --disk-size=30g \
 	--extra-config=apiserver.enable-admission-plugins=\
           "LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,\
            ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook" \

