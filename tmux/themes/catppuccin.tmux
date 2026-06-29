set -g @plugin 'catppuccin/tmux#v2.1.0'
set -g @catppuccin_flavor "mocha"
set -g @catppuccin_window_status_style "rounded"
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_application} #{E:@catppuccin_status_session}"
