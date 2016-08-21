#unpack-assets

This shell script is designed to ease and speed up the unpacking of Starbound assets.

Especially so for servers, since Starbound requires you to unpack every workshop mod to your local mods folder for them to actually load. Using this script, accomplishing that task only requires a single command to accomplish.

**WIP BELOW**

##Default Behavior

Given no arguments and no options (Bash) or switches (Batch), the script simply unpacks Starbound's base assets located at `Starbound/assets/packed.pak` to `Starbound/_UnpackedAssets`.

This is useful for Starbound modding which requires an up-to-date unpacked version of Starbound's base assets. Especially for those developing mods for the nightly or unstable builds of Starbound.

##Single Argument Behavior

Given a single argument and no options (Bash) or switches (Batch), the script assumes that the argument is a Starbound Steam Workshop ID. It looks within the Steam Workshop directory for Starbound and finds the corresponding 

##Multiple Argument Behavior

Only recognizes the first argument and therefore functions the same as if there were only a single argument.

###Differences Between Bash and Batch Versions

Since Batch is an old and decrepid scripting language it must prompt the user each time asking where their Steam library directory is located since no functionality exists to find it automatically and it's not in a reliably predicatable location because of the differences in Steam's installation directory between 32-bit and 64-bit versions of Windows. Plus the user could be using an alternative Steam library directory of their own creation to store Starbound's files.

The Bash version will check for the existance of Steam's default directory but if it's not found it will automatically search 
