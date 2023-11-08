#!/bin/bash


MD5PWD="$(printf "%s" "$PASSWORD" | md5sum | cut -d ' ' -f 1)"

