#!/usr/bin/env bash

uid="$(id -u)"
dir_string='/Library/Application Support/Sublime Text 3'
sublime_dir="$HOME$dir_string"
sublime_package_dir="$sublime_dir/Packages"
git_url="git@github.com:NoahBuscher/Flatron.git"
dest_path="$sublime_package_dir/Flatron"

# Colors
Reset='\033[0m' # No Color
FgWhite='\033[1;37m'
FgBlack='\033[0;30m'
FgBlue='\033[0;34m'
FgLightBlue='\033[1;34m'
FgGreen='\033[0;32m'
FgLightGreen='\033[1;32m'
FgCyan='\033[0;36m'
FgLightCyan='\033[1;36m'
FgRed='\033[0;31m'
FgLightRed='\033[1;31m'
FgPurple='\033[0;35m'
FgLightPurple='\033[1;35m'
FgBrown='\033[0;33m'
FgYellow='\033[1;33m'
FgGray='\033[0;30m'
FgLightGray='\033[0;37m'

function step {
  echo -ne " ${FgBlue}>${Reset} $1..."
}

function success {
  echo -e "${FgGreen}OK${Reset}"
}

function fail {
  echo -e "${FgRed}FAIL${Reset}" 1>&2
  if [ ! "$1" = "" ]; then
    echo -e "  ${FgLightRed}$1${Reset}" 1>&2
  fi
  exit 1
}

echo -e "${FgLightPurple}#--------------------------------------"
echo -e "#"
echo -e "# ${FgWhite}Flatron Installer${FgLightPurple}"
echo -e "#"
echo -e "#--------------------------------------${Reset}"

step "Checking for root user"
if [ $uid = "0" ]; then fail "Cowardly refusing to run as root user :("; else success; fi

step "Checking for Sublime Text 3 Installation"
if [ ! -d "$sublime_dir" ]; then fail "Sublime Text 3 installation not found"; else success; fi

step "Checking if theme already installed..."
if [ -d "$dest_path" ]; then fail "Flatron Theme already installed"; else success; fi

step "Installing Flatron Theme"
if output=$(git clone "$git_url" "$dest_path" > /dev/null 2>&1); then success; else fail "Unable to download the theme. Please try again."; fi

step "Verifying Flatron installed properly"
if output=$(ls "$dest_path" > /dev/null 2>&1); then success; else fail "It does not appear that Flatron installed properly. Please try again."; fi

echo ""
echo -e " ${FgBlue}>>>${Reset} ${FgGreen}Installation successful!${Reset}"
echo -e " ${FgLightBlue}Please add the following lines to your User Preferences file: ${Reset}"
echo ""
echo -e "     ${FgLightRed}\"theme\"${FgWhite}: ${FgLightPurple}\"Flatron.sublime-theme\"${Reset}"
echo -e "     ${FgLightRed}\"color_scheme\"${FgWhite}: ${FgLightPurple}\"Packages/Theme - Flatron/Flatron.tmTheme\"${Reset}"
