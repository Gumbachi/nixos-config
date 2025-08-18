{ pkgs, ... }: {

  programs.btop = {
    package = pkgs.btop-cuda;
    settings = {
      shown_boxes = "cpu mem net proc gpu0";
    };
  };

}
