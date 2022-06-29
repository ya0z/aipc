user www-data;
worker_processes auto;
pid /run/nginx.pid;

events {
	worker_connections 768;
	# multi_accept on;
}

http {

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	gzip on;

	upstream dov-bear {
		least_conn;
		%{~ for ip_port in containers ~}
		server ${ip_port};
		%{~ endfor ~}
	}

	server {
		listen 80;
		location / {
			proxy_pass http://dov-bear;
		}
	}
}
