FROM alpine:latest

LABEL maintainer="Hshen <hackshen.com@gmail.com>"

ARG TZ='Asia/Shanghai'

ENV TZ ${TZ}
ENV VERSION 0.29.0
ENV DOWNLOAD_URL https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz
RUN apk --no-cache --update add curl \
    && curl -sSLO ${DOWNLOAD_URL} \
    && tar -zxf frp_${VERSION}_linux_amd64.tar.gz \
    && mv frp_${VERSION}_linux_amd64/ /frp/ \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo "${TZ}" > /etc/timezone \
    && rm -rf frp_${VERSION}_linux_amd64.tar.gz \
    && apk del curl
WORKDIR /frp
CMD ["./frpc","-c","/frp/frpc.ini"]
