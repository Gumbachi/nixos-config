{ pkgs, ... }: {
  
  programs.helix = {

    settings.editor = {
      line-number = "relative";
      lsp.display-messages = true;
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      statusline = {
        left = ["mode" "spinner" "version-control"];
        center = ["file-modification-indicator" "file-name"];
        right = ["diagnostics" "file-indent-style" "position-percentage" "total-line-numbers"];
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
