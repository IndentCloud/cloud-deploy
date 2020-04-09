FROM google/cloud-sdk:alpine

ENV TERRAFORM_VERSION="0.12.24"
ENV KUBECTL_VERSION="v1.17.3"
ENV HELM_VERSION="v3.1.1"
ENV TERRAFORM_PROVIDER_KUBECTL_VERSION="v0.2.0"

VOLUME ["/data"]

WORKDIR /data




RUN apk update && \
    apk add unzip wget bash && \
    cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    mkdir -p ~/.terraform.d/plugins && \
    wget -q  https://github.com/nabancard/terraform-provider-kubernetes-yaml/releases/download/${TERRAFORM_PROVIDER_KUBECTL_VERSION}/terraform-provider-k8sraw-linux-amd64 -O ~/.terraform.d/plugins/terraform-provider-k8sraw && \
    chmod +x ~/.terraform.d/plugins/terraform-provider-k8sraw && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/tmp/*

CMD ["bash"]
