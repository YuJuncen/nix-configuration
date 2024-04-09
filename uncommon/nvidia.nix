{ ... }:

{
  services.xserver = {
    config = ''
      Section "Device"
          Identifier "nvidia"
          Driver "nvidia"
          BusID "PCI:8:0:0"
          Option "AllowEmptyInitialConfiguration"
      EndSection
    '';
    screenSection = ''
      Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option         "AllowIndirectGLXProtocol" "off"
      Option         "TripleBuffer" "on"
    '';
  };
}
