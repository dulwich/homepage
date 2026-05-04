FROM debian:sid-slim AS build
ADD . /code
RUN apt -y update && apt -y install rsync git make python3-pip python3-dulwich curl && \
    pip install --break-system-packages mkdocs-material pydoctor && \
    cd /code && mkdocs build && \
    git clone https://github.com/dulwich/dulwich /code/dulwich && \
    make -C /code/dulwich apidocs && \
    rsync -az /code/dulwich/apidocs/ /code/output/api

FROM debian:sid-slim
COPY --from=build /code/output /var/www/html
RUN apt -y update && DEBIAN_FRONTEND=noninteractive apt -y install nginx && \
    rm -rf /etc/nginx/sites-enabled /etc/nginx/conf.d /etc/nginx/sites-available && \
    mkdir -p /var/cache/nginx/client_temp \
             /var/cache/nginx/proxy_temp \
             /var/cache/nginx/fastcgi_temp \
             /var/cache/nginx/uwsgi_temp \
             /var/cache/nginx/scgi_temp
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
