FROM node:20-bookworm

ADD pasteboard-cron /etc/cron.daily/pasteboard

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install git imagemagick libstdc++6 lib32stdc++6 -y \
    && chmod 755 /etc/cron.daily/pasteboard \
    && npm install -g coffee-script \
    && apt-get clean && rm -rf /var/lib/apt/lists

ADD src /pasteboard

WORKDIR /pasteboard
RUN npm install

ENV MAX=7
ENV LOCAL=true

VOLUME ["/pasteboard/public/storage/"]
EXPOSE 4000

USER www-data

CMD ["npm", "run", "start"]
