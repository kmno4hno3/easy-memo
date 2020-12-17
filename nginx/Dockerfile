FROM nginx:latest

RUN apt-get update && \
    apt-get install -y vim less

    # ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf