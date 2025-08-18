{ ... }: {

  services.hyprsunset = {
    transitions = {

      sunrise = {
        calendar = "*-*-* 08:00:00";
        requests = [
          [ "temperature" "6500" ]
        ];
      };

      sunset = {
        calendar = "*-*-* 00:30:00";
        requests = [
          [ "temperature" "3000" ]
        ];
      };

    };
  };

}
