#!/bin/sh

# Maak de gebruiker aan met environment variabelen
adduser -D ${RSYNC_USER}
echo "${RSYNC_USER}:${RSYNC_PASSWORD}" | chpasswd

# Maak het secrets bestand aan
echo "${RSYNC_USER}:${RSYNC_PASSWORD}" > /etc/rsyncd.secrets
chmod 600 /etc/rsyncd.secrets

# Update de rsync configuratie met de juiste gebruikersnaam
sed -i "s/auth users = rsyncuser/auth users = ${RSYNC_USER}/" /etc/rsyncd.conf

# Zet de juiste rechten
chown -R ${RSYNC_USER}:${RSYNC_USER} /data

# Start rsync daemon
exec rsync --daemon --no-detach --config /etc/rsyncd.conf 