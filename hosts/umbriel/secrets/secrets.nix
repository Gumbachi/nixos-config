let
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPSBzKNu2HL1mirMCmnL1FHvAJiR1lBJdWUovdSG4pUv";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHsVQUrdY1G2DlL8l6ampkvaRp8BxnsKjhoypdVkVQ8+";
in
{
  "gumbotchi.age".publicKeys = [ user system ];
  "vibrant.age".publicKeys = [ user system ];
  "deluge.age".publicKeys = [ user system ];
  "qbit-vpn.age".publicKeys = [ user system ];

  "radarr.age".publicKeys = [ user system ];
  "sonarr.age".publicKeys = [ user system ];

  "searx.age".publicKeys = [ user system ];
}
