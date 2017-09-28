FROM b32147/base-alpine
MAINTAINER Bryan <bryan@macdata.io>

RUN apk -U add \
  postfix \
  ca-certificates \
  libsasl \
  py-pip \
  && rm -rf /var/cache/apk/*
  
RUN pip install j2cli

ADD /root /

RUN mkfifo /var/spool/postfix/public/pickup \
    && ln -s /etc/postfix/aliases /etc/aliases

EXPOSE 25

ENTRYPOINT ["/init"]
