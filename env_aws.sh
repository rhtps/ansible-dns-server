#!/usr/bin/env bash

export ANSIBLE_HOST_KEY_CHECKING="False"
export ec2_region='us-east-1'
export os_cluster_id='ose-disconn'
export ec2_public_az="${ec2_region}a"
export ec2_private_1a_az="${ec2_region}a"
export ec2_private_1e_az="${ec2_region}e"
export ec2_image="ami-2051294a"
export ec2_instance_type_bastion="m4.large"
export r53_zone="rhtps.io"

