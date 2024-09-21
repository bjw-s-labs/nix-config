_:
{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false; # Don't update during rebuild
      cleanup = "zap"; # Uninstall all programs not declared
      upgrade = true;
    };
    global = {
      brewfile = true; # Run brew bundle from anywhere
      lockfiles = false; # Don't save lockfile (since running from anywhere)
    };
    taps = [
    ];
    brews = [
    ];
    casks = [
      "1password"
      "gifox"
      "iterm2"
      "jordanbaird-ice"
      "karabiner-elements"
      "keyboard-maestro"
      "raycast"
      "shottr"
    ];
    masApps = {
      "Caffeinated" = 1362171212;
    };
  };
}
