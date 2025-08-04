FROM debian:sid-slim AS build
ADD . /code
RUN apt -y update && apt -y install rsync git pelican make python3-webassets python3-sphinx python3-typogrify python3-pygments python3-markdown python3-filelock pydoctor python3-paramiko python3-fastimport curl && \
    curl -LsSf https://astral.sh/uv/install.sh | sh && \
    export PATH="/root/.local/bin:$PATH" && \
    uv pip install --system --break-system-packages pelican-sitemap pelican git+https://github.com/jelmer/googleanalytics && \
    cd /code && make -C /code publish && git clone https://github.com/dulwich/dulwich /code/dulwich && \
    make -C /code/dulwich apidocs && \
    rsync -az /code/dulwich/apidocs/ /code/output/api
FROM debian:sid-slim
COPY --from=build /code/output /var/www/html
RUN apt -y update && DEBIAN_FRONTEND=noninteractive apt -y install nginx
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
