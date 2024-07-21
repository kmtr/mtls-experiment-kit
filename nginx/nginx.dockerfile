FROM nginx:1.27.0
COPY nginx.conf /etc/nginx/
COPY index.html /usr/share/nginx/html/
