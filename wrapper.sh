#!/bin/bash

set -e

cd /pocketmine

if [ -z "$1" ]; then
	echo "Missing argument for plugin name"
	exit 1
fi

export DYNCMDLIST_PLUGIN_NAME="$1"

if [ ! -d /input ]; then
	echo "/input was not mounted"
	exit 1
fi

if [ -z "$(echo /input/*.phar)" ]; then
	echo "/input is empty"
	exit 1
fi

mkdir ./plugins ./data
cp /input/*.phar ./plugins/
cp ./dyncmdlist.phar ./plugins/

php PocketMine-MP.phar --no-wizard --disable-ansi --data=./data --plugins=./plugins >/dev/null
EXIT_CODE="$?"

if [ $EXIT_CODE -ne 0 ]; then
	echo "PocketMine exited with $EXIT_CODE"
	exit 1
fi

if [ ! -f ./dyncmdlist-output.json ]; then
	echo "dyncmdlist-output.json was not created"
	exit 1
fi

cat ./dyncmdlist-output.json
