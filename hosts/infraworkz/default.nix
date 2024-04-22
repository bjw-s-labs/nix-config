{
  pkgs,
  lib,
  hostname,
  ...
}:
{
  config = {
    networking = {
      computerName = "Bernd Infraworkz";
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
        "citrix-workspace"
        "displaylink"
        "google-chrome"
        "microsoft-teams"
        "obsidian"
        "orbstack"
        "slack"
        "tableplus"
        "transmit"
      ];
      masApps = {
        "Adguard for Safari" = 1440147259;
        "Keka" = 470158793;
      };
    };
  };
}
