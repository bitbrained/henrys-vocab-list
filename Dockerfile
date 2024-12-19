# Use an Nginx base image
FROM nginx:alpine

# Install OpenSSL for generating self-signed certificates
RUN apk add --no-cache openssl

# Generate self-signed SSL certificates
RUN mkdir -p /etc/nginx/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/certs/server.key \
    -out /etc/nginx/certs/server.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=OrgUnit/CN=localhost"

# Expose ports 80 (HTTP) and 443 (HTTPS)
EXPOSE 80 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]