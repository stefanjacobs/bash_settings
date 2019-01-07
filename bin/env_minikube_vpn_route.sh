#!/bin/bash

sudo route -nv delete -net 192.168.99.0/24 -interface vboxnet0
sudo route -nv add -net 192.168.99.0/24 -interface vboxnet0
