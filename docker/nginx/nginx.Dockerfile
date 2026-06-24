FROM nginx:alpine

WORKDIR /var/www/html

# Remove default nginx config
RUN rm -rf /etc/nginx/conf.d/default.conf

# Copy your custom config
COPY ./docker/nginx/local.conf /etc/nginx/conf.d/default.conf

# Set permissions (optional safety)
RUN chmod -R 755 /var/www/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]