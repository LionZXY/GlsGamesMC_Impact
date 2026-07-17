#!/bin/sh

sed -i "s/SECRET_WORLD_SEED/$SECRET_WORLD_SEED/g" ./settings/worlds.yml

java -server -XX:+UseG1GC -XX:+UseStringDeduplication -Xms${MC_RAM} -Xmx${MC_RAM} -jar ultramine_core-1.7.10-server-latest.jar nogui
