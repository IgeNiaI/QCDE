==================================================================================
Advanced engine needed  : Q-Zandronum 1.4
Primary purpose         : Single & Multiplayer
==================================================================================
Title                   : QC: Doom Edition
Filename                : QCDEv3.0.pk3
Release date            : May ##th 2024
Author                  : DBThanatos, Michaelis, geNia
Email Address           : DBThanatos@hotmail.com, Michael.is.D4T@gmail.com, geniann93@gmail.com
Other Files By Author   : *DBThanatos: "Quake4 Lightning Fast Mod Doom Edition",
                            "Doomstorm", "AEons of Death", "Super Doom 3 Take II",
                            "The Ultimate Torment & Torture: Take II", "Dream of 
                            magic 2.0", "D4D (DOOM(4) for Doom)",
                            "D4T (Death Foretold)"
                          *Michaelis: "ZBlood+", "AEons of Death", 
                            "D4D (DOOM(4) for Doom)", "D4T (Death Foretold)"
Misc. Author Info       : Stuff.

Description             : A gameplay mod bringing Quake Champions weapons and many
                          different player classes (Champions) each with unique
                          abilities, passive and actives, to be used in single
                          player or multiplayer; along with monsters from Quake 1, 
                          Quake 2 and Quake 4, and Doom 2016 for you to chose 
                          what theme of monsters you want, or even mix them up.
                          The mod was designed from the ground up to be played
                          in single player, cooperative, and many types of PvP
                          like Deathmatch (Free for all), Team Deathmach, Duel,
                          Capture the Flag, Last Man Standing, "Clan Arena".
                          See the "QCDE Manual.pdf" for more information.

Additional Credits to   : See credits section
================================================================================

* What is included *

New levels              : 69 QCDE exclusive maps in "QCDEmaps3.0.pk3"
Sounds                  : Yes
Music                   : Yes, in QCDEmus3.0.pk3
Graphics                : Yes
Dehacked/BEX Patch      : No
Demos                   : No
Bots                    : Yes
Decorate                : Yes
ACS                     : Yes
HUD                     : Yes
CVARINFO                : Yes
Other                   : A plethora of ZDoom specific lumps
Other files required    : Engine and Iwad of doom2 or similar


* Play Information *

Game                    : Doom 2 (compatible with Doom)
Map #                   : Titlemap + 69 additional maps (separate downloads)
Single Player           : Yes
Cooperative 2-4 Player  : Designed for
Deathmatch 2-4 Player   : Designed for
Other game styles       : CTF, Duel, LMS, TLMS, IG, BS
Difficulty Settings     : Normal, min monsters
                          Normal, avg monsters
                          Normal, max monsters
                          Hard, min monsters
                          Hard, avg monsters
                          Hard, max monsters
                          Deathbound
                          Mobile, min monsters
                          Mobile, avg monsters
                          Mobile, max monsters


===============================================================================

* Construction *

Base                    : New from scratch 
Build Time              : Around 7 months for first release in February 2018,
                          and it keeps going to date
Editor(s) used          : Slade, Programmer's notepad, GIMP, Audacity,
                          Notepad++, Paint.net, FL Studio, GitKraken, SourceTree
                          7z, Terminus, Discord, Gzdoom Builder
Known Bugs              : See the Bugs section below
                          
May Not Run With        : Anything older than Q-Zandronum 1.4
Tested With             : Q-Zandronum 1.4

===============================================================================

* Bugs *

This mod has several unfixable "bugs", due to technical limitations.

- Abilities with "use counter" (Lucienne, Keel, Freeman) somtimes will show
  their maxium capacity minus 1. E.g. Freeman has 3 charges, but sometimes he'll
  show his ability fully ready but with 2 charges; this is visual only.
  Functionality-wise it'll still allow his 3 charges. Same for the other champs
  that have this multi-use abilities.

- Weapons will play hit beep when you hit friendly TDM players. No way around that.

- Inquisitor's shield will block both friendly and enemy attacks in TDM and FFA. 
  This is an unfixable issue. Shield should only be used in Coop, or as a completely 
  defensive tactic in DM.

- Quad damage: When using rapid fire weapon (MG, HMG, NG, SNG, LG) and you pick the
  quad damage while firing, the quad sound will not play, until you stop firing and
  start again. Same will happen when quad wears off but you're still firing: the quad
  sound will continue playing despite the powerup having worn off. This does NOT affect
  the damage increase. Damage will be increased for as long as you have the powerup 
  indicator in the HUD, regardless of the sound.

