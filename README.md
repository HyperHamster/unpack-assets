#unpack-assets

This shell script is designed to ease and speed up the unpacking of Starbound assets (.pak files).

Especially so for servers, since Starbound requires you to unpack every workshop mod to your local mods folder for them to actually load. Using this script, accomplishing that task only requires a single command.

###Usage

#####Default Behavior

Given no arguments and no options/switches, the script simply unpacks Starbound's base assets located at `Starbound/assets/packed.pak` to `Starbound/_UnpackedAssets`.

Examples:
```
$ ./unpack-assets.sh
Unpacking Starbound's assets...
Done.
```
```
> unpack-assets.bat
Unpacking Starbound's assets...
Done.
```

This is useful for Starbound modding which requires an up-to-date unpacked version of Starbound's base assets. Especially for those developing mods for the nightly or unstable builds of Starbound.

#####Single Argument Behavior

Given a single argument and no options/switches, the script assumes that the argument is a Starbound Steam Workshop ID. It looks within the Starbound's Steam workshop directory, finds that mod's `.pak` file and unpacks it to `Starbound/mods/(Mod ID)` 

This is useful because unpacking a mod and learning how it works by looking at it's files is a great way to learn Starbound modding.

#####Multiple Argument Behavior

Given multiple arguments and no options/switches, the script only recognizes the first argument and therefore functions the same as if there were only a single argument (see above).

###Options & Switches

#####-A & /A

Given no arguments and the `-a` option (.sh) or `/a` switch (.bat), the script will unpack every single installed workshop mod to `Starbound/mods/(Mod ID)`.

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

This is incredibly useful for updating modded Starbound servers as they cannot load mods from Starbound's Steam workshop directory. It is very important for servers to keep their mods up-to-date as it could very likely cause clients to crash if they weren't.

##### -H & /?

Given no arguments and the `-h` option (.sh) or `/?` switch (.bat), the script will print a help screen relevant to the script version (Bash or Batch).

###Note on Differences Between Bash and Batch Versions

Since Batch is an old and decrepid scripting language it must prompt the user each time asking where their Steam library directory is located since no functionality exists to find it automatically and it's not in a reliably predicatable location because of the differences in Steam's default installation directory between 32-bit and 64-bit versions of Windows.

The Bash version however, will check for the existence of Steam's default installation directory (~/.local/Share/Steam). If found, it will not prompt the user. If not found, it will automatically search for Steam library directories within the user's home directory, and prompt the user with a list of it's findings which the user must select from.
