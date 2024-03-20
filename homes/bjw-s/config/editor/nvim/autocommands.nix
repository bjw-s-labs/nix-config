{
  ...
}:
{
  config = {
    autoCmd = [
      # Remove trailing whitespace on save
      {
        event = "BufWrite";
        command = "%s/\\s\\+$//e";
      }
    ];
  };
}
