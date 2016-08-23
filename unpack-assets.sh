#!/bin/bash

while getopts ":haHAuUpP" opt; do
    case $opt in
        h|H) hflag=1;;
        a|A) aflag=1;;
        u|U) uflag=1;;
        p|P) pflag=1;;
    esac
done

if [[ ! -d "$HOME/.local/share/Steam" || $pflag -eq 1 ]]; then
    echo "Default Steam Library directory not present on your system."
    echo "Searching for Steam Library directories within your home directory..."
    
    if [[ -e /tmp/unpack-assets.tmp ]]; then rm '/tmp/unpack-assets.tmp'; fi
    
    while IFS= read -r -d ''; do
        proper_dir=$(sed s_/steamapps.*__ < <(echo "$REPLY"))
        
        echo "$proper_dir" >> /tmp/unpack-assets.tmp
    done < <(find $HOME -type d -path '*/steamapps' -print0 2>/dev/null)
    
    if [[ ! -e /tmp/unpack-assets.tmp ]]; then
        echo "No Steam Libraries exist within your home directory."
        exit 1
    fi
    
    num_finds="$(wc -l < /tmp/unpack-assets.tmp)"
    
    echo "Choose the appropriate Steam library directory by pressing the corresponding key."
    cat -n '/tmp/unpack-assets.tmp' | sed -e 's/     //' -e 's/	/: /'
    
    while read -r -n 1 -s choice; do
        if [[ $choice =~ [[:digit:]] && $choice -gt 0 && $choice -le $num_finds ]]; then
            steam_library="$(sed "${choice}q;d" /tmp/unpack-assets.tmp)"
            break
        fi
        
        echo "Invalid choice, try again."
    done
    
    if [[ -e /tmp/unpack-assets.tmp ]]; then rm '/tmp/unpack-assets.tmp'; fi
else
    steam_library="$HOME/.local/share/Steam"
fi

if [[ $uflag -eq 1 ]]; then
    starbound="$steam_library/steamapps/common/Starbound - Unstable"
else
    starbound="$steam_library/steamapps/common/Starbound"
fi
starbound_workshop="$steam_library/steamapps/workshop/content/211820"
unpack="$starbound/linux/asset_unpacker"
starbound_assets="$starbound/assets/packed.pak"

unpack_starbound() {
    if [[ -e $starbound_assets ]]; then
        if [[ -d $starbound/_UnpackedAssets ]]; then
            echo "Removing Starbound's old unpacked assets..."
            rm -r $starbound/_UnpackedAssets
            echo "Done."
        fi
        
        echo "Unpacking Starbound's assets..."
        $unpack $starbound_assets $starbound/_UnpackedAssets >/dev/null 2>&1
        echo "Done."
        exit 0
    fi
    
    echo "Starbound's assets not found."
    exit 1
}

unpack_workshop() {
    if [[ -d $starbound_workshop/$1 ]]; then
        if [[ -d $starbound/mods/$1 ]]; then
            echo "Removing $1's old unpacked assets..."
            rm -r $starbound/mods/$1
            echo "Done."
        fi
        
        echo "Unpacking $1's assets..."
        $unpack $starbound_workshop/$1/contents.pak $starbound/mods/$1 >/dev/null 2>&1
        echo "Done."
    else
        echo "$1's assets not found."
        exit 1
    fi
}

unpack_workshop_all() {
    num_mods=0
    for id in $(ls -1 $starbound_workshop); do
        ((num_mods++))
        
        unpack_workshop $id
    done
    
    if [[ $num_mods -eq 0 ]]; then
        echo "No mods found."
        echo "Please install some workshop mods before trying to unpack them."
        exit 1
    fi
    
    echo "Finished unpacking $num_mods mod(s)."
    exit 0
}

print_help() {
    echo "Usage: unpack-assets.sh [options] [workshop_id]"
    echo
    echo "Unpacks Starbound assets."
    echo
    echo "Options:"
    echo " -h  Print this help screen and exit."
    echo " -a  Unpack all Starbound Steam workshop assets."
    echo " -u  Unpack Starbound - Unstable's base assets instead."
    echo " -p  Prompt for Steam library directory location."
    echo
    echo "Given no arguments, unpacks Starbound's base assets."
    echo "Given an argument that is an installed Starbound Steam workshop mod ID, unpacks its assets."
    exit 0
}

if [[ $hflag -eq 1 ]]; then print_help; fi
if [[ $# -eq 0 || $uflag -eq 1 ]]; then unpack_starbound; fi
if [[ $aflag -eq 1 ]]; then unpack_workshop_all; fi
unpack_workshop $1
exit 0
