# The following script should be used to uninstall BSPWM and all of his dependencies.

# Defining colors to make a colorful output in the terminal
redColor="\e[1;31m   \b\e   "
resetColor="\e[1;0m   \b\e   "
greenColor="\e\b[1;32m   \b\e   "
yellowColor="\e[1;33m   \b\e   "
blueColor="\e[1;34m   \b\e   "

# Variables to make easier handle paths
configPath=$HOME/.config/ # Path where configs are gonna put
fontPath=/usr/share/fonts # Path to install the downloaded fonts
pathImages=$HOME/.draggedImages # Path to save the initial image on bspwm
switchHome="cd $HOME" # switch to home user path
bspwmPath="cd $HOME/.config/bspwm/" # goes into bspwm path folder
sxhkdPath="cd $HOME/.config/sxhkd/" # goes into sxhkd path folder
binariesPath="/usr/bin/" # goes to binaries folder, where usually packages are allotated

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

# find a file or folder and do something pending the result.
function existsItem {
    if test $1 $2
    then
        $3
    else
        $4
    fi
}

deps=("bspwm" "sxhkd" "rofi" "polybar")
function deleteBinaries {
    echo "$yellowColor\Deleting dependencies. This may take time $resetColor"
    cd $binariesPath
    for dl in ${deps[@]}
    do
         existsItem "-f" "$dl" "`sudo pacman -r $dl --noconfirm`" "`echo "$redColor\ $dl not found $resetColor"`"
         sleep 1
    done
} 

function deleteConfigurations {
    cd $configPath
    for config in "$deps[@]"
    do
        existsItem "-d" $config "`rm -r $config && echo "Deleting $config configurations"`" "`echo "$config configurations was not found"`"
        sleep 1
    done
    echo -e "$greenColor\Items deleted$resetColor"
}


# Calling the methods
deleteBinaries
deleteConfigurations
# deleting the .xinitrc file
$switchHome
existsItem "-f" ".xinitrc" "`rm .xinitrc`" "`echo &>/dev/null`"
echo -e "${yellowColor}\Uninstall completed, you might reboot the system ${colorReset}"
echo "Good bye!"
sleep 2






