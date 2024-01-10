#!/bin/bash

# watch -n 1 ./watcher.sh

sensors coretemp-isa-0000 && cat /proc/cpuinfo | grep MHz
