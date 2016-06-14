#!/usr/bin/env bash

destdir='/var/www/html/docker/'

#for image in `docker images | grep -v ^REPOSITORY | '{print $1":"$2}'`
#do
#    echo ${image}
#    docker save ${image} > ${destdir}/${image}.tar
#done

for id in `docker images -q | sort -u`; do
    image_names=''
    for image in `docker images | grep ${id} | awk '{print $1":"$2}'`; do
        image_names="${image_names} ${image}"
    done
    tar_name=`echo ${image_names} | awk '{print $1}' | cut -d: -f1 | sed -e 's/registry.access.redhat.com\///' -e 's/\//_/g'`
    echo ${tar_name}
    docker save -o ${destdir}/${tar_name}.tar ${image_names}
done