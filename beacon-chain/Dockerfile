ARG UPSTREAM_VERSION
FROM sigp/lighthouse:${UPSTREAM_VERSION}-modern

COPY entrypoint.sh entrypoint.sh

EXPOSE $BEACON_API_PORT

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]