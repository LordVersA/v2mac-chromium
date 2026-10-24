# Chromium from Debian's archive on the released base (the sandbox's own root).
ARG BASE
FROM ${BASE}
RUN apt-get update && apt-get install -y --no-install-recommends chromium fonts-noto-color-emoji && rm -rf /var/lib/apt/lists/* /var/cache/apt/*.bin
COPY start.sh /usr/local/bin/start.sh
RUN chmod 755 /usr/local/bin/start.sh
