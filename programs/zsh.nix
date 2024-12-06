{pkgs, ...}: {
  programs.zsh = {
    enable = true;

    shellAliases = {
      cat = "bat";
      ls = "eza";
      vim = "nvim";
      v = "nvim";
    };

    initExtra = ''
      # run ls after entering a new directory
      function chpwd() { emulate -L zsh; eza }
    '';

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = ["git" "timer"];
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma-continuum";
          repo = "fast-syntax-highlighting";
          rev = "v1.55";
          sha256 = "sha256-DWVFBoICroKaKgByLmDEo4O+xo6eA8YO792g8t8R7kA=";
        };
      }
    ];
  };
}
