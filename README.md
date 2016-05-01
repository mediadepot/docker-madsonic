# Requirements


# Environmental
The following environmental variables must be populated, when running container 

- PUID
- PGID

# Ports
The following ports must be mapped, when running container 

 - 8080 #webui listen 
 
# Volumes
The following volumes must be mapped, when running container 

- /srv/madsonic/config
- /srv/madsonic/data
- /mnt/storage/[Music]:/mnt/music
- /mnt/downloads/[Music]:/mnt/downloads
- /mnt/blackhole/[Music]:/mnt/blackhole
