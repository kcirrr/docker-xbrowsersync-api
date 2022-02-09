FROM node:16.14.0-alpine3.15

ENV XBROWSERSYNC_API_VERSION 1.1.13

WORKDIR /usr/src/api

ENV USER xbrowsersync
ENV UID 1000
ENV GID 1000

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN addgroup \
  -S "$USER" \
  --gid "$UID" \
  && adduser \
  --disabled-password \
  --gecos "" \
  --home "$(pwd)" \
  --ingroup "$USER" \
  --no-create-home \
  --uid "$UID" \
  "$USER" \
  && curl -SL https://github.com/xBrowserSync/api/archive/v$XBROWSERSYNC_API_VERSION.tar.gz \
  | tar -xzC /usr/src/api /--strip-components=1 \
  && curl -so healthcheck.js https://raw.githubusercontent.com/xbrowsersync/api-docker/v$XBROWSERSYNC_API_VERSION/healthcheck.js \
  && npm install --only=production

USER "${UID}"
EXPOSE 8080
CMD [ "node", "dist/api.js"]
