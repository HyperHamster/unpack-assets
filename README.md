#unpack-assets

This shell script is designed to ease and speed up the unpacking of Starbound assets (.pak files).

Especially so for servers, since Starbound requires you to unpack every workshop mod to your local mods folder for them to actually load. Using this script, accomplishing that task only requires a single command.

**WIP BELOW**

###Default Behavior

Given no arguments and no options (Bash) or switches (Batch), the script simply unpacks Starbound's base assets located at `Starbound/assets/packed.pak` to `Starbound/_UnpackedAssets`.

This is useful for Starbound modding which requires an up-to-date unpacked version of Starbound's base assets. Especially for those developing mods for the nightly or unstable builds of Starbound.

###Single Argument Behavior

Given a single argument and no options (Bash) or switches (Batch), the script assumes that the argument is a Starbound Steam Workshop ID. It looks within the Starbound's Steam workshop directory, finds that mod's `.pak` file and unpacks it to `Starbound/mods/(Mod ID)` 

This is useful because unpacking a mod and learning how it works by looking at it's files is a great way to learn Starbound modding.

###Multiple Argument Behavior

Given multiple arguments and no options (Bash) or switches (Batch), the script only recognizes the first argument and therefore functions the same as if there were only a single argument (see above).

###A Option/Switch Behavior

Given no arguments and the `-a` option (Bash) or `/a` switch (Batch), the script will unpack every single installed workshop mod to `Starbound/mods/(Mod ID)`.

Example:
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

This is incredibly useful for updating modded Starbound servers as they cannot load mods from Starbound's Steam workshop directory. This is very important because if servers do not keep their mods up-to-date, it could very likely cause clients to crash.

###H/? Option/Switch Behavior

###Note on Differences Between Bash and Batch Versions

Since Batch is an old and decrepid scripting language it must prompt the user each time asking where their Steam library directory is located since no functionality exists to find it automatically and it's not in a reliably predicatable location because of the differences in Steam's default installation directory between 32-bit and 64-bit versions of Windows. Plus the user could be using an alternative Steam library directory of their own creation to store Starbound's files.

The Bash version will check for the existance of Steam's default installation directory. If it's not found it will automatically search for Steam library directories within the user's home directory, displaying a list of it's findings for the user to select from.
