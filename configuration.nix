# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    gfxmodeEfi = "1440x900";
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
    theme = "/boot/grub/themes/lain";
    splashImage = ./background.png; 
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "NIX"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking.
  networking.networkmanager.enable = true;

  # Garbage collector.
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };
 
  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable xserver.
  services.xserver.enable = true;

  # Enable SDDM. 
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    setupScript = ''
      ${pkgs.xrdb}/bin/xrdb -merge - <<EOF
      Xcursor.theme: breeze_cursors
      Xcursor.size: 24
      EOF
    '';
    theme = "catppuccin-mocha-flamingo";
  };

  # Define a user account.
  users.users.okama = {
    isNormalUser = true;
    description = "OKAMA";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [fish];
    shell = pkgs.fish;
  };

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;
  
  #Enable steam.
  programs.steam.enable = true;

  # Enable hyprland.
  programs.hyprland.enable = true;

  # Enable nerd fonts.
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Enable flatpak.
  services.flatpak.enable = true;

  # Enable fish.
  programs.fish.enable = true;

  # Set breeze theme for cursor globally.
  environment.sessionVariables = {
    XCURSOR_THEME = "Breeze";
    XCURSOR_SIZE = "24";
  };
  
  # Enable yazi.
  programs.yazi.enable = true;
 
  # Remove Xterm;
  services.xserver.excludePackages = with pkgs; [ xterm ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    eden
    tor-browser
    appimage-run
    noto-fonts-cjk-sans
    rustup
    zed-editor
    libsForQt5.qt5ct
    kdePackages.qt6ct
    gcc
    discord
    kitty
    waybar
    hypridle
    hyprlock
    hyprpaper
    hyprshot
    yazi
    git
    fastfetch
    xdg-user-dirs
    xcursor-themes
    qbittorrent
    nwg-look
    cmatrix
    cbonsai
    yt-dlp
    vlc
    rofi
    jdk
    shipwright
    dunst
    gimp
    lsd
    imv
    cava
    kdePackages.breeze
    cava
    obs-studio
    zathura
    zathuraPkgs.zathura_core
    zathuraPkgs.zathura_pdf_poppler
    zathuraPkgs.zathura_djvu
    zathuraPkgs.zathura_ps
    zathuraPkgs.zathura_cb
    p7zip-rar
    trash-cli
    pokeget-rs
    termusic
    mpv 
    (catppuccin-sddm.override {
        flavor = "mocha";
        accent = "flamingo";
        font  = "JetBrainsMono Nerd Font";
        fontSize = "10";
        background = "${./laundry.png}";
        loginBackground = true;
      }
    )
    (steam.override {
        extraPkgs =
	    pkgs: with pkgs; [
	        kdePackages.breeze
 	    ]; 	 
      }
    )
  ];
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.11"; # Did you read the comment?

}
