#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DATA_DIR=$1
DB=$2

python $DIR/src/create_sqlite.py --input $DATA_DIR/light.json            --name $DB --tablename light
python $DIR/src/create_sqlite.py --input $DATA_DIR/dark.json             --name $DB --tablename dark
python $DIR/src/create_sqlite.py --input $DATA_DIR/concept.json          --name $DB --tablename concepts

python $DIR/src/create_sqlite.py --input $DATA_DIR/events.json           --name $DB --tablename events
python $DIR/src/create_sqlite.py --input $DATA_DIR/authors.json          --name $DB --tablename authors
python $DIR/src/create_sqlite.py --input $DATA_DIR/cited.json            --name $DB --tablename cited
python $DIR/src/create_sqlite.py --input $DATA_DIR/topics.json           --name $DB --tablename topics
python $DIR/src/create_sqlite.py --input $DATA_DIR/perspectives.json     --name $DB --tablename perspectives

#python $DIR/src/create_queries_table.py --name $DB
