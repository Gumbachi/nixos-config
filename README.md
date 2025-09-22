# NixOS Config

NixOS Config for all of my Nix machines. The following directions are from a
fresh machine that wants to replicate GOOMBAX1.

## Install essential programs and clone repo

1. Install important programs in a shell\
   `nix-shell -p git fish helix --run fish`

2. Clone the repo\
   `cd /home/jared/ && git clone github.com/gumbachi/nixos-config`

## Create auto-mounts

1. Mount important drives in desired location\
   `sudo mount /dev/sdX /mnt/ext`
2. Regenerate hardware config with newly mounted drives\
   `sudo nixos-generate-config`

## Move hardware-config to cloned config

1. Move hardware configuration to proper host\
   `sudo mv /etc/nixos/hardware-configuration.nix ~/nixos-config/GOOMBAX1/hardware-configuration.nix`

## Finish installation

1. Rebuild system from flake and reboot\
   `sudo nixos-rebuild boot --flake ~/nixos-config#GOOMBAX1`
2. `reboot`

## Post-Flake-Install

1. Configure Sound Devices
   - Disable unused devices in `pavucontrol`

2. Sign in and configure services
   - Bitwarden
   - YouTube Music
   - Vesktop
      - Disable Automatic Gain Control in Voice & Video
   - Steam
      - Set Compatibility to GE-Proton in Compatibility
      - Set UI Scale and Color in Accessibility
      - Allow background shaders in Downloads
      - Set Library as opening page in Interface
      - Select external drive to restore games

3. Set up Git SSH and change origin

   1. `ssh-keygen -t ed25519 -a 100 -C "github"`
   2. `cat ~/.ssh/id_ed25519.pub`
   3. Copy output and add to Github SSH Tokens
   4. `cd ~/nixos-config` and
      `git remote set-url origin git@github.com:Gumbachi/nixos-config.git`
