{...}: {
  enable = true;
  settings = {
    add_newline = true;
    command_timeout = 200;
    scan_timeout = 50;
    format = "$all$character ";
    character = {
      error_symbol = "[❯](bold red)";
      success_symbol = "[❯](bold green)";
      format = "$symbol$symbol$symbol";
    };
    terraform = {
      symbol = " ";
    };
    directory = {
      truncate_to_repo = false;
      use_logical_path = false;
      truncation_length = 255;
    };
  };
}
