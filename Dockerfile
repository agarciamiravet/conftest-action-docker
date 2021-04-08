FROM alpine/helm:2.16.1

RUN apk add --no-cache git curl bash jq coreutils ca-certificates

ENV HELM_HOME /root/.helm

RUN helm init --client-only

RUN helm plugin install --debug https://github.com/instrumenta/helm-conftest

RUN curl -L https://github.com/open-policy-agent/conftest/releases/download/v0.23.0/conftest_0.23.0_Linux_x86_64.tar.gz | tar xzv -C /tmp && \
    mv /tmp/conftest /usr/local/bin/conftest && \
    rm -rf /tmp/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
