#!/usr/bin/env bash
DATA_DIR=$1

cd /src/StoryTeller/scripts
chmod +x getoverview.sh
./getoverview.sh

mkdir /tmp
cp token.index.gz /tmp/token.index.gz
mv *.json /tmp

cd /src/query-builder-preprocessing/
chmod +x create_all.sh
./create_all.sh /tmp storyteller.db

mv storyteller.db DATA_DIR