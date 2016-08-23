#unpack-assets

This shell script is designed to ease and speed up the unpacking of Starbound assets *(.pak files)*.

Especially so for servers, since Starbound requires you to unpack every single workshop mod to your local mods folder for them to actually load. Using this script, accomplishing that task [only requires a single command](https://github.com/HyperHamster/unpack-assets#-a--a).

###Usage

#####Default Behavior

Given no arguments, the script simply unpacks Starbound's base assets located at `Starbound/assets/packed.pak` to `Starbound/_UnpackedAssets`. If the script finds that the assets have been unpacked previously, it will delete the older version before unpacking.

Examples:
```
$ ./unpack-assets.sh
Unpacking Starbound's assets...
Done.
```
```
> unpack-assets.bat
1: Select default 64-bit system Steam library location (C:\Program Files (x86)\Steam).
2: Select default 32-bit system Steam library location (C:\Program Files\Steam).
3: Enter your own custom Steam library location.
Q: Quit.
1
Unpacking Starbound's assets...
Done.
```

This is useful for Starbound modding which requires an up-to-date unpacked version of Starbound's base assets. Especially for those developing mods for the [nightly and unstable builds of Starbound](https://github.com/HyperHamster/unpack-assets#-u--u).

#####Argumental Behavior

Given an argument, the script assumes that the argument is a Starbound Steam workshop mod ID. It then looks within Starbound's Steam workshop directory, finds that mod's assets, and unpacks them to `Starbound/mods/(mod ID)`. If the script finds that the assets have been unpacked previously, it will delete the older version before unpacking.

This is useful because unpacking a mod and learning how it works by looking at it's files is a great way to learn Starbound modding.

If given more than one argument, the script only recognizes the first, and therefore doesn't change it's behavior.

###Options & Switches

#####-A & /A

Given no arguments and the `-a` option *(.sh)* or `/a` switch *(.bat)*, the script will operate similarly to its [argumental behavior](https://github.com/HyperHamster/unpack-assets#argumental-behavior) except instead of unpacking a specific mod it will unpack *all* within Starbound's workshop directory.

Examples:
```
$ ./unpack-assets.sh -a
Unpacking 000000001's assets...
Done.
Unpacking 000000002's assets...
Done.
Unpacking 000000003's assets...
Done.
Finished unpacking 3 mod(s).
```
```
> unpack-assets.bat /a
1: Select default 64-bit system Steam library location (C:\Program Files (x86)\Steam).
2: Select default 32-bit system Steam library location (C:\Program Files\Steam).
3: Enter your own custom Steam library location.
Q: Quit.
1
Unpacking 000000001's assets...
Done.
Unpacking 000000002's assets...
Done.
Unpacking 000000003's assets...
Done.
Finished unpacking 3 mod(s).
```

This is incredibly useful for updating modded Starbound servers as they cannot load mods from Starbound's Steam workshop directory, and unpacking each mod one by one is a chore. It is very important for servers to keep their mods up-to-date as it could very likely cause clients to crash if they weren't.

##### -U & /U

Given no arguments and the `-u` option *(.sh)* or `/u` switch *(.bat)*, the script will operate similarly to it's [default behavior](https://github.com/HyperHamster/unpack-assets#default-behavior) except it will unpack the base assets from Starbound - Unstable instead.

##### -P

Given any or no arguments and the `-p` option *(.sh)*, the script will prompt the user with a list of all Steam library directories within their home directory which they must choose from by pressing the corrosponding key. After the prompt the script will continue as normal.

Example:
```
$ ./unpack-assets.sh -p 000000001
Searching for Steam library directories within your home directory...
1: /home/user/.wineprefixes/steam64/drive_c/Program Files (x86)/Steam
2: /home/user/.PlayOnLinux/wineprefix/Steam64/drive_c/Program Files (x86)/Steam
3: /home/user/.PlayOnLinux/wineprefix/Steam/drive_c/Program Files/Steam
4: /home/user/.local/share/Steam
4
Unpacking 000000001's assets...
Done.
```

This is useful in the instance when the user has a Steam library directory other than the default that they have Starbound installed to.

This behavior, although less advanced, is default in the Batch version. Therefore this option only exists in the Bash version.

##### -H & /?

Given the `-h` option *(.sh)* or `/?` switch *(.bat)*, the script will print a help screen relevant to the script version *(Bash or Batch)* and exit.

###Note on Differences Between Bash and Batch Versions

Since Batch is an old and decrepit scripting language it must prompt the user each time asking where their Steam library directory is located since no functionality exists to find it automatically and it's not in a reliably predicatable location because of the differences in Steam's default installation directory between 32-bit and 64-bit versions of Windows.

The Bash version however, will check for the existence of Steam's default installation directory *(~/.local/Share/Steam)*. If found, it will not prompt the user. If not found, it will automatically search for Steam library directories within the user's home directory, and prompt the user with a list of it's findings which the user must select from.
