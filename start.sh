#!/bin/sh

#create folders on config
mkdir -p /srv/madsonic/config/playlists/import
mkdir -p /srv/madsonic/config/playlists/export
mkdir -p /srv/madsonic/config/playlists/backup
mkdir -p /srv/madsonic/data/transcode

#copy transcode to config directory - transcode directory is subdir of path set from --home flag, do not alter
cp /srv/madsonic/config/transcode_lib/transcode/* /srv/madsonic/data/transcode/

# Force Madsonic to run in foreground
sed -i 's|-jar madsonic-booter.jar > \${LOG} 2>\&1 \&|-jar /srv/madsonic/app/madsonic-booter.jar > \${LOG} 2>\&1|g' /srv/madsonic/app/madsonic.sh


/srv/madsonic/app/madsonic.sh \
  --home=/srv/madsonic/config \
  --context-path=/ \
  --default-music-folder=/mnt/music \
  --default-podcast-folder=/mnt/music \
  --default-upload-folder=/mnt/downloads \
  --default-transcode-folder=/srv/madsonic/data/transcode \
  --default-playlist-import-folder=/srv/madsonic/config/playlists/import \
  --default-playlist-export-folder=/srv/madsonic/config/playlists/export \
  --default-playlist-backup-folder=/srv/madsonic/config/playlists/backup \
  --port=8080