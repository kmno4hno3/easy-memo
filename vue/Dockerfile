FROM node:12.18.3-alpine

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

RUN apk update && \
    apk add vim && \
    npm install -g npm && \
    npm install -g @vue/cli