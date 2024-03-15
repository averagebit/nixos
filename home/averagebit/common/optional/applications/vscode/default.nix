{
  config,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      esbenp.prettier-vscode
      golang.go
      ms-azuretools.vscode-docker
      prisma.prisma
      rust-lang.rust-analyzer
      tailscale.vscode-tailscale
    ];
    userSettings = {
      # General
      "telemetry.telemetryLevel" = "off";
      "explorer.autoReveal" = false;
      "explorer.confirmDragAndDrop" = false;
      "files.autoSave" = "onFocusChange";
      "files.hotExit" = "off";
      "files.insertFinalNewline" = true;
      "files.trimTrailingWhitespace" = true;

      # Editor
      "editor.acceptSuggestionOnEnter" = "off";
      "editor.codeLens" = true;
      "editor.cursorBlinking" = "solid";
      "editor.cursorSmoothCaretAnimation" = "off";
      "editor.detectIndentation" = false;
      "editor.fontFamily" = "monospace";
      "editor.fontLigatures" = true;
      # "editor.fontSize" = 14;
      "editor.formatOnPaste" = true;
      "editor.formatOnSave" = true;
      "editor.insertSpaces" = true;
      # "editor.lineHeight" = 15;
      "editor.lineNumbers" = "relative";
      "editor.linkedEditing" = true;
      "editor.matchBrackets" = "near";
      "editor.minimap.enabled" = false;
      "editor.multiCursorModifier" = "ctrlCmd";
      "editor.occurrencesHighlight" = "off";
      "editor.renderWhitespace" = "selection";
      "editor.scrollBeyondLastLine" = false;
      "editor.smoothScrolling" = true;
      "editor.snippetSuggestions" = "top";
      "editor.tabSize" = 4;
      "editor.trimAutoWhitespace" = true;
      # "editor.wordWrapColumn" = 80;
      # "editor.wordWrap" = "wordWrapColumn";
      "editor.wordWrap" = "off";
      "editor.wrappingIndent" = "same";
      "workbench.editor.tabSizing" = "shrink";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.editor.enablePreview" = true;
      "workbench.editor.enablePreviewFromQuickOpen" = true;
      "workbench.fontAliasing" = "auto";
      "workbench.quickOpen.preserveInput" = true;
      "workbench.settings.editor" = "json";
      "workbench.settings.openDefaultKeybindings" = false;
      "workbench.settings.openDefaultSettings" = false;
      "workbench.settings.useSplitJSON" = false;
      "workbench.sideBar.location" = "right";
      "workbench.startupEditor" = "newUntitledFile";
      "workbench.statusBar.visible" = true;
      "workbench.editor.limit.enabled" = false;
      "workbench.editor.limit.perEditorGroup" = false;
      "workbench.editor.limit.value" = 10;

      # Window
      "window.newWindowDimensions" = "fullscreen";
      "window.closeWhenEmpty" = true;
      "window.nativeFullScreen" = false;
      "window.nativeTabs" = false;
      "window.restoreFullscreen" = true;

      # Zen mode
      "zenMode.centerLayout" = true;
      "zenMode.fullScreen" = true;
      "zenMode.hideActivityBar" = true;
      "zenMode.hideLineNumbers" = true;
      "zenMode.hideStatusBar" = true;
      "zenMode.restore" = true;

      # Console
      "debug.console.fontFamily" = "monospace";
      # "debug.console.fontSize"= 12;
      "debug.console.lineHeight" = 0;
      "debug.console.wordWrap" = true;

      # Formatting
      "[nix]"."editor.tabSize" = 2;

      "editor.defaultFormatter" = null;
      "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.codeActionsOnSave"."source.fixAll.eslint" = "explicit";

      # Exclude patterns
      "files.exclude" = {
        "**/.DS_Store" = true;
        "**/.git" = true;
        "**/.hg" = true;
        "**/.pytest_cache" = true;
        "**/.svn" = true;
        "**/CVS" = true;
        "**/__pycache__" = true;
        "**/node_modules" = true;
        "**/package-lock.json" = true;
        "**/yarn-error.log" = true;
        "**/yarn.lock" = true;
        "*.sublime-*" = true;
        "env*" = true;
        "venv" = true;
      };
      "search.exclude" = {
        "**/bower_components" = true;
        "**/env" = true;
        "**/node_modules" = true;
        "**/vendor" = true;
        "**/venv" = true;
      };
      "files.watcherExclude" = {
        "**/.git/objects/**" = true;
        "**/.git/subtree-cache/**" = true;
        "**/env/**" = true;
        "**/node_modules/**" = true;
        "**/venv/**" = true;
        "env-*" = true;
      };
    };
  };

  home.persistence = {
    "/persist/home/${config.home.username}".directories = [".config/Code"];
  };
}
