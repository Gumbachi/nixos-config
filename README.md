# NixOS Config

NixOS Config for all of my Nix machines. The following directions are from a
fresh machine.

## Create Auto-Mounts

1. Mount important drives in desired location\
   `sudo mount /dev/sdX /mnt/ext`
2. Regenerate hardware config with newly mounted drives\
   `sudo nixos-generate-config`

## Move Config to Home Directory

1. Backup current config if you want\
   `sudo mv /etc/nixos /etc/nixos.bak`
2. Link /etc/nixos to config location in home\
   `sudo ln -s ~/nixos-config/ /etc/nixos`

## Download Flake and Install

1. Enter a shell with basic programs\
   `nix-shell -p git vim fish --run fish`

2. Clone the repo\
   ``
3. Move hardware configuration to proper host\
   `sudo mv /etc/nixos/hardware-configuration.nix ~/nixos-config/<host>/hardware-configuration.nix`

4. Rebuild system and reboot
   `sudo nixos-rebuild boot --flake ~/NixOS-Config#<host>`
5. `reboot`

## Post-Flake-Install

1. Sound Devices may need to be configured

   > Use pavucontrol

2. Some apps that probably need to be manually configured

   - YouTube Music
   - Vesktop
     - Disable Automatic Gain Control and Echo Cancellation
   - Steam
     - Enable proton in compatibility
     - Allow background shader processing
     - Add external storage locations

3. Set up Git SSH and change origin

   1. `ssh-keygen -t ed25519 -a 100 -C "github"`
   2. `cat ~/.ssh/id_ed25519.pub`
   3. Copy output and add to Github SSH Tokens
   4. `cd ~/NixOS-Config` and
      `git remote set-url origin git@github.com:Gumbachi/NixOS-Config.git`
