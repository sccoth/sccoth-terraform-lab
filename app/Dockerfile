FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.template.html

CMD ["/bin/sh", "-c", "envsubst '${POD_NAME}' < /usr/share/nginx/html/index.template.html > /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"]

EXPOSE 80