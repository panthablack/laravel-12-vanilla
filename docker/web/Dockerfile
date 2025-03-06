FROM nginx:1.26.3-alpine AS base
WORKDIR /usr/share/nginx/html
COPY . /usr/share/nginx/html

FROM base AS dev
COPY ./docker/web/nginx.dev.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

FROM base AS prod
COPY ./docker/web/nginx.prod.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
