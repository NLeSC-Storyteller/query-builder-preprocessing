#!/usr/bin/env bash
DATA_DIR=$1

cd /src/StoryTeller/scripts
chmod +x getoverview.sh
./getoverview.sh

mkdir /data-tmp
cp token.index.gz $DATA_DIR/token.index.gz
mv *.json /data-tmp

cd /src/query-builder-preprocessing/
chmod +x create_all.sh
./create_all.sh /data-tmp $DATA_DIR/storyteller.db