- "Active ability ready" sound might not play sometimes. There's only so many channels
  per actor in game, and this sound sometimes gets overridden by other things.

- In cooperative games, if you try to change class without dying when switching levels,
  on the next map the player state would be messed up: icons, portraits, abilities,
  stacks, will be displayed and applied wrong. To prevent this, if the game detects
  a messed up state (mixed stats and abilities) it will immediately kill the player
  to reset the class and apply the new one. In Survival, where the number of lives
  is limited, this death does not affect it.

- Bots will still be able to "see" and fire at a ghost-walking Nyx. Engine limitations.

- Bots will sometimes stand still or keep bumping on a wall. Engine limitations.

- Lo Wang and Zeked's sword animation drawing on top of HUD and weapon is **not** a bug. 
  It's the best compromise between the ability being responsive and not displaying
  anything at all.

- In the map "Molten Falls" sometimes the "lava falling" animation will stop. We added
  some measure to try to minimize this bug, but it will still happen after the map has been
  played for a while. Engine bug.

============================================================================================


* Credits *

id Software 
"Quake Champions" Team  : Game concept, core mechanics: champions/abilities, HUD elements,
                          weapon & other SFX, UI sounds, character designs (Nyx, Ranger, Keel,
                          Doomslayer, Blazkowicz), character sounds (Ranger, Doomslayer, Galen,
                          Nyx, Terminator, Inquisitor, Keel, Sorgaul, Blazkowicz, Menelkir)



* QCDE Team *


geNia                   : Lead Developer, Q-Zandronum Developer

DBThanatos              : Developer, former Lead Designer

Michaelis               : Developer, former Lead Programmer

Captain J               : Sprites for the weapons in 1.x. Base sprites for armor, health,
                          ammo pickups.

Franco Tieppo           : Spriter for all weapons in v2.0
                          Doom metallic logo. Sprites for "Totem", "Inquisitor Shield",
                          D4T's computer map, D4T's Radsuit, D4T's edited backpack, revamped
                          sprites for ammo, health, armor, powerups (quad & protection).
                          Revamping of HUD elements, radar graphics, edit to face for "Grayson"
                          champion. Redrawn sprites for Painkiller weapon, Demonic HUD,
                          Soul Pickup sprites, Redrawn/retouched "Black tarot" card icons and
                          overhead sprites, Elder Soul pickup sprites, menu graphics for v3.0,
                          redrawn weapon skin sprites and a lot more. 
                          Seriously, I ought to make a file to list all of Franco's contributions
                          But most importantly: The **WET FLOOR SIGN**

Pixo                    : Orbb sprites, console font graphics, various sound edits,
                          voxel models for UT weapons and some pickups,
                          original Quake 1, 2, 3, 4 and QW: ET weapon skin sprites

Michael Markie          : QCDE Original Soundtrack, production of voice effects of Durandal,
                          sounds for BFG10k, sounds for Duke's Freeze Gun, other misc sounds.





* QCDE Maps *


DBThanatos              : "Blood Covenant", "Blood Run", "Phrantic", "Furious Heights",
                          "Toxicity", "Monsoon", "Cure", "House of Decay", "Sinister", "Lockbox", 
                          "Corrupted Station", "Sarnath", "Lh'owon of Ice and Fire", "Vale of Pnath",
                          "Monsoon", "Lh'owoken", "Molten Falls", "Gibel Complex", "Excavation",
						  "Silence", "The Edge", "Fusillade", "Battleforged", "Helix"

RoosTer                 : "Aerowalk", "Vertical Vengeance", "Fatal Instinct", "Morpheus",
                          "Lost World", "Stubborn", "Phobos Campgrounds", "Deck", "Almost Lost",
						  "Quarantine", "Temple of Retribution",
                          "Outpost", "Hangar", "Cathedral", "Astroid Garden"

geNia                   : "Chastity Belt", "Arcane Temple", "Rankin", "QWER", "Deep Embrace", "Deck 17",
                          "Brought 2 Doom", "Mythic", "Erase", "Unreal Place", "Achilles", "Menelkir's Domain"

Ivan Dobrovski          : "Fortress in the Void", "Sinister", "Battleforged", "Sight"

MrEnchanter             : "Bitterman's Revenge"

Ivory Duke              : "Elder", "Delirium"

TheSwampyLad            : "Temple of the Blood Serpants", "Exile"

Pixo                    : "Crash Course", "Hektik"

Mr.Rocket               : "The Bad Place", "The Dark Zone", "Claustrophobopolis", "The Longest Yard"

