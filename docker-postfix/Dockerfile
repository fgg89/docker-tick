FROM ubuntu:18.04

LABEL creator="Erik Kaareng-Sunde" maintainer="Diego Pasten <dap@enonic.com>"

RUN echo postfix postfix/main_mailer_type string Internet site | debconf-set-selections
RUN echo postfix postfix/mailname string mail.example.com | debconf-set-selections

RUN echo "---> INSTALLING packages + cleanup" \
  && apt-get update \
  && apt-get install -q -y less vim language-pack-en postfix mailutils rsyslog supervisor \
  && apt-get clean \
  && echo "---> Make supervisor log folder" \
  && mkdir -p /var/log/supervisor \
  && echo "---> Update locales" \
  && update-locale LANG=en_US.UTF-8 \
  && echo "---> Making changes to /var/postfix/main.cf" \
  && postconf -e "myorigin = \$myhostname" \
  && postconf -e "message_size_limit = 52400000" \
  && postconf -e "mynetworks_style = subnet" \
  && postconf -X "mynetworks" \
  && postconf -e "inet_protocols = ipv4"

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start_postfix.sh /usr/local/bin/start_postfix.sh
ADD launcher.sh /launcher.sh
ADD main.cf /etc/postfix/main.cf

RUN chmod +x /usr/local/bin/start_postfix.sh \
  && chmod +x /launcher.sh

EXPOSE 25
CMD /launcher.sh
