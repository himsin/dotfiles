#!/bin/bash

usage() {
	echo "Usage: ./vpn.sh <username> <password>" >&2
}

if [ "$#" -ne 2 ]; then
	usage
	exit 1
fi
if [ -z "$1" ]; then
  echo "Username not provided. Exiting!" >&2
  exit 1
fi
if [ -z "$2" ]; then
  echo "Password not provided. Exiting!" >&2
  exit 1
fi

echo "Connecting vpn..."
pulsesvc -h vpn.adtran.com -u $1 -p $2 -U https://vpn.adtran.com/dana-na/auth/url_3/login.cgi -r Contractor
