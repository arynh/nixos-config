{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config.theme = "Catppuccin Macchiato";
    themes."Catppuccin Macchiato" = {
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "refs/heads/main";
        sha256 = "sha256-x1yqPCWuoBSx/cI94eA+AWwhiSA42cLNUOFJl7qjhmw=";
      };
      file = "themes/Catppuccin Macchiato.tmTheme";
    };
  };
}
