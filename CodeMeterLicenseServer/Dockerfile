# get the go runtime
FROM golang as go-build

# get the Galileo IDE
FROM hypernetlabs/galileo-ide:linux AS galileo-ide

#FROM debian:stable-slim
FROM wiburp/cm-srv

RUN apt-get update && apt upgrade -y && \
		apt-get install -y --no-install-recommends curl ca-certificates vim curl tmux git wget zip unzip vim speedometer net-tools \
        && apt install -y software-properties-common gpg \
        && apt update -y \
        && apt install -y \
               supervisor kmod fuse\
               libsecret-1-dev \
        && curl -fsSL https://deb.nodesource.com/setup_12.x | bash - \
        && apt install -y nodejs \
        && curl https://rclone.org/install.sh
        
# get the go runtime and opera executable
COPY --from=go-build /go /go
COPY --from=go-build /usr/local/go /usr/local/go
ENV PATH $PATH:/usr/local/go/bin:/home/galileo:/home/galileo/.local/bin
ENV GOPATH=/usr/local/go

RUN go get -u github.com/bitnami/bcrypt-cli

RUN useradd -ms /bin/bash galileo

COPY --chown=galileo .theia /home/galileo/.theia
COPY --chown=galileo .vscode /home/galileo/.vscode

# Find direct link at https://www.wibu.com/support/user/user-software.html
# Link for Version 7.40 2021-12-17 multilanguage Linux 64-bit DEB Package
ARG CODEMETER_PKG_URL=https://www.wibu.com/support/user/user-software/file/download/8870.html?tx_wibudownloads_downloadlist%5BdirectDownload%5D=1&tx_wibudownloads_downloadlist%5BuseAwsS3%5D=0&cHash=7188a558a65794c26a09b707872ee677
RUN curl "${CODEMETER_PKG_URL}" > codemeter.deb
RUN apt-get install -y ./codemeter.deb

# get the Caddy server executables and stuff
COPY --from=galileo-ide --chown=galileo /caddy/caddy /usr/bin/caddy
COPY --from=galileo-ide --chown=galileo /caddy/header.html /etc/assets/header.html
COPY --from=galileo-ide --chown=galileo /caddy/users.json /etc/gatekeeper/users.json
COPY --from=galileo-ide --chown=galileo /caddy/auth.txt /etc/gatekeeper/auth.txt
COPY --from=galileo-ide --chown=galileo /caddy/settings.template /etc/gatekeeper/assets/settings.template
COPY --from=galileo-ide --chown=galileo /caddy/login.template /etc/gatekeeper/assets/login.template
COPY --from=galileo-ide --chown=galileo /caddy/custom.css /etc/assets/custom.css
COPY --chown=galileo rclone.conf /home/galileo/.config/rclone/rclone.conf
COPY --chown=galileo Caddyfile /etc/

# get the galileo IDE
COPY --from=galileo-ide --chown=galileo /.galileo-ide /home/galileo/.galileo-ide

COPY Server.ini /etc/wibu/CodeMeter/Server.ini

RUN chmod -R a=rwx /etc/wibu/CodeMeter/

WORKDIR /home/galileo/.galileo-ide

# get supervisor configuration file
COPY supervisord.conf /etc/

# set environment variable to look for plugins in the correct directory
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/galileo/.galileo-ide/plugins
ENV USE_LOCAL_GIT true
ENV GALILEO_RESULTS_DIR /home/galileo

# set login credentials and write them to text file
ENV USERNAME "a"
ENV PASSWORD "b"
RUN sed -i 's,"username": "","username": "'"$USERNAME"'",1' /etc/gatekeeper/users.json && \
    sed -i 's,"hash": "","hash": "'"$(echo -n "$(echo $PASSWORD)" | bcrypt-cli -c 10 )"'",1' /etc/gatekeeper/users.json

ENTRYPOINT ["sh", "-c", "supervisord"]

