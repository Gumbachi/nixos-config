{ pkgs, ... }: {

  programs.chromium = {
    package = pkgs.chromium;
  };

}
