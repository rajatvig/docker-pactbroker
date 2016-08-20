FROM ruby:2.3.1

ENV APP_DIR /var/run
ENV LOG_DIR /var/log/pactbroker
ENV NGINX_DIR /etc/nginx
ENV PID_FILE /var/run/supervisord.pid

RUN mkdir -p $LOG_DIR && \
    apt-get update && \
    apt-get install -y supervisor nginx jq && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /var/run

COPY supervisord.conf $APP_DIR
COPY nginx.conf $NGINX_DIR
COPY proxy.conf $NGINX_DIR/conf.d

RUN rm $NGINX_DIR/sites-enabled/default

COPY pactbroker $APP_DIR/pactbroker

RUN cd $APP_DIR/pactbroker && \
    gem install bundler && \
    bundle install --deployment --without='development test'

EXPOSE 80

CMD ["supervisord", "-n"]
