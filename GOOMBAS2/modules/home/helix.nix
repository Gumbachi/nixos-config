{ pkgs, ... }: {
  
  programs.helix = {
    settings.editor = {
      line-number = "absolute";
      lsp.display-messages = true;
      clipboard-provider = "wayland";
      # rainbow-brackets = true;
      trim-final-newlines = true;
      trim-trailing-whitespace = true;
      popup-border = "all";
      continue-comments = false;
      # rulers = [ 80 ];
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "block";
      };
      statusline = {
        left = ["mode" "spinner" "version-control" "diagnostics"];
        center = ["file-modification-indicator" "file-name" "read-only-indicator"];
        right = ["file-indent-style" "position" "total-line-numbers"];
      };
      indent-guides = {
        render = true;
        character = "╎";
      };
    };
            
    extraPackages = with pkgs; [
      nixd
      taplo
      yaml-language-server
    ];
    
  };
}
