{ ... }: {

  services.wlsunset = {
    enable = true;
    sunrise = "08:00";
    sunset = "00:30";
    temperature = {
      day = 6500;
      night = 3000;
    };
  };

}
