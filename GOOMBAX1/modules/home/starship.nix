{ pkgs, ... }: {

  programs.starship = {
    # enableInteractive = false;
    settings = {
      add_newline = true;

      # format = ''
      #   $directory$git_branch$git_commit$git_state$git_metrics$git_status$time
      #   $character
      # '';

      character = {
        success_symbol = "[[](green) ❯](green)";
        error_symbol = "[[](red) ❯](red)";
        # success_symbol = "[❯](green)";
        # error_symbol = "[❯](red)";
      };

      directory = {
        format = "[$path]($style)[$read_only]($read_only_style) [$time]($style)";
        home_symbol = " ";
        truncation_length = 10;
        style = "bold cyan";
        fish_style_pwd_dir_length = 1;
      };

      git_branch = {
        symbol = " ";
        style = "bold magenta";
      };

      git_status = {
        style = "bold orange";
      };

      time = {
        disabled = false;
        format = "[$time]($style) ";
        time_format = "%R";
      };

    };
  };
}
