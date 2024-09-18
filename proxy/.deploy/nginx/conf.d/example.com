server {
  server_name example.com;

  location / {
    proxy_pass http://127.0.0.1:8000;
    proxy_set_header   Host $host;
    proxy_set_header   X-Real-IP $remote_addr;
    proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
  }

  listen 443 ssl;
  ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
  ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
  include /etc/letsencrypt/options-ssl-nginx.conf;
  ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
}

server {
  if ($host = example.com) {
      return 301 https://$host$request_uri;
  }

  server_name example.com;

  listen 80;
  return 404;
}
