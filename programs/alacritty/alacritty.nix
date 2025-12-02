{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings.general.import = [
      ./alacritty.toml
      (
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "alacritty";
          rev = "refs/heads/main";
          sha256 = "sha256-H8bouVCS46h0DgQ+oYY8JitahQDj0V9p2cOoD4cQX+Q=";
        }
        + "/catppuccin-macchiato.toml"
      )
    ];
  };
}
