{pkgs, ...}: {
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

  system.primaryUser = "aryn";

  environment.systemPackages = [];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

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
      "flux-app"
      "handbrake-app"
      "inkscape"
      "mos"
      "rectangle"
      "spotify"
      "vscodium"
      "zen"
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
      sops
    ];
  };

  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  sops.defaultSopsFile = ../secrets/secrets.yaml;
}
