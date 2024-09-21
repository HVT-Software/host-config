#!/bin/sh

# Copy configuration files if they do not already exist
for file in /config/*; do
  if [ ! -f "/etc/nginx/conf.d/$(basename $file)" ]; then
    cp $file /etc/nginx/conf.d/
  fi
done

# Ensure the default vhost file exists
if [ ! -f "/etc/nginx/vhost.d/default" ]; then
  echo 'server {
    listen 80;
    server_name _;
    return 444;
  }' > /etc/nginx/vhost.d/default
fi

# Execute the original entrypoint
exec "$@"