{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    sensibleOnTop = false;
    keyMode = "vi";
    baseIndex = 1;

    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # split windows with keys better visualized
      bind | split-window -h
      bind _ split-window -v
    '';

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.catppuccin
    ];
  };
}
