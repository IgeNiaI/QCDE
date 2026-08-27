#!/bin/sh

# Insert preconfigured settings file on first run
if [ ! -f ~/.config/zandronum/zandronum.ini ]; then
    mkdir -p ~/.config/zandronum/
    cp /app/share/games/qcde/default_configs/q-zandronum/zandronum.ini ~/.config/zandronum/zandronum.ini
    /app/bin/q-zandronum -nosound -norun
fi

/app/bin/q-zandronum -iwad freedoom2.wad -file QCDE_Launcher.pk3
