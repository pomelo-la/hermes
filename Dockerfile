FROM golang:1.18

# Install Node

# Install envsubst to build config.hcl and credentials file
RUN apt install gettext-base

ENV NODE_VERSION=16.13.0
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

# Install Yarn

RUN corepack enable
RUN corepack prepare yarn@3.3.0 --activate

# Prepare environment

WORKDIR /hermes

COPY . .

# Build

RUN make build

CMD [ "./entrypoint.sh" ]
