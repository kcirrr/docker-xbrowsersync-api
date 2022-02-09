FROM bitnami/node:12.22.10-debian-10-r7

ENV USER xbrowsersync
ENV UID 1000
ENV GID 1000
ENV XBROWSERSYNC_API_VERSION 1.1.13

WORKDIR /app

RUN groupadd -r "${USER}" --gid="${GID}" \
  && useradd --no-log-init -r -g "${GID}" --uid="${UID}" "${USER}" \
  && wget -q -O release.tar.gz https://github.com/xBrowserSync/api/archive/v$XBROWSERSYNC_API_VERSION.tar.gz \
	&& tar -C . -xzf release.tar.gz \
	&& rm release.tar.gz \
	&& mv api-$XBROWSERSYNC_API_VERSION/* . \
	&& rm -rf api-$XBROWSERSYNC_API_VERSION/ \
  && wget -q https://raw.githubusercontent.com/xbrowsersync/api-docker/v$XBROWSERSYNC_API_VERSION/healthcheck.js \
  && npm install --only=production --prefix /app

USER "${UID}"
EXPOSE 8080
CMD [ "node", "dist/api.js"]
