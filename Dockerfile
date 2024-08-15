FROM amazon/aws-cli:2.17.31

ARG KUBE_VERSION="1.23.0"
ARG HELM_VERSION="3.7.2"
ARG TARGETOS="linux"
ARG TARGETARCH="amd64"

RUN yum install -y ca-certificates bash git openssh curl gettext jq wget tar \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl -O /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-v${HELM_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz -O - | tar -xzO ${TARGETOS}-${TARGETARCH}/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm /usr/local/bin/kubectl \
    && mkdir /config \
    && chmod g+rwx /config /root \
    && helm repo add "stable" "https://charts.helm.sh/stable" --force-update \
    && kubectl version --client \
    && helm version

WORKDIR /app

COPY run.sh .

#COPY ./slack-message.sh /bin/slack-message.sh
#RUN chmod a+x /bin/slack-message.sh
RUN chmod a+x /app/run.sh

ENTRYPOINT [ "/app/run.sh" ]

