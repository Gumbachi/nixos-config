{ ... }: {
  imports = [
    ./cursor.nix
    ./wallpaper.nix
    ./icons.nix

    ./styles/patch.nix # Nix file for patching css
    ./presets # Import theme presets for different color schemes
  ];
}
