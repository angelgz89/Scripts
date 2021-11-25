#! /bin/bash

dd if=/dev/zero of=test bs=64k count=16k conv=fdatasync
