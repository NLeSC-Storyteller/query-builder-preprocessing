# nlescstoryteller/query-builder-preprocessing
Preprocessing module for the QueryBuilder stack. Provides commands to create a database which is ready for use by the server.

## About
The query builder preprocessor is written in python and makes heavy use of the Java code in https://github.com/cltl/StoryTeller.

## Installation
### Automated installation
Please note that the installation and execution process is usually fully automated by Docker and Docker-Compose. For information on installing the full stack, see the https://github.com/cltl/StoryTeller repository for more information.

### Manual installation and useage
**With Docker**  
A Dockerfile has been provided for your convenience. Please refer to https://www.docker.com/ for installation of docker.
```bash
    docker build -t nlescstoryteller/query-builder-preprocessing
```

## Troubleshooting
Given an empty query-builder-client interface, the user may want to check the following in this docker container:

1. Connect to the docker container for troubleshooting  

**linux**
```bash
    sudo docker exec -v data:/data -it nlescstoryteller/query-builder-preprocessing /bin/bash
```

**windows**
```bash
    winpty docker exec -v data:/data -ti nlescstoryteller/query-builder-preprocessing //bin/bash
```

2. Check the /data-tmp folder for json files  
```bash
    ls -al /data-tmp
```
The user is expected to find a number of JSON data files here, with sizes > 0kb. 

3. Check the /data folder for a storyteller.db file  
```bash
    ls -al /data
```
The user is expected to find a storyteller.db file here, with size > 0kb. 

4. If either 2. or 3. (or both) are not the case, the getoverview part of the script in run_docker_stack.sh has most likely failed:  
```bash
    cd /src/StoryTeller/scripts
    chmod +x getoverview.sh
    ./getoverview.sh

    mkdir /data-tmp
    cp token.index.gz $DATA_DIR/token.index.gz
    mv *.json /data-tmp
```
To fix this issue, try to remove the contents of the /data and /data-tmp directory and any json files in the /src/StoryTeller/scripts directory, and run the run_docker_stack.sh script again.


# The Full QueryBuilder / Knowledgestore visualization system
The full system consists of 7 parts:

0. KnowledgeStore
    - RDF triple store. The NewsReader KnowledgeStore is a scalable, fault-tolerant, and Semantic Web grounded storage system to jointly store, manage, retrieve, and semantically query, both structured and unstructured data (see https://knowledgestore.fbk.eu/).
1. cltl/StoryTeller (https://github.com/cltl/StoryTeller)
    - Support library for querying the knowledge store and creating JSON data from the results.
2. QueryBuilder Preprocessing (https://github.com/NLeSC-Storyteller/query-builder-preprocessing)
    - written in python
    - uses cltl/Storyteller to get an overview of possible queries from the knowledgestore
    - processes the overview into a sqlite3 database that can be used by the server.
3. QueryBuilder Server (https://github.com/NLeSC-Storyteller/query-builder-server)
    - written in javascript, with express.js + sqlite3 database
    - incudes a custom database trigger written in C on INSERT statements to the queries table.
    - upon receiving a new query string from QueryBuilder, the Server
        - stores the received query in a database
        - runs the received query against the KnowledgeStore using the QueryBuilder Daemon, which updates the list of previous queries and their results, indexed by an identifier.
4. QueryBuilder Daemon (https://github.com/NLeSC-Storyteller/query-builder-daemon)
    - written in Java with Xenon (https://github.com/NLeSC/Xenon)
    - receives requests for knowledgestore queries from the database trigger in the server.
    - queries the Knowledgestore using cltl/Storyteller
    - updates the list of previous queries and their results, indexed by an identifier.
5. QueryBuilder Client (this repository)
    - written in Typescript and React.js
    - shows a list of all possible concepts, actors or events from the server
    - helps the user to compose a sparql query to run against the KnowledgeStore by selecting items of interest, be it concepts, actors, events, etc.
6. UncertaintyVisualization (https://github.com/NLeSC/UncertaintyVisualization/)
    - written in javascript and Angular 1 (legacy)
    - allows the user to select from a list of previously run queries (communicates with Server) to select one for visualization.
    - visualizes the results selected




