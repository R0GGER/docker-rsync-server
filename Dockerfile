FROM alpine:latest

# Installeer benodigde pakketten
RUN apk add --no-cache rsync openssh

# Maak de benodigde directories
RUN mkdir -p /data
RUN mkdir -p /root/.ssh

# Kopieer de rsync configuratie
COPY rsyncd.conf /etc/rsyncd.conf

# Kopieer het entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose de standaard rsync poort
EXPOSE 873

# Gebruik entrypoint script
ENTRYPOINT ["/entrypoint.sh"] 