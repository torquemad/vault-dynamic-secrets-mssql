FROM vault:latest

COPY ./config/vault.conf /vault/config/vault.conf

ADD ./configure_once.sh /usr/local/bin
RUN chmod +x /usr/local/bin/configure_once.sh

ADD ./runit.sh /usr/local/bin
RUN chmod +x /usr/local/bin/runit.sh

ENTRYPOINT /usr/local/bin/runit.sh

