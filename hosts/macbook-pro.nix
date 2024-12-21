{pkgs, ...}: {
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Used for backwards compatibility. please read the changelog
  # before changing: `darwin-rebuild changelog`.
  system.stateVersion = 5;

  # Declare the user that will be running `nix-darwin`.
  users.users.aryn = {
    name = "aryn";
    home = "/Users/aryn";
  };

  environment.systemPackages = [];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
  ];

  security.pam.enableSudoTouchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    # auto updating breaks nix's idempotency guarantees but I'm lazy
    # so update brew stuff on activation
    onActivation.upgrade = true;
    onActivation.autoUpdate = true;
    taps = [];
    brews = [];
    casks = [
      "alacritty"
      "arc"
      "audacity"
      "discord"
      "firefox"
      "flux"
      "handbrake"
      "mos"
      "rectangle"
      "spotify"
      "vscodium"
      "zen-browser"
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;
  home-manager.users.aryn = {pkgs, ...}: {
    # this is internal compatibility configuration
    # for home-manager, don't change this!
    home.stateVersion = "24.05";
    # Let home-manager install and manage itself.
    programs.home-manager.enable = true;

    imports = [
      ../programs/alacritty/alacritty.nix
      ../programs/nvim/nvim.nix
      ../programs/zsh.nix
      ../programs/bat.nix
      ../programs/git.nix
      ../programs/tmux.nix
      ../programs/ssh.nix
    ];

    home.packages = with pkgs; [
      cargo
      python3
      nodejs
      eza
      alejandra
      bottom
      fzf
    ];
  };
}
