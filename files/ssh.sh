#!/bin/bash
...
set -e

SSHHOST="$(terraform output | jq '.External_IP.value'| xargs)"