FROM mcr.microsoft.com/azure-cli:latest

ENV TERRAFORM_VERSION=0.12.6

VOLUME ["/data"]

WORKDIR /data

ENTRYPOINT ["/bin/ash"]

RUN apk update && \
    apk add unzip wget && \
    cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/tmp/*