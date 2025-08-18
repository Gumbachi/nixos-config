{ lib, ... }: {

  programs.mangohud = {
    settings = {
      position = "top-right";
      frametime = 0;
      frame_timing = 0;
      hud_compact = true;
      # hud_no_margin = true;
      # cpu_temp = true;
      # gpu_temp = true;
      engine = true;
      table_columns = 2;
      width = 100;

      # Stylix overrides
      background_alpha = lib.mkForce 0;
      font_size = lib.mkForce 20;
      font_size_text = lib.mkForce 20;
    };
  };

}
