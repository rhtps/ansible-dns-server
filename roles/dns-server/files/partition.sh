#!/bin/bash

if [ ! -b /dev/xvdb1 ]
then
    (echo n; echo p; echo; echo; echo; echo w) | fdisk /dev/xvdb
fi