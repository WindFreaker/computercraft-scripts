# Personal ComputerCraft Scripts

This repo is the loose collection of the scripts that I have made for Minecraft's [ComputerCraft][computercraft-link] mod. 
The only purpose of this repo is so that I can quickly download and reuse my past work if I ever play again.
My hope by leaving this repo public is that it can prove useful to anyone who stumbles upon my work.
To download any script, use the `wget` command.

Scripts for the ingame turtle are located in the `Turtle` folder. Right now they include:
- [furnace.lua](./Turtle/furnace.lua) which... appears to be empty currently, guess I didn't finish that one
- [safety.lua](./Turtle/safety.lua) which provides a safer dig method for avoiding dangerous blocks
- [stripmine.lua](./Turtle/stripmine.lua) which safely creates a stripmine to a specified length while mining all the ores it sees in the process

Scripts for the ingame pocket computer are located in the `Pocket Computer` folder. Right now they include:
- [alerts.lua](./Pocket%20Computer/alerts.lua) which interacts with other scripts to... well alert you

This repo also includes a bunch of generic library scripts which work on all computers and are necessary components for my other scripts.
They are located in the `General` folder and currently include the following:
- [data.lua](./General/data.lua) which can store data for a script in the computers settings function, effectively behaving as non-volatile memory
- [wireless.lua](./General/wireless.lua) which acts as a wrapper for wireless broadcasts to standardize how my scripts send and recieve such messages

[computercraft-link]: https://computercraft.cc/
