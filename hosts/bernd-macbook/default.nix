{
  pkgs,
  lib,
  hostname,
  ...
}:
{
  config = {
    networking = {
      computerName = "Bernd's MacBook";
      hostName = hostname;
      localHostName = hostname;
    };

    users.users.bjw-s = {
      name = "bjw-s";
      home = "/Users/bjw-s";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = lib.strings.splitString "\n" (builtins.readFile ../../homes/bjw-s/config/ssh/ssh.pub);
    };

    system.activationScripts.postActivation.text = ''
      # Must match what is in /etc/shells
      sudo chsh -s /run/current-system/sw/bin/fish bjw-s
    '';

    homebrew = {
      taps = [
      ];
      brews = [
      ];
      casks = [
        "anylist"
        "discord"
        "google-chrome"
        "obsidian"
        "orbstack"
        "plex"
        "tableplus"
        "transmit"
        "wireshark"
      ];
      masApps = {
        "Ghostery" = 6504861501;
        "Keka" = 470158793;
        "Passepartout" = 1433648537;
      };
    };
  };
}
