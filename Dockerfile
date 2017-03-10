FROM nlescstoryteller/storyteller

VOLUME /data

WORKDIR /src/query-builder-preprocessing
COPY run_docker_stack.sh .

CMD ["./run_docker_stack.sh", "/data"]
