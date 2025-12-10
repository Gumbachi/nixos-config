{
  description = "Gumbachi NixOS Config";
  inputs = {

    # Default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # System
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    # Applications
    # overway.url = "github:Gumbachi/overway";
    # overway.url = "path:/home/jared/code/overway";

    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    amber.url = "github:amber-lang/Amber";

    niri.url = "github:sodiboo/niri-flake";

    nvf.url = "github:notashelf/nvf";

    walker.url = "github:abenz1267/walker";

    nixos-cli.url = "github:nix-community/nixos-cli";

    helix.url = "github:helix-editor/helix";

    # Fetch wallpapers and load into nix store
    wallpaper.url = "https://files.gumbachi.com/wallpapers/cyberpunk.png";
    wallpaper.flake = false;

    wallpaper-portrait.url = "https://files.gumbachi.com/wallpapers/cyberpunk-portrait-compressed.png";
    wallpaper-portrait.flake = false;

  };

  outputs = { nixpkgs, home-manager, ... } @ inputs: let
    user = "jared";
    configPath = "/home/${user}/nixos-config";
    # Nix Modules that should be on all systems. Reduces repetition
    defaultModules = [
      inputs.stylix.nixosModules.stylix
      inputs.nvf.nixosModules.default
      inputs.nur.modules.nixos.default
      inputs.nixos-cli.nixosModules.nixos-cli
    ];
  in {
    # Host Name = <GOOMBA><X/S/L><Number>
    # GOOMBA = Name
    # X/S = Desktop/Laptop, Server
    # Number = ID

    nixosConfigurations.GOOMBAX1 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs user; };
      modules = defaultModules ++ [
        ./GOOMBAX1/configuration.nix # Main Config
        { nixpkgs.hostPlatform = "x86_64-linux"; } # https://isabelroses.com/blog/im-not-mad-im-disappointed/

        # Home Manager
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hmbak";
            extraSpecialArgs = { inherit inputs configPath; };
          };
          home-manager.users.${user}.imports = [ ./GOOMBAX1/home.nix ];
        }

        # Overlays
        { nixpkgs.overlays = [ inputs.niri.overlays.niri ]; }

        # Hardware Support
        inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate

        # Third Party
        inputs.niri.nixosModules.niri
      ];
    };

    nixosConfigurations.GOOMBAS2 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs user; };
      modules = defaultModules ++ [
        ./GOOMBAS2/configuration.nix # Main Config
        { nixpkgs.hostPlatform = "x86_64-linux"; } # https://isabelroses.com/blog/im-not-mad-im-disappointed/

        # Home Manager
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hmbak";
            extraSpecialArgs = { inherit inputs user configPath; };
          };
          home-manager.users.${user}.imports = [ ./GOOMBAS2/home.nix ];
        }

        # Hardware Support
        inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
        inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
        inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime

        # Third Party
        inputs.agenix.nixosModules.default
      ];
    };

    nixosConfigurations.GOOMBAX2 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs user; };
      modules = defaultModules ++ [
        ./GOOMBAX2/configuration.nix # Main Config
        { nixpkgs.hostPlatform = "x86_64-linux"; } # https://isabelroses.com/blog/im-not-mad-im-disappointed/

        # Home Manager
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hmbak";
            extraSpecialArgs = { inherit inputs user configPath; };
            users.jared.imports = [ ./GOOMBAX2/home.nix ];
          };
        }

        # Hardware Config
        inputs.nixos-hardware.nixosModules.dell-xps-15-9560

        # Third Party Modules
        inputs.niri.nixosModules.niri
      ];
    };

  };
}
