{config, ...}: {
  programs = {
    btop = {
      enable = true;
      settings = {
        color_theme = "catppuccin";
        theme_background = false;
        true_color = true;
        vim_keys = true;
        update_ms = 2000;
        proc_sorting = "cpu lazy";
        proc_tree = true;
      };
    };
  };
  xdg.configFile = with config.colorscheme; {
    "btop/catppuccin.theme".text = ''
      # Main background, empty for terminal default, need to be empty if you want transparent background
      theme[main_bg]="${colors.base00}"

      # Main text color
      theme[main_fg]="#${colors.base05}"

      # Title color for boxes
      theme[title]="#${colors.base05}"

      # Highlight color for keyboard shortcuts
      theme[hi_fg]="#${colors.base0D}"

      # Background color of selected item in processes box
      theme[selected_bg]="#${colors.base03}"

      # Foreground color of selected item in processes box
      theme[selected_fg]="#${colors.base0D}"

      # Color of inactive/disabled text
      theme[inactive_fg]="#${colors.base04}"

      # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
      theme[graph_text]="#${colors.base06}"

      # Background color of the percentage meters
      theme[meter_bg]="#${colors.base03}"

      # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
      theme[proc_misc]="#${colors.base06}"

      # CPU, Memory, Network, Proc box outline colors
      theme[cpu_box]="#${colors.base0E}"
      theme[mem_box]="#${colors.base0B}"
      theme[net_box]="#${colors.base0F}"
      theme[proc_box]="#${colors.base0D}"

      # Box divider line and small boxes line color
      theme[div_line]="#${colors.base02}"

      # Temperature graph color
      theme[temp_start]="#${colors.base0B}"
      theme[temp_mid]="#${colors.base0A}"
      theme[temp_end]="#${colors.base08}"

      # CPU graph colors
      theme[cpu_start]="#${colors.base0C}"
      theme[cpu_mid]="#${colors.base0D}"
      theme[cpu_end]="#${colors.base07}"

      # Mem/Disk free meter
      theme[free_start]="#${colors.base0E}"
      theme[free_mid]="#${colors.base07}"
      theme[free_end]="#${colors.base0D}"

      # Mem/Disk cached meter
      theme[cached_start]="#${colors.base0D}"
      theme[cached_mid]="#${colors.base0D}"
      theme[cached_end]="#${colors.base07}"

      # Mem/Disk available meter
      theme[available_start]="#${colors.base0F}"
      theme[available_mid]="#${colors.base09}"
      theme[available_end]="#${colors.base08}"

      # Mem/Disk used meter
      theme[used_start]="#${colors.base0B}"
      theme[used_mid]="#${colors.base0C}"
      theme[used_end]="#${colors.base0D}"

      # Download graph colors
      theme[download_start]="#${colors.base0F}"
      theme[download_mid]="#${colors.base09}"
      theme[download_end]="#${colors.base08}"

      # Upload graph colors
      theme[upload_start]="#${colors.base0B}"
      theme[upload_mid]="#${colors.base0C}"
      theme[upload_end]="#${colors.base0D}"

      # Process box color gradient for threads, mem and cpu usage
      theme[process_start]="#${colors.base0C}"
      theme[process_mid]="#${colors.base0D}"
      theme[process_end]="#${colors.base0E}"
    '';
  };
}
