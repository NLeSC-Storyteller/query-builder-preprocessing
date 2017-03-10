FROM nlescstoryteller/storyteller

WORKDIR /src/StoryTeller/scripts
RUN chmod +x getoverview.sh
RUN ./getoverview.sh

# COPY token.index.gz /data
# RUN mv *.json /data

WORKDIR /src/query-builder-preprocessing/
RUN chmod +x create_all.sh
RUN ./create_all.sh /data storyteller.db

# RUN mv storyteller.db /data