FROM node:17.4.0-alpine3.15 

ENV XBROWSERSYNC_API_VERSION 1.1.13

WORKDIR /usr/src/api

RUN wget -q -O release.tar.gz https://github.com/xBrowserSync/api/archive/v$XBROWSERSYNC_API_VERSION.tar.gz \
	&& tar -C . -xzf release.tar.gz \
	&& rm release.tar.gz \
	&& mv api-$XBROWSERSYNC_API_VERSION/* . \
	&& rm -rf api-$XBROWSERSYNC_API_VERSION/ \
  && wget -q https://raw.githubusercontent.com/xbrowsersync/api-docker/v$XBROWSERSYNC_API_VERSION/healthcheck.js \
  && install -d -m 0775 -g node logs \
  && npm install --only=production

USER node
EXPOSE 8080
CMD [ "node", "dist/api.js"]
