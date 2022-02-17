#!/bin/bash

# check if the reboot flag file exists. 
# We created this file before rebooting.
if [ ! -f /var/run/resume-after-reboot ]; then
  echo "Install Started"
 
  # Create main folder and git clone
  mkdir -p ~/.dotfiles
  git clone https://github.com/makifdb/dotfiles ~/.dotfiles
  cd ~/.dotfiles || exit
  
  echo "update"
  . ./scripts/update.sh
  echo "install"
  . ./scripts/install_packages.sh
  echo "synce"
  . ./scripts/synce_configs.sh

  # Preparation for reboot
  script="bash ~/.dotfiles/setup.sh"
  
  # add this script to bashrc so it gets triggered immediately after reboot
  echo "$script" >> ~/.bashrc 
  
  # create a flag file to check if we are resuming from reboot.
  sudo touch /var/run/resume-after-reboot
  
  echo "rebooting..."
  #reboot

else 
  echo "Installation Continues"
  
  # Remove the line that we added in bashrc
  sed -i '/bash/d' ~/.bashrc 
  
  # remove the temporary file that we created to check for reboot
  sudo rm -f /var/run/resume-after-reboot

  # continue with rest of the script
  . ./scripts/after_reboot.sh

  echo "rebooting..."
  #reboot

fi
