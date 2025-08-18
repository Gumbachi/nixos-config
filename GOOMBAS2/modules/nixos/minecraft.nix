{ pkgs, config, lib, ... }: {

  # Sky Factory 4 Minecraft Server
  systemd.services.sky-factory-4 = {
    enable = false;
    wantedBy = ["multi-user.target"];
    description = "Minecraft Server";
    serviceConfig = {
      Type = "simple";
      RestartSec = "60";
      Environment = "JAVA_HOME=${pkgs.jdk8}";
      WorkingDirectory = "/mnt/main/Servers/Minecraft/SkyFactory-4_Server_4_2_4";
      ExecStart = "/mnt/main/Servers/Minecraft/SkyFactory-4_Server_4_2_4/start.sh";
    };
  };

  # DawnCraft Minecraft Server
  systemd.services.dawncraft = {
    enable = false;
    wantedBy = ["multi-user.target"];
    description = "DawnCraft Minecraft Server";
    serviceConfig = {
      Type = "simple";
      RestartSec = "60";
      Environment = "JAVA_HOME=${pkgs.jdk}";
      WorkingDirectory = "/mnt/main/Servers/Minecraft/DawnCraft";
      ExecStart = "/mnt/main/Servers/Minecraft/DawnCraft/start.sh";
    };
  };

  networking.firewall.allowedTCPPorts = lib.mkIf config.systemd.services.sky-factory-4.enable [ 43002 ];
}
