# The following script should be used to uninstall BSPWM and all of his dependencies.

# Defining colors to make a colorful output in the terminal
redColor="\e[1;31m   \b\e   "
resetColor="\e[1;0m   \b\e   "
greenColor="\e\b[1;32m   \b\e   "
yellowColor="\e[1;33m   \b\e   "
blueColor="\e[1;34m   \b\e   "

# global variables
dnull=&>/dev/null
username=$HOME

echo -e "${yellowColor}\The following script are going to uninstall dotfiles and all of his dependencies "
echo -e "Components to remove : ${resetColor}"
sleep 2
echo -e "${yellowColor}\
[-] bspwm
[-] sxhkd
[-] nitrogen
[-] rofi
[-] polybar
[-] configuration files ${resetColor}"
sleep 2

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
        $3
    else
        $4
    fi
}


foldersToDelete=("bspwm" "sxhkd" "nitrogen" "rofi" "polybar")

function deleteItems {
    for element in "$foldersToDelete[@]"
    do
    if  existsFile -d "${element} >/dev/null" 
        then
        # Deleting config files/folders from .config folder
        rm -r $username/.config/$element
        else
        echo -e "$redColor\The item: ${element} already has been deleted or doesn't exists anymore $resetColor"
    fi
    done
    echo -e "${greenColor}\The items has been deleted sucessfully ${resetColor}"
    sleep 2
}
# An array with the dependencies to remove
dependencies=("bspwm" "sxhkd" "rofi" "nitrogen" "git" "wget" "polybar" "wmname")
function removeDepedencies {
    for deps in "${dependencies[@]}"
    do
      sudo apt remove $deps -y >/dev/null
    done
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
# Calling the methods
deleteItems
removeDepedencies
blankInit
echo -e "${yellowColor}\Uninstall was sucessfully completed, recommended to reboot your system ${colorReset}"
sleep 2






