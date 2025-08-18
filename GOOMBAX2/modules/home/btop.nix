{ pkgs, ... }: {
  
  programs.btop = {
    package = pkgs.btop-cuda;
    settings = {
      shown_boxes = "cpu gpu0 mem";
    };
  };

}
