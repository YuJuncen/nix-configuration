{ config, pkgs, lib, home-manager, ... }:

{
  nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
}
