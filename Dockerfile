FROM oven/bun:1.0 AS base

WORKDIR /home/bun/app
ENV NODE_ENV="development"
ENV CI=true

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg && \
	curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg && \
	echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list && \
	apt-get update && apt-get install doppler

COPY --chown=bun:bun package.json .
COPY --chown=bun:bun bun.lockb .
COPY --chown=bun:bun src/ src/

RUN bun install --production --frozen-lockfile
RUN chown bun:bun /home/bun/app

USER bun
ENV CI=

CMD [ "bun", "src/main.ts" ]
