ARG BUILD_FROM
FROM bellamy/wallos:2.38.0

# Set version label
LABEL io.hass.type="addon"
LABEL io.hass.name="Wallos"
LABEL io.hass.description="Open-Source Subscription Tracker"

# Copy run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost/health.php || exit 1

CMD [ "/run.sh" ]
