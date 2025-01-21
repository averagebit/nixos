{pkgs, ...}: {
  programs.bash = {
    enable = true;
    historyControl = ["erasedups" "ignorespace"];
    historyFile = "$HOME/.local/state/bash/history";

    shellAliases = {
      "?" = "duck";
      "cd.." = "cd ..";
      ls = "ls -lah --color";
      chmox = "chmod +x";
      temp = "cd $(mktemp -d)";
      reload = "source $HOME/.bashrc";
    };

    initExtra = ''
      umask 0027

      source $HOME/documents/env

      export WORKSPACE="$HOME/workspace"
      export RECON="$WORKSPACE/recon"
      export REPOS="$WORKSPACE/repos"
      export GHREPOS="$REPOS/github.com"
      export GLREPOS="$REPOS/gitlab.com"
      export NOTES="$HOME/workspace/notes"

      export CDPATH=".:$REPOS:$GHREPOS:$GHREPOS/$USER:$GLREPOS:$GLREPOS/$USER:$WORKSPACE:$RECON:$HOME"

      export GOBIN="$HOME/.local/bin"
      export GOPATH="$XDG_DATA_HOME/go"
      export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

      export CARGO_HOME="$XDG_DATA_HOME/cargo"
      export RUSTUP_HOME="$XDG_DATA_HOME/rust"

      export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
      export ANSIBLE_GALAXY_CACHE_DIR="$XDG_CACHE_HOME/ansible/galaxy_cache"
      export ANSIBLE_HOME="$XDG_CONFIG_HOME/ansible"
      export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
      export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
      export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
      # export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
      export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
      export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
      export K9SCONFIG="$XDG_CONFIG_HOME/k9s"
      export KDEHOME="$XDG_CONFIG_HOME/kde"
      export KUBECONFIG="$XDG_CONFIG_HOME/kube/config"
      export LYNX_CFG="$XDG_CONFIG_HOME/lynx/lynx.cfg"
      export LYNX_LSS="$XDG_CONFIG_HOME/lynx/lynx.lss"
      export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
      export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
      export NVM_DIR="$XDG_DATA_HOME/nvm"
      export PNPM_HOME="$XDG_DATA_HOME/pnpm"
      export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
      export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
      export PYTHONUSERBASE="$XDG_DATA_HOME/python"
      export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
      export REDISCLI_HISTFILE="$XDG_DATA_HOME/redis/rediscli_history"
      export REDISCLI_RCFILE="$XDG_CONFIG_HOME/redis/redisclirc"
      export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"
      export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
      export TERMINFO="$XDG_DATA_HOME/terminfo"
      export TERMINFO_DIRS="$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
      export WINEPREFIX="$XDG_DATA_HOME/wine/default"
      export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
      export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

      function clone() {
          local output repo_dir
          output="$("${pkgs.clone}/bin/clone" -d "$REPOS" -u "$USER" -r "github.com" "$@" 2>&1 | tee /dev/tty)"
          repo_dir="$(echo "$output" | tail -n 1)"
          [[ -d "$repo_dir" ]] && cd "$repo_dir" || return 1
      }

      function pathappend() {
          declare arg
          for arg in "$@"; do
              test -d "$arg" || continue
              PATH=''${PATH//":$arg:"/:}
              PATH=''${PATH/#"$arg:"/}
              PATH=''${PATH/%":$arg"/}
              export PATH="''${PATH:+"$PATH:"}$arg"
          done
      }

      function pathprepend() {
          for arg in "$@"; do
              test -d "$arg" || continue
              PATH=''${PATH//:"$arg:"/:}
              PATH=''${PATH/#"$arg:"/}
              PATH=''${PATH/%":$arg"/}
              export PATH="$arg''${PATH:+":''${PATH}"}"
          done
      }

      pathprepend \
          "$PNPM_HOME" \
          "$CARGO_HOME/bin" \
          "$GOBIN" \
          "$HOME/.local/bin" \
          "$FLAKE/result/bin"

      pathappend \
          /usr/local/sbin \
          /usr/local/bin \
          /usr/sbin \
          /usr/bin \
          /sbin \
          /bin
    '';
  };

  home.file.".config/npm/npmrc".text = ''
    prefix=~/.local/share/npm
    cache=~/.cache/npm
    init-module=~/.config/npm/config/npm-init.js
    logs-dir=~/.local/state/npm/logs
    store-dir=~/.local/share/pnpm-store
  '';
}
