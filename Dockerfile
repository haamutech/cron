FROM alpine

# Copy scripts.
COPY *.sh /usr/local/sbin/

# Give executable rights to scripts.
RUN chmod +x /usr/local/sbin/*.sh

# Setup a health check that checks if the service is alive every 15 minutes.
RUN echo "*/15 * * * * health-status.sh" >> /etc/crontabs/root && cat /etc/crontabs/root
HEALTHCHECK --interval=1m CMD [ "health-status.sh", "verify" ]

# Run crond in foreground.
ENTRYPOINT [ "entrypoint.sh" ]
CMD [ "crond", "-f", "-l", "4", "-L", "/dev/stdout" ]
