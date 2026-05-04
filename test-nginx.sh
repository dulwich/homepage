#!/bin/bash
# Create a test directory with some sample content
mkdir -p /tmp/test-dulwich-site
echo "<html><body><h1>Test Page</h1><a href='/subdir/'>Subdir Link</a></body></html>" > /tmp/test-dulwich-site/index.html
mkdir -p /tmp/test-dulwich-site/subdir
echo "<html><body><h1>Subdir Page</h1><a href='/'>Home</a></body></html>" > /tmp/test-dulwich-site/subdir/index.html
echo "body { font-family: sans-serif; }" > /tmp/test-dulwich-site/style.css

# Run nginx with our config (modified for test path)
cat > /tmp/test-nginx.conf << 'EOF'
pid /tmp/nginx.pid;
error_log /tmp/error.log;
daemon off;

events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    access_log /tmp/access.log;
    
    # Disable all URL rewriting
    sub_filter_once off;
    
    client_body_temp_path /tmp/client_temp;
    proxy_temp_path /tmp/proxy_temp_path;
    fastcgi_temp_path /tmp/fastcgi_temp;
    uwsgi_temp_path /tmp/uwsgi_temp;
    scgi_temp_path /tmp/scgi_temp;
    
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    
    server {
        listen 8080;
        server_name _;
        root /tmp/test-dulwich-site;
        index index.html;
        port_in_redirect off;
        absolute_redirect off;
        
        location / {
            try_files $uri $uri/ =404;
        }
        
        # Ensure proper MIME types for assets
        location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg)$ {
            expires 1h;
            add_header Cache-Control "public, immutable";
        }
    }
}
EOF

echo "Starting nginx on port 8080..."
echo "Test with: curl http://localhost:8080/"
nginx -c /tmp/test-nginx.conf