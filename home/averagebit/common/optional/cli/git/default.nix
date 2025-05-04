{config, ...}: {
  programs.git = {
    enable = true;
    userName = "averagebit";
    userEmail = "averagebit@pm.me";
    includes = [{path = "~/.git/extra-config";}];
    aliases = {co = "checkout";};

    signing = {
      key = "202C2696DF698259";
      signByDefault = true;
    };

    extraConfig = {
      init.defaultBranch = "main";
      user.signing.key = "202C2696DF698259";
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
      commit = {
        template = "$HOME/.config/git/commit-message";
        gpgsign = true;
      };
      tag = {
        gpgsign = true;
        sort = "-v:refname";
      };
      pull.rebase = false;
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      merge.conflictstyle = "diff3";
      branch.sort = "-committerdate";
      core = {
        editor = "vi";
        pager = "less";
      };
      lfs.enable = true;
      filter.lfs = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };
    };

    ignores = [
      ### Nix ###
      ".direnv"
      "result*"

      ### Linux ###
      "*~"

      # temporary files which can be created if a process still has a handle open of a deleted file
      ".fuse_hidden*"

      # KDE directory preferences
      ".directory"

      # Linux trash folder which might appear on any partition or disk
      ".Trash-*"

      # .nfs files are created when an open file is removed but is still being accessed
      ".nfs*"

      ### macOS ###
      # General
      ".DS_Store"
      ".AppleDouble"
      ".LSOverride"

      # Icon must end with two \r
      "Icon"

      # Thumbnails
      "._*"

      # Files that might appear in the root of a volume
      ".DocumentRevisions-V100"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".VolumeIcon.icns"
      ".com.apple.timemachine.donotpresent"

      # Directories potentially created on remote AFP share
      ".AppleDB"
      ".AppleDesktop"
      "Network Trash Folder"
      "Temporary Items"
      ".apdisk"

      ### Windows ###
      # Windows thumbnail cache files
      "Thumbs.db"
      "Thumbs.db:encryptable"
      "ehthumbs.db"
      "ehthumbs_vista.db"

      # Dump file
      "*.stackdump"

      # Folder config file
      "[Dd]esktop.ini"

      # Recycle Bin used on file shares
      "$RECYCLE.BIN/"

      # Windows Installer files
      "*.cab"
      "*.msi"
      "*.msix"
      "*.msm"
      "*.msp"

      # Windows shortcuts
      "*.lnk"

      ### Vim ###
      # Swap
      "[._]*.s[a-v][a-z]"
      "!*.svg" # comment out if you don't need vector files
      "[._]*.sw[a-p]"
      "[._]s[a-rt-v][a-z]"
      "[._]ss[a-gi-z]"
      "[._]sw[a-p]"

      # Session
      "Session.vim"
      "Sessionx.vim"

      # Temporary
      ".netrwhist"
      "*~"

      # Auto-generated tag files
      "tags"

      # Persistent undo
      "[._]*.un~"
    ];
  };

  xdg.configFile."git/commit-message".text = ''
    # <type>[optional scope]: <description>                                  (not more than 72 chars)
    # <BLANK NEWLINE>
    # [optional body]                                                        (not more than 72 chars)
    # <BLANK NEWLINE>
    # [optional footer(s)]                                                   (not more than 72 chars)
    #-------------------------------EXAMPLE----------------------------------
    # feat!(frontend): new button added in dashboard
    #
    # A new "Follow Us" button is added in your Account dashboard.
    # If you don't see it, please delete your browser cache and reload the
    # webpage.
    #
    # BREAKING CHANGE: this button replaces the custom button you have,
    # you need to reconfigure your custom button.
  '';
}
