{ pkgs, ... }:
{
  home.username = "aryn";
  home.homeDirectory = "/home/aryn";

  imports = [
    ../programs/nvim/nvim.nix
    ../programs/zsh.nix
    ../programs/bat.nix
    ../programs/git.nix
    ../programs/tmux.nix
    ../programs/ssh.nix
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    alejandra
    bottom
    curl
    eza
    fzf
    gh
    luajit
    nodejs
    python3
    ripgrep
  ];

  home.file = { };

  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
