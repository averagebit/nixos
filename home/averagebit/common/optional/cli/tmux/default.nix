{config, ...}: {
  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    extraConfig = with config.colorscheme; ''
      # ----------------------------------------------------------------------
      # --- General settings
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -g prefix C-a            # Bind prefix to <Ctrl-a>
      set -g bell-action none      # Disable bell actions
      set -g display-time 2000     # Tmux messages displayed for 2 seconds
      set -g focus-events on       # Enable focus events
      set -g history-limit 10000   # Scrollback size
      set -g mode-keys vi          # Enable vi keymap for copy mode
      set -g status-keys vi        # Enable vi for command status
      set -g mouse on              # Enable mouse mode
      set -g renumber-windows on   # Re-index window numbers when one is closed
      set -g repeat-time 200       # Reduce key-repeat time
      set -g set-titles on         # Show tmux position in titles
      set -g visual-activity off   # Disable visual activity indication
      set -g visual-bell off       # Disable visual bell indication
      set -g visual-silence off    # Disable visual silence indication
      set -s escape-time 0         # Remove command sequence delay
      set -g base-index 1          # Set base index to 1 instead of 0
      setw -g pane-base-index 1    # Set base index of panes to 1 instead of 0
      setw -g aggressive-resize on # Window size constraint property
      setw -g monitor-activity off # Disable monitor activity

      # ----------------------------------------------------------------------
      # --- Keybinds
      # Session control
      bind N new-session                                     # Creates a new session
      bind C-\\ kill-session                                 # Kills active session
      bind '"' choose-tree -s                                # Opens the session tree
      bind . command-prompt -I "#S" "rename-session -- '%%'" # Prompts to rename session

      # Window control
      bind C-a last-window                                  # Switches to the last active window
      bind w kill-window                                    # Kills focused window
      bind n next-window                                    # Focuses next window
      bind p previous-window                                # Focuses previous window
      bind c new-window -c "#{pane_current_path}"           # Creates a new window (retaining $PWD)
      bind S split-window -c "#{pane_current_path}"         # Creates a horizontal split (retaining $PWD)
      bind | split-window -h -c "#{pane_current_path}"      # Creates a vertical split (retaining $PWD)
      bind e swap-window -t +1  \; select-window -t +1      # Swaps the current window with the next window
      bind q swap-window -t -1 \; select-window -t -1       # Swaps the current window with the previous window
      bind A command-prompt -I "#W" "rename-window -- '%%'" # Prompts to rename window

      # Pane control
      bind X kill-pane            # Kills focused pane
      bind h select-pane -L       # Focuses the left pane
      bind j select-pane -D       # Focuses the lower pane
      bind k select-pane -U       # Focuses the upper pane
      bind l select-pane -R       # Focuses the right pane
      bind -n C-e swap-pane -D    # Swaps current pane with the next one
      bind -n C-q swap-pane -U    # Swaps current pane with the previous one
      bind -nr C-h resize-pane -L # Resize pane left
      bind -nr C-j resize-pane -D # Resize pane down
      bind -nr C-k resize-pane -U # Resize pane up
      bind -nr C-l resize-pane -R # Resize pane right

      # Nested tmux control
      bind b send-prefix       # Sends prefix to nested tmux clients
      bind C-b send-prefix     # Sends prefix to nested tmux clients
      bind C-l send-keys 'C-l' # Bring back clear screen under tmux prefix

      # Copy mode
      bind [ copy-mode

      # Begins selection in 'copy-mode-vi'
      bind -T copy-mode-vi v send-keys -X begin-selection

      # Copies to macOS clipboard and ends selection in 'copy-mode-vi'
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"

      # Opens 'list-keys' window in a new vertical pane
      bind ? split-window -h 'exec tmux list-keys | less'

      # Opens a man page in a new vertical pane
      bind / command-prompt -p 'Man>' "split-window -d -h 'exec man %%'"

      # Reloads the tmux configuration
      bind R source-file $XDG_CONFIG_HOME/tmux/tmux.conf \; display "Configuration reloaded."

      # Custom layouts
      bind t run-shell 'bash -c "source ~/.config/shell/personal; tmux-side"'

      # ----------------------------------------------------------------------
      # --- Theme and status line
      # Mode
      set -g mode-style bg="#${colors.base0D}",fg="#${colors.base01}"

      #Clock
      set -g clock-mode-colour "#${colors.base0D}"
      set -g clock-mode-style 24

      # Panes
      set -g display-panes-colour "#${colors.base05}"
      set -g display-panes-active-colour "#${colors.base0D}"
      set -g pane-border-style bg="#${colors.base01}",fg="#${colors.base01}"
      set -g pane-active-border-style bg="#${colors.base01}",fg="#${colors.base01}"

      # Messages
      set -g message-style bg="#${colors.base0D}",fg="#${colors.base01}",align="centre"
      set -g message-command-style bg="#${colors.base0D}",fg="#${colors.base01}",align="centre"

      # Left status bar
      set -g status-left ""
      # set -g status-left " #S ❯ "
      set -g status-left-style bg="#${colors.base01}",fg="#${colors.base04}"
      set -g status-left-length "100"

      # Right status bar
      set -g status-right "#(hostname) "
      # set -g status-right "#(pomo) %a %I:%M %p "
      set -g status-right-style bg="#${colors.base01}",fg="#${colors.base05}"
      set -g status-right-length "100"

      # Status
      set -g status "on"
      set -g status-interval 1
      set -g status-justify left
      set -g status-position top
      set -g status-style bg="#${colors.base01}",fg="#${colors.base05}"

      # Windows
      set -g window-status-separator ""
      set -g window-status-format " #{b:pane_current_path} "
      set -g window-status-current-format " #{b:pane_current_path} "
      set -g window-status-style bg="#${colors.base01}",fg="#${colors.base04}"
      set -g window-status-current-style bg="#${colors.base0D}",fg="#${colors.base01}"
      set -g window-status-activity-style bg="#${colors.base01}",fg="#${colors.base05}"
    '';
  };
}
