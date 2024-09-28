server {
  listen 80;
  listen 443;
  listen [::]:80;
  listen [::]:443; 


  # ssl_certificate      /usr/local/etc/nginx/ssl/{{host}}.crt;
  # ssl_certificate_key  /usr/local/etc/nginx/ssl/{{host}}.key;
  # ssl_ciphers          HIGH:!aNULL:!MD5;
  
  server_name atm.stack;
  
  #document root, relative path doesn't work!
  root C:/wingp.stack/wingp/vhosts/atm.stack;

  add_header X-Frame-Options "SAMEORIGIN";
  add_header X-XSS-Protection "1; mode=block";

  index index.html index.htm index.php;

  charset utf-8;
  
  location = /favicon.ico { access_log off; log_not_found off; }
  location = /robots.txt  { access_log off; log_not_found off; }

  #access_log off;

  location / {
    try_files $uri $uri/ /index.php?$query_string;
  }

  #error_page 404 /index.php;

  location ~ \.php$ {
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    fastcgi_pass 127.0.0.1:9123;
    fastcgi_index index.php;
    include fastcgi.conf;
  }
  
  location ~ /\.(?!well-known).* {
    deny all;
  }
}