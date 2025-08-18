{ ... }: {

  programs.btop = {
    settings = {
      shown_boxes = "cpu mem net proc gpu0";
      custom_gpu_name0 = "Radeon RX 7900XTX";
    };
  };

}
