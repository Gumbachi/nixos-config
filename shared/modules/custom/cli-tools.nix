{ pkgs, lib, config,  ... }:
let
  inherit (lib) mkEnableOption mkIf mkMerge;
  module = "cli-tools";
  cfg = config.${module};
in {

  options.${module} = {
    
    upgrades.enable = mkEnableOption ''
      Shorcut options to enable all drop in replacements.
        ls => eza
        cat => bat
        cd => zoxide(z)
        grep => ripgrep(rg)
        grep => fzf
        find => fd
        df => dysk
        more,less => most
        man => batman
        diff => batdiff
        watch => batwatch
        curl => xh
        du => dua
    '';

    # Tool replacements
    eza.enable = mkEnableOption "Enable eza replacement for ls.";
    bat = {
      enable = mkEnableOption "Enable bat replacement for cat.";
      extras.enable = mkEnableOption "Enable bat extras (batman, batdiff, prettybat, batwatch)";
    };
    ripgrep.enable = mkEnableOption "Enable ripgrep replacement for grep";
    fd.enable = mkEnableOption "Enable fd replacement for find";
    zoxide.enable = mkEnableOption "Enable zoxide replacement for cd.";
    fzf.enable = mkEnableOption "Enable fzf fuzzy finding.";
    dysk.enable = mkEnableOption "Enable dysk for disk usage.";
    most.enable = mkEnableOption "Enable most to replace more and less.";
    xh.enable = mkEnableOption "Enable XH, an upgraded curl.";
    dua.enable = mkEnableOption "Enable Dua disk usage analyzer.";

    # Extra tools
    wget.enable = mkEnableOption "Enable wget to make web requests";
    tokei.enable = mkEnableOption "Enable tokei to count lines of code.";

    # Style related programs
    ricing.enable = mkEnableOption ''
      Shorcut options to enable all style related programs.
        - starship
        - fastfetch
        - cava
        - pipes
        - cbonsai
    '';
    fastfetch.enable = mkEnableOption "Enable fastfetch for system info.";
    cava.enable = mkEnableOption "Enable cava for audio visualisation.";
    pipes.enable = mkEnableOption "Enable pipes, a terminal screensaver.";
    cbonsai.enable = mkEnableOption "Enable cbonsai, to grow an ascii tree.";
    starship.enable = mkEnableOption "Enable starship for shell prompt customization.";


    # Archive tools
    unar.enable = mkEnableOption "Enable unar for zip archives.";
    unzip.enable = mkEnableOption "Enable unzip for zip archives.";
    unrar.enable = mkEnableOption "Enable unrar for rar archives.";
  };

  config = mkMerge [

    (mkIf cfg.upgrades.enable {
      ${module} = { 
        eza.enable = true;
        zoxide.enable = true;
        ripgrep.enable = true;
        fd.enable = true;
        fzf.enable = true;
        dysk.enable = true;
        most.enable = true;
        xh.enable = true;
        dua.enable = true;
        bat = {
          enable = true;
          extras.enable = true;
        };
      };

      # Fish Aliases
      home-manager.sharedModules = [{
        programs.fish.shellAliases = {
          # ls = "eza" # This one is covered by the eza fish integration in home manager
          # cat = "bat"; # Not needed
          # cd = "z"; # Disabled because z is easier than cd anyways
          # grep = "rg"; # Similar as above ^^^^^^^^^^^^^^^^^^^^^^^^^
          find = "fd";
          df = "dysk -f 'mp <> /boot'";
          more = "most";
          less = "most";
          man = "batman";
          diff = "batdiff";
          # watch = "batwatch -x";
        };
      }];
    })

    # Drop In Replacements
    (mkIf cfg.eza.enable {
      environment.systemPackages = [ pkgs.eza ];
      home-manager.sharedModules = [{
        programs.eza = {
          enable = true;
          colors = "always";
          icons = "always";
        };
      }];
    })

    (mkIf cfg.bat.enable {
      programs.bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [ batdiff batman batwatch ];
      };
      home-manager.sharedModules = [{ 
        programs.bat = {
          enable = true;
          extraPackages = with pkgs.bat-extras; [ batdiff batman batwatch ];
        };
      }];
    })

    (mkIf cfg.ripgrep.enable {
      environment.systemPackages = [ pkgs.ripgrep ];
      home-manager.sharedModules = [{ programs.ripgrep.enable = true; }];
    })

    (mkIf cfg.zoxide.enable {
      environment.systemPackages = [pkgs.zoxide];
      home-manager.sharedModules = [{ programs.zoxide.enable = true; }];
    })

    (mkIf cfg.fd.enable {
      environment.systemPackages = [pkgs.fd];
      home-manager.sharedModules = [{ programs.fd.enable = true; }];
    })

    (mkIf cfg.fzf.enable {
      environment.systemPackages = [pkgs.fzf];
      home-manager.sharedModules = [{ programs.fzf.enable = true; }];
    })

    (mkIf cfg.dysk.enable {
      environment.systemPackages = [pkgs.dysk];
    })

    (mkIf cfg.dysk.enable {
      environment.systemPackages = [pkgs.most];
    })

    (mkIf cfg.xh.enable {
      environment.systemPackages = [ pkgs.xh ];
    })

    (mkIf cfg.dua.enable {
      environment.systemPackages = [ pkgs.dua ];
    })

    # Style tools
    (mkIf cfg.ricing.enable {
      ${module} = {
        starship.enable = true;
        fastfetch.enable = true;
        cava.enable = true;
        pipes.enable = true;
        cbonsai.enable = true;
      };
    })

    (mkIf cfg.fastfetch.enable {
      environment.systemPackages = [pkgs.fastfetch];
      home-manager.sharedModules = [{ programs.fastfetch.enable = true; }];
    })

    (mkIf cfg.cava.enable {
      environment.systemPackages = [pkgs.cava];
      home-manager.sharedModules = [{ programs.cava.enable = true; }];
    })

    (mkIf cfg.pipes.enable {
      environment.systemPackages = [pkgs.pipes];
    })

    (mkIf cfg.cbonsai.enable {
      environment.systemPackages = [pkgs.cbonsai];
    })

    (mkIf cfg.starship.enable {
      environment.systemPackages = [pkgs.starship];
      home-manager.sharedModules = [{ programs.starship.enable = true; }];
    })

    # Extra Tools

    (mkIf cfg.wget.enable {
      environment.systemPackages = [pkgs.wget];
    })

    (mkIf cfg.tokei.enable {
      environment.systemPackages = [ pkgs.tokei ];
    })

    (mkIf cfg.unar.enable {environment.systemPackages = [pkgs.unar];})
    (mkIf cfg.unzip.enable {environment.systemPackages = [pkgs.unzip];})
    (mkIf cfg.unrar.enable {environment.systemPackages = [pkgs.unrar];})
  ];
}
