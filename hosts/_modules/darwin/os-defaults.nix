_:
{
  security.pam.enableSudoTouchIdAuth = true;

  system = {
    defaults = {
      NSGlobalDomain = {
        # Whether to automatically switch between light and dark mode.
        AppleInterfaceStyleSwitchesAutomatically = true;
        # Configures the keyboard control behavior.  Mode 3 enables full keyboard control
        AppleKeyboardUIMode = 3;
        # Whether to show all file extensions in Finder
        AppleShowAllExtensions = true;
        # Whether to enable automatic capitalization.  The default is true
        NSAutomaticCapitalizationEnabled = false;
        # Whether to enable smart dash substitution.  The default is true
        NSAutomaticDashSubstitutionEnabled = false;
        # Whether to enable smart period substitution.  The default is true
        NSAutomaticPeriodSubstitutionEnabled = false;
        # Whether to enable smart quote substitution.  The default is true
        NSAutomaticQuoteSubstitutionEnabled = false;
        # Whether to enable automatic spelling correction.  The default is true
        NSAutomaticSpellingCorrectionEnabled = false;
        # Sets the size of the finder sidebar icons: 1 (small), 2 (medium) or 3 (large). The default is 3.
        NSTableViewDefaultSizeMode = 1;
        # Configures the trackpad tap behavior.  Mode 1 enables tap to click.
        "com.apple.mouse.tapBehavior" = 1;
        # Whether to enable trackpad secondary click.
        "com.apple.trackpad.enableSecondaryClick" = true;
        # Whether to autohide the menu bar.
        _HIHideMenuBar = false;
      };

      dock = {
        # Show appswitcher on all displays
        appswitcher-all-displays = false;
        # Automatically show and hide the dock
        autohide = true;
        # Position of the dock on screen.
        orientation = "left";
        # Show recent applications in the dock.
        show-recents = false;
      };

      finder = {
        # Show status bar
        ShowStatusBar = true;
        # Default Finder window set to list view
        FXPreferredViewStyle = "Nlsv";
        # Show path bar
        ShowPathbar = true;
        # Show all extensions
        AppleShowAllExtensions = true;
        # Show icons on desktop
        CreateDesktop = false;
        # Disable warning when changing file extension
        FXEnableExtensionChangeWarning = false;
      };
    };
  };
}
