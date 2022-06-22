#!/bin/bash

set -e
INTERNETIP=$(curl -s ipinfo.io/ip)
echo "{\"myip\": \"$INTERNETIP\"}"