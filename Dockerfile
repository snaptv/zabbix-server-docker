FROM debian:jessie

RUN apt-get update
RUN apt-get install -y gcc make curl libpq-dev postgresql-client
RUN apt-get clean

RUN curl -Lo /tmp/zabbix.tar.gz http://repo.zabbix.com/zabbix/2.4/debian/pool/main/z/zabbix/zabbix_2.4.6.orig.tar.gz
RUN tar -C /tmp/ -xf /tmp/zabbix.tar.gz
RUN (cd /tmp/zabbix-2.4.6 && ./configure --enable-server --with-postgresql && make && make install)
RUN cp -aP /tmp/zabbix-2.4.6/database/postgresql/*.sql /usr/local/share/zabbix/
RUN rm -r /tmp/*

RUN useradd --system zabbix

RUN curl -Lo /usr/bin/confd https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64
RUN chmod +x /usr/bin/confd
RUN mkdir -p /etc/confd/templates/
RUN mkdir -p /etc/confd/conf.d/

COPY *.toml /etc/confd/conf.d/
COPY *.tmpl /etc/confd/templates/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
EXPOSE 10051
