#!/bin/bash

echo "Setting myhostname variable for postfix"
postconf -e myhostname=$(hostname)

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
tail -F /var/log/mail.log
