{
  imports = [
    ./hardware-configuration.nix
    ../../modules/gatekeeper.nix
  ];
  networking.hostName = "homolog-01";
  system.stateVersion = "26.05";
}
