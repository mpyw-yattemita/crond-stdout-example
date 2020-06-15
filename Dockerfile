FROM alpine:latest

RUN apk add --no-cache tini
COPY script.sh /bin/
RUN echo '* * * * * /bin/script.sh 1>&2' >> /var/spool/cron/crontabs/root
CMD ["/sbin/tini", "--", "crond", "-f"]
