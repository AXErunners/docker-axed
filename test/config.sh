#!/bin/bash
set -e

testAlias+=(
	[axed:trusty]='axed'
)

imageTests+=(
	[axed]='
		rpcpassword
	'
)
