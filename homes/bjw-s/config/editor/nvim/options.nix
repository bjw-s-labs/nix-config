_:
{
  config = {
    opts = {
      updatetime = 100; # Faster completion
      swapfile = false; # Disable the swap file

      number = true; # Display the absolute line number of the current line
      showmatch = true; # Show matching brackets

      # Tab options
      tabstop = 2; # Number of spaces a <Tab> in the text stands for (local to buffer)
      shiftwidth = 2; # Number of spaces used for each step of (auto)indent (local to buffer)
      expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
      autoindent = true; # Do clever autoindenting
    };
  };
}
