{ ... }:
{
  home.file = {
    "lazygit.conf" = {
      target = ".config/lazygit/config.yml";
      source = ./lazygit.yml;
    };
  };
}