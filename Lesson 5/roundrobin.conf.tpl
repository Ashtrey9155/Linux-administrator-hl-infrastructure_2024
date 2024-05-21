upstream backend {
    server {{terraform1}}:8081;
    server {{terraform2}}:8081;
}

server {
        listen 80;
        server_name example.com;

        location / {
                proxy_pass http://backend;
        }
}