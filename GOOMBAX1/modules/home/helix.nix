{ inputs, pkgs, ... }: {

  programs.helix.settings.editor = {
    line-number = "absolute";
    lsp.display-messages = true;
    clipboard-provider = "wayland";
    scrolloff = 8;
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

  programs.helix.settings.keys.normal = {
    space.e = ":sh zellij run -n Yazi -c -f -x 10%% -y 10%% --width 80%% --height 80%% -- bash ~/nixos-config/scripts/yazi-picker.sh open %{buffer_name}";
  };

  programs.helix.extraPackages = with pkgs; [
    marksman
    nixd
    vscode-css-languageserver
    vscode-json-languageserver
    taplo
  ];



}
