#!/command/with-contenv bash

sed -i 's/^module(load="imklog")/# module(load="imklog")/' /etc/rsyslog.conf


