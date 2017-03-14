FROM nlescstoryteller/storyteller

VOLUME /data

WORKDIR /src/query-builder-preprocessing
COPY run_docker_stack.sh .
RUN chmod +x run_docker_stack.sh

EXPOSE 4567
CMD ["./run_docker_stack.sh", "/data"]
