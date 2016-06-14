#!/bin/bash

# Saves the following images into .tar files so they can be
# moved to a disconnected network.

IMAGES=$(docker_list_images.py  | egrep '^openshift|^rhel|^jboss' | grep -v beta)
REGISTRY_HOST=registry.access.redhat.com

for i in ${IMAGES[@]}
do
	docker pull $REGISTRY_HOST/$i
	FILENAME=$(echo ${i} |  cut -d\/ -f 2).tar
	docker save $REGISTRY_HOST/$i > $FILENAME
done
