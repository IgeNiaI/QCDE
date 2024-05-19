#!/bin/sh
zt-bcc BCS/TDBots.bcs ../ACS/TDBots.o
m4 DECOM4.dec > ../DECORATE.tdb
cd BotC
./botc tdbot.botc ../../tdbot
cd ../..
cp tdbot crashbot.lump
cp tdbot dfultbot.lump
cp tdbot fatbot.lump
cp tdbot humanbot.lump
cp tdbot sausgbot.lump
