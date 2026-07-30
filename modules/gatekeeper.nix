{
  config,
  pkgs,
  lib,
  ...
}:
{
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.timeout = 10;
  boot.kernelParams = [
    "cma=64M"
    "console=serial0,115200"
    "console=tty1"
  ];
  boot.consoleLogLevel = 3;
  boot.kernel.sysctl."vm.swappiness" = 10;

  networking.useDHCP = lib.mkDefault true;
  networking.wireless.enable = false;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  services.openssh.enable = true;

  hardware.bluetooth.enable = false;
  services.xserver.enable = false;
  services.udisks2.enable = false;
  security.polkit.enable = lib.mkForce false;

  nix.settings.auto-optimise-store = true;
  system.disableInstallerTools = true;
  programs.command-not-found.enable = false;
  services.logind.settings.Login.IdleAction = "ignore";
  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "performance";

  users.users.gk = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "nfc"
    ];
  };

  environment.systemPackages = with pkgs; [
    libnfc
    libfreefare
    openssl
    pkg-config
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="6001", MODE="0660", GROUP="nfc"
    SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}=="A5069RR4", SYMLINK+="pn532", MODE="0660", GROUP="nfc", ENV{ID_MM_DEVICE_IGNORE}="1"
  '';
  users.groups.nfc = { };

  zramSwap.enable = true;
  documentation.enable = false;
  documentation.nixos.enable = false;
}

