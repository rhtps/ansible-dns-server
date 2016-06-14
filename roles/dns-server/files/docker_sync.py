#!/usr/bin/env python

from __future__ import print_function
from urllib2 import urlopen
import json
from docker import Client

query_url = 'https://registry.access.redhat.com/v1/search?q=*'
tags_url = 'https://registry.access.redhat.com/v1/repositories/IMAGE/tags'

cli = Client(base_url='unix://var/run/docker.sock', version='1.21')

all_images = json.loads(str(urlopen(query_url).read()))
for image in all_images['results']:
    image_name = image['name']
    if image_name.startswith('openshift') or image_name.startswith('rhel') or image_name.startswith('jboss'):
        print(image_name + ' ', end='')
        image_tags_url = tags_url.replace('IMAGE', image_name)
        image_tags = json.loads(str(urlopen(image_tags_url).read()))
        latest_id = image_tags['latest']
        all_tags = ['latest']
        for key in image_tags.keys():
            if image_tags[key] == latest_id:
                all_tags.append(key)
        for tag in all_tags:
            print(tag + ' ', end='')
            cli.pull('registry.access.redhat.com/' + image_name, tag)
        print('\n', end='')
