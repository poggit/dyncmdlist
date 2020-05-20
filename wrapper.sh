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

if [[ $SHOW_STDOUT ]]; then
	OUTPUT_FILE=/dev/stdout
else
	OUTPUT_FILE=console.log
fi

php PocketMine-MP.phar --no-wizard --disable-ansi --data=./data --plugins=./plugins >$OUTPUT_FILE
EXIT_CODE="$?"

if [ $EXIT_CODE -ne 0 ]; then
	echo "PocketMine exited with $EXIT_CODE"
	cat console.log
	exit 1
fi

if [ ! -f ./dyncmdlist-output.json ]; then
	echo "dyncmdlist-output.json was not created"
	cat console.log
	exit 1
fi

cat ./dyncmdlist-output.json
