FROM debian:stable-slim

RUN apt-get update && apt upgrade -y && \
		apt-get install -y --no-install-recommends \
		curl \
		ca-certificates

# Find direct link at https://www.wibu.com/support/user/user-software.html
# Link for Version 7.40 2021-12-17 multilanguage Linux 64-bit DEB Package
ARG CODEMETER_PKG_URL=https://www.wibu.com/support/user/user-software/file/download/8870.html?tx_wibudownloads_downloadlist%5BdirectDownload%5D=1&tx_wibudownloads_downloadlist%5BuseAwsS3%5D=0&cHash=7188a558a65794c26a09b707872ee677
RUN curl "${CODEMETER_PKG_URL}" > codemeter.deb
RUN apt-get install -y ./codemeter.deb

COPY Server.ini /etc/wibu/CodeMeter/Server.ini

# Use "/usr/sbin/CodeMeterLin -h" for all options
ENTRYPOINT ["/usr/sbin/CodeMeterLin", "-v", "-l", "-n+"]