Dech                    : "The Struggle", "CTF Run", "Fatal Error"

KillerKouhai            : "Zenith"

kultasakaali            : "Hell's Gate"




* Special Credits *

George Exley            : Voice actor for Sarge, VorMatur, Painkiller and QCDE Announcer, sound edits for UT announcer

David M Neyland         : Voice actor for Durandal

Gianni Matragrano       : Voice actor for Intruder, voice for UT announcer

YukiHerz                : Ranger and Bitterman's sprite sets

Abysswalker             : Doomslayer sprites

LegendBourne            : Drawings for HD portraits

DrPyspy                 : Model posing/texturing/ripping of Sarge, Hunter, 
                          Major and Painkiller (PK's face edited by DBT)

Simploo                 : Model posing/texturing/ripping of Postal Dude

Ivory Duke              : Description/Lore for all champions in the Manual up to 2.7.
                          Base coding for "Terminator"/"Elder Soul" gamemode
                          Base coding for "Freezetag" gamemode
                          voxel models, code assistance, QCDEmaps resource repacking
                          Original Medals and Item Respawn timers addons

Revenatn                : Original Half-Life weapon skins, ripping Serious Sam model

DeXiaZ                  : Base sprites for Nyx

Nash Muhandes           : The Intruder spritesheet

SPS-Barbarossa          : QC:DE Manual design & layout up to v2.7

HeliosDrive             : QC:DE Manual v3.0

katherinecode           : v3.0 model posing/texturing/ripping of BJ Blazkowicz

kultasakaali            : Mapping, testing, addon updating

DoomJoshuaBoy           : OpenAL implementation

TDRR                    : Universal Bump Mapping addon, TDBots addon

N4h                     : Quake 1 weapon skins, various sprite adjustments

Hvellor                 : Remaining original Half-Life and Serious Sam weapon skins, various sound adjustments

anvi                    : Various sound adjustments

Revenatn, Dech,
Excedentia, Ivory Duke,
JD-513, Elfriede,
Foxtongue, Hurykles,
QuakeDoomNukem &
Anonymous               : Translation of QCDE startup blurb



* QCDE Alpha Testers *


Jckfrbn                 : Alpha Tester

Ragequit                : Alpha Tester

A_D_M_E_R_A_L           : Alpha Tester

DoomKrakken             : Aditional Testing, Sorgaul's name



* QCDE Beta Testers *


B R Y I N A             : Beta Tester

Barbarossa              : Beta Tester

ElRetardo               : Beta Tester

Ivory Duke              : Beta Tester

Matsilagi               : Beta Tester

The Abysswalker         : Beta Tester

kultasakaali            : v3.0 Beta Tester

klaufir                 : v3.0 Beta Tester

redgrey                 : v3.0 Beta Tester

Pixo                    : v3.0 Beta Tester

prod1G                  : v3.0 Beta Tester

PopKorn                 : v3.0 Beta Tester

anvi                    : v3.0 Beta Tester

ako                     : v3.0 Beta Tester

TDRR                    : v3.0 Beta Tester



* Additional Credits *

Mechadon                : Intermission text graphics

Xaser                   : Assistance with Titlemap. 
                          Base sprites for card and skull keys.         

Vader                   : Sprites of "Terminator"

Jimmy                   : Pre-3.0 Big and smallfont

Zanieon                 : Bullet tracer model & texture, inspiration for Awoken map,
                          Jumppad neon side lights on Silence

KeksDose                : Smoke sprites

TwelveEyes              : B.O.B. normal sprites

Major Cooke             : TF2 blood rip

Jekyll_Grim_Payne       : Making the glowing/warping liquid flats in ANIMDEFS

A_D_M_E_R_A_L           : Providing me with the flats mentioned above

Randy Heit              : Zdoom

Graf Zahl               : Gzdoom

Torr Samaho             : Zandronum

Beloko Games            : Gzdoom port to Android

id Software             : Quake 1, 2, 3, 4, Quake Live, Quake Champions, Doom, Wolfenstein
                          sprites/graphics and sounds

Raven Software          : Hexen/Heretic sprites and sounds, sprites used for "Keel"
                          & "Grayson" champions

Monolith                : Blood sprites and sounds

Rogue Entretainment     : Strife sprites for "Inquisitor"

Accolade                : Sprites used for "Sorgaul", "Eradicator", "Vor Matur" and "Eleena"

3D Realms
Sunstorm Interactive    : Duke Nukem 3D sprites and sounds

Bungie                  : Marathon sprites for Durandal and BOBs
                          Marathon 2 & Marathon Infinity textures

Decay & Razgriz         : Original AeonDM and NeonDM map packs

Hazel Whorley           : Skybox used for "Sinister" map

Cybermind               : Original Radar code

Endless123              : Base radar code, further edited by Michaelis

IMX                     : Base for pre-3.0 BJ Blazkowicz

GAA1992                 : Base for pre-3.0 BJ Blazkowicz

D3athStalker            : Main spritesheet used for pre-3.0 BJ Blazkowicz

Blade of Agony          : Head for pre-3.0 BJ Blazkowicz, could not find specifics in their Readme

Ola Bjorling,
Jimmy & Cage            : "Enlightening Small" font

NMN                     : NMN Corp. Vol 1 Texture Pack

Gothic Team             : Gothic Texture Pack

Spooky                  : Assistance to extract Marathon's textures

zrrion the insect       : Ripping "Chasm The Rift" textures

Action Forms Ltd.       : Chasm The Rift textures

Ceeb                    : Ripping Adrenix, Blood, Quake, Quake 2, Half Life & System Shock 2 Textures

Killerkouhai            : Sky textures for The Edge and Silence

Kerrek                  : MIDI version of HL's "Diabolical Adrenaline Guitar"

PopKorn                 : Early v3.0 Terror Billy sprites for BJ Blazkowicz, v3.0 manual update

Mr.Rocket               : Eye model on QCDE22 (Sarnath)

Holy Keyboarder         : Deep Embrace map mockup in Minecraft

prod1G                  : Layout update for QCDL02 (Aerowalk)

Dzierzan                : Shadow Warrior high quality sound effects

ako                     : Assistance with Unreal Tournament music addon

Craneo                  : Doom 4 Tech Mancubus sprites

Digital Dialect         : Adrenix Textures

Monolith
Sunstorm Interactive    : Blood Textures

Looking Glass 
Irrational Games        : System Shock 2 Textures

Valve & Gearbox         : Half Life Textures

New Blood Interactive
& David Szymanski       : Dusk & "The Intruder" concepts

OSJClatchford:          : "Quake: descent into heresy" animated heretic ep3 sky

Epic Games 
& Digital Extremes      : Unreal Tournament textures and sounds

Mojang                  : Minecraft textures

The Creators of:
"Rogue" Mod
"Scourge of Armagon"
as well as:
Ives "HFX" Allaire
Frank "POX" 
Ives "HFX" Allaire
Francois "OgroX" Delmotte 
Tormentor667            : "Too much brown" Texture pack

Cage                    : Textures in Heatwave

Mechadon                : Sky texture in Blood Covenant

The following:
JadedLexi,
Captain Toenail,
Enjay, Esselfortium,
Evil Space Tomato,
Gez, Neoworm,
Nightmare, Pun1sh3r,
Icytux, Rottking,
Tormentor667, Vader,
Xaser                   : "Baker's Legacy" Texture pack


My sincerest apologies if Im forgetting someone. Shall be corrected ASAP if that's
the case. -DBT



* Exit Messages Credits * 


AlphaEnt(Blorc)         : Exit messages

scaryred24              : Exit messages

i'm a fucking corn      : Exit messages

Ragequit                : Exit messages

Captain J               : Exit messages

Cryomundis              : Exit messages

Nems                    : Exit messages

Redead-ITA              : Exit messages




============================================================================================
* Copyright / Permissions *

Authors MAY NOT use the contents of this file as a base for modification. Reuse is OK.  
Permissions have been obtained from original authors for any of their resources modified 
or included in  this file.

You MAY distribute this file, provided you include this text file, with no modifications.
You may distribute this file in any electronic format (BBS, Diskette, CD, DVD, stick drives,
base64-encoded notepads, etc.) as long as you include this file intact.  I have received 
permission from the original authors of any modified or included content in this file to 
allow further distribution.

------------------------------------------------------------------------------------------
Contact Us:

If you have questions or suggestions, you can find us in the following links:

Official Discord: https://discord.gg/u4ptaMk
Official Download site: https://qzandronum.com/qcde/
Official ModDB: http://www.moddb.com/mods/quake-champions-doom-edition
Doomworld Thread: https://www.doomworld.com/forum/topic/99079-qc-doom-edition/
Zdoom Thread: https://forum.zdoom.org/viewtopic.php?f=43&t=57716
Zandronum Thread: https://zandronum.com/forum/viewtopic.php?f=58&t=8682
