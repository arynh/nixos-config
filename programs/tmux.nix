{ pkgs, ... }:
{
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

      set -g default-terminal "tmux-256color"
    '';

    plugins =
      let
        inherit (pkgs) tmuxPlugins;
      in
      [
        { plugin = tmuxPlugins.sensible; }
        {
          plugin = tmuxPlugins.catppuccin;
          extraConfig = ''
            # Configure the catppuccin plugin
            set -g @catppuccin_flavor "macchiato"
            set -g @catppuccin_window_status_style "rounded"

            # Make the status line pretty and add some stuff
            set -g status-right-length 100
            set -g status-left-length 100
            set -g status-left ""
            set -g status-right "#{E:@catppuccin_status_application}"
            set -ag status-right "#{E:@catppuccin_status_session}"
            set -ag status-right "#{E:@catppuccin_status_uptime}"

            # Automatic pane naming
            set -g @catppuccin_window_text "#{b:pane_current_path}"
            set -g @catppuccin_window_current_text "#{b:pane_current_path}"
          '';
        }
      ];
  };
}
