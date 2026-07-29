{ config, pkgs, lib, ... }:
{
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.timeout = 10;
  boot.kernelParams = [ "cma=64M" "console=serial0,115200" "console=tty1" ];

  networking.useDHCP = lib.mkDefault true;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  services.openssh.enable = true;

  users.users.gk = {
    isNormalUser = true;
    extraGroups = [ "wheel" "nfc" ];
  };

  environment.systemPackages = with pkgs; [ libnfc libfreefare openssl pkg-config ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6001", MODE="0660", GROUP="nfc"
    SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}=="A5069RR4", SYMLINK+="pn532", MODE="0660", GROUP="nfc", ENV{ID_MM_DEVICE_IGNORE}="1"
  '';
  users.groups.nfc = {};

  powerManagement.cpuFreqGovernor = "performance";
  zramSwap.enable = true;
  documentation.enable = false;
  documentation.nixos.enable = false;
}
