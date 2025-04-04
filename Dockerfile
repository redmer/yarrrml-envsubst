FROM node:20-slim

ARG NODE_ENV=production
ENV NODE_ENV=$NODE_ENV

# Install Yarrrml-Parser
RUN npm install --global @rmlio/yarrrml-parser
RUN npm cache clean --force

# Install APT dependencies (envsubst)
RUN apt-get update
RUN apt-get install -y -qq -o=Dpkg::Use-Pty=0 \
    gettext
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# COPY installation scripts
COPY compile.sh /app/

WORKDIR /app
ENTRYPOINT ["./app/compile.sh"]
