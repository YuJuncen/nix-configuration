{pkgs, lib, config, ...}:

let   
  cfg = config.services.self-hosted.sing-box;
  opts = {...}:
  {
    options = {
      enable = lib.mkEnableOption "xiccd";
      package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.sing-box;
      };
    };
  };
in
{
  imports = [ ];
  options.services.self-hosted.xiccd = lib.mkOption { type = with lib.types; (submodule opts); };
  config = lib.mkIf cfg.enable {
    systemd.services.xiccd = {
   description = "Xiccd Screen Color Profiler";
   serviceConfig = {
     ExecStart = "${cfg.xiccd}/bin/xiccd";
     ExecStop = "pkill xiccd";
     Restart = "always";
   };
   wantedBy = [ "dbus.service" ];
   after = [ "dbus.service" ];
   partOf = [ "dbus.service" ];
 };
  };
}