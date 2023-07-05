# The following script should be used to uninstall BSPWM and all of his dependencies.

# Defining colors to make a colorful output in the terminal
redColor="\e[1;31m   \b\e   "
resetColor="\e[1;0m   \b\e   "
greenColor="\e\b[1;32m   \b\e   "
yellowColor="\e[1;33m   \b\e   "
blueColor="\e[1;34m   \b\e   "

# global variables
dnull= &>/dev/null
username=$HOME

echo -e "${yellowColor}\The following script are going to uninstall dotfiles and all of his dependencies "
echo -e "Components to remove : ${resetColor}"

echo -e "${greenColor}
\- bspwm (Window Manager)
- sxhkd
- nitrogen
- rofi
- polybar
- mpd
- configuration files ${resetColor}"
sleep 2
# Global bands to change the status of existing file
bandExist=false

# Function to verify if a folder or file exist
# as first argument is gonna receive the operation to do
# -f  => Will check just files
# -d  => Is gonna look for directories/folders
# as second parameter is going to receive the file/folder to search
# usage example : -f "uninstall.sh"
# or : -d "myFolder"
function existsFile {
    if test $1 "$2"
    then
    return 0
    else
    return 1
    fi
}


foldersToDelete=("bspwm/" "sxhkd/" "nitrogen/" "mpd/" "ncmpcpp/" "rofi/" "polybar/" "cava/")

function deleteItems {
    for element in "$foldersToDelete[@]"
    do
    if  existsFile -d "${element} $dnull" 
        then
        # Deleting config files
        rm -r $username/.config/$element
        else
        echo -e "$redColor\The item: ${element} already has been deleted or doesn't exists anymore $resetColor"
    fi
    # # Also uninstalling dependencie
    # sudo apt remove $element -y
    done
    echo -e "${greenColor}\The items has been deleted sucessfully ${resetColor}"
    sleep 2
}

function blankInit {
    if  existsFile -f "$username/.xinitrc"
    then
    echo "" >> .xinitrc
    sleep 1
    else
    echo -e "$yellowColor\The file was already removed or doesn't exist anymore$resetColor"
    sleep 1
    fi
}

deleteItems
sudo apt remove sxhkd -y
blankInit
echo -e "${yellowColor}\Uninstall was sucessfully completed, recommended to reboot your system ${colorReset}"
sleep 2






