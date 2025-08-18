#!/bin/sh

# Config
rsync -zvhruqPL /mnt/main/config/ /mnt/backup/config

# Documents
rsync -zvhruqPL /mnt/main/documents/ /mnt/backup/documents

# Game Servers
rsync -zvhruqPL /mnt/main/servers/ /mnt/backup/servers

# Photos + Immich
rsync -zvhruqPL /mnt/main/media/photos-and-videos/ /mnt/backup/media/photos-and-videos
