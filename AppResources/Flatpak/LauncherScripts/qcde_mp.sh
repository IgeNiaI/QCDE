#!/bin/sh

# Insert preconfigured settings files on first run
if [ ! -f ~/.config/zandronum/zandronum.ini ]; then
    mkdir -p ~/.config/zandronum/
    cp /app/share/games/qcde/default_configs/q-zandronum/zandronum.ini ~/.config/zandronum/zandronum.ini
    /app/bin/q-zandronum -nosound -norun
fi

if [ ! -f $XDG_CONFIG_HOME/doomseeker/doomseeker.ini ]; then
    mkdir -p $XDG_CONFIG_HOME/doomseeker/
    cp /app/share/games/qcde/default_configs/doomseeker/doomseeker.ini $XDG_CONFIG_HOME/doomseeker/doomseeker.ini
    cp /app/share/games/qcde/default_configs/doomseeker/tmpserver.ini $XDG_CONFIG_HOME/doomseeker/tmpserver.ini
fi

/app/bin/doomseeker
