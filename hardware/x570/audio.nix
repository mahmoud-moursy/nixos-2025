{
  services.pipewire.extraConfig.pipewire."99-audio" = {
    "context.properties" = {
      "default.clock.rate" = 44100;
      "default.clock.allowed-rates" = [
        44100
        48000
        88200
        96000
        176400
        192000
        352800
        384000
        705600
        768000
      ];

      "resample.quality" = 10;
      "resample.disable" = false;

      "default.audio.format" = "F32LE";
    };
  };
}
