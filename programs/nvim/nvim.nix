{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      stylua
      # fzf-lua stuff
      fd
      fzf
      ripgrep
      # some dependencies install through cargo
      cargo
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = ./lua;
  xdg.configFile."nvim/init.lua".source = ./init.lua;
}
