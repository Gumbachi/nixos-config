{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  cfg = config.editors;
in {
  options.editors = {

    libreoffice.enable = mkEnableOption "Enable LibreOffice for edting various filetypes.";

    image = {
      gimp.enable = mkEnableOption "Enable gimp for image editing.";
      krita.enable = mkEnableOption "Enable Krita for image editing.";
    };

    video = {
      handbrake.enable = mkEnableOption "Enable handbrake for GUI tool management.";
      losslesscut.enable = mkEnableOption "Enable lossless cut for easily trimming videos.";
    };

    text = {
      helix = {
        enable = mkEnableOption "Enable helix text editor.";
        setDefault = mkEnableOption "Set the EDITOR environment variable to helix.";
      };
      vscodium = {
        enable = mkEnableOption "Enable vscodium text editor.";
        setDefault = mkEnableOption "Set the EDITOR environment variable to codium.";
      };
      nvf = {
        enable = mkEnableOption "Enable nvim/nvf.";
        setDefault = mkEnableOption "Set the EDITOR environment variable to nvim.";
      };
    };
  };

  config = mkMerge [
    
    (mkIf cfg.libreoffice.enable {
      environment.systemPackages = with pkgs; [
        libreoffice # Office Software
        hunspell # Spellcheck for libreoffice
        hunspellDicts.en_US # US Dictionary for spellcheck
      ];
    })

    (mkIf cfg.image.gimp.enable {
      environment.systemPackages = [ pkgs.gimp3 ];
    })

    (mkIf cfg.image.krita.enable {
      environment.systemPackages = [ pkgs.krita ];
    })

    (mkIf cfg.video.handbrake.enable {
      environment.systemPackages = [ pkgs.handbrake ];
    })

    (mkIf cfg.video.losslesscut.enable {
      environment.systemPackages = [ pkgs.losslesscut-bin ];
    })

    (mkIf cfg.text.vscodium.enable {
      environment.systemPackages = [ pkgs.vscodium ];
      environment.sessionVariables.EDITOR = mkIf cfg.text.vscodium.setDefault "codium";
    })

    (mkIf cfg.text.helix.enable {
      environment.sessionVariables.EDITOR = mkIf cfg.text.helix.setDefault "hx";
      home-manager.sharedModules = [{ 
        programs.helix.enable = true;
        programs.helix.defaultEditor = cfg.text.helix.setDefault;
      }];
    })

    (mkIf cfg.text.nvf.enable {
      environment.sessionVariables.EDITOR = mkIf cfg.text.nvf.setDefault "nvim";
      programs.nvf.enable = true;
    })
  ];
}
