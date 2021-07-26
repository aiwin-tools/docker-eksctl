FROM python:3.9

RUN apt-get update \
    && apt-get install -y zip jq curl git \
    && rm -rf /var/lib/apt/lists/*

COPY --from=amazon/aws-cli /usr/local /usr/local

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp && \
    mv /tmp/eksctl /usr/local/bin


CMD [ "eksctl" ]
