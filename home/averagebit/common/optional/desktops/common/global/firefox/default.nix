{
  config,
  pkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles."${config.home.username}" = {
      name = "${config.home.username}";
      isDefault = true;

      extensions = {
        force = true;
        packages = with pkgs.inputs.firefox-addons; [
          bitwarden
          ublock-origin
        ];
      };

      search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";
        order = ["ddg" "kagi" "google"];

        engines = {
          bing.metaData.hidden = true;
          "Kagi" = {
            name = "Kagi";
            urls = [{template = "https://kagi.com/search?q={searchTerms}";}];
            icon = "https://kagi.com/favicon.ico";
          };
          "Nix Wiki" = {
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nw"];
          };
          "Nix Packages" = {
            urls = [{template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          "Nix Options" = {
            urls = [{template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
          };
          "Home Manager Options" = {
            urls = [{template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@ho"];
          };
        };
      };

      bookmarks = {
        force = true;
        settings = [
          {
            name = "Local";
            toolbar = false;
            bookmarks = [
              {
                name = "Router";
                tags = ["local"];
                keyword = "router";
                url = "https://router.home.arpa/";
              }
              {
                name = "Wi-Fi";
                tags = ["local"];
                keyword = "wifi";
                url = "https://wifi.home.arpa/";
              }
            ];
          }
          {
            name = "Self-Hosted";
            toolbar = false;
            bookmarks = [
              {
                name = "Home";
                tags = ["services"];
                keyword = "home";
                url = "https://home.averagebit.com/";
              }
              {
                name = "Grafana";
                tags = ["services"];
                keyword = "dash";
                url = "https://dash.averagebit.com/";
              }
              {
                name = "TV";
                tags = ["services"];
                keyword = "tv";
                url = "https://tv.averagebit.com/";
              }
              {
                name = "Music";
                tags = ["services"];
                keyword = "music";
                url = "https://music.averagebit.com/";
              }
              {
                name = "Books";
                tags = ["services"];
                keyword = "books";
                url = "https://books.averagebit.com/";
              }
              {
                name = "Git";
                tags = ["services"];
                keyword = "git";
                url = "https://git.averagebit.com/";
              }
            ];
          }
          {
            name = "Services";
            toolbar = false;
            bookmarks = [
              {
                name = "Discord";
                tags = ["services"];
                keyword = "discord";
                url = "https://discord.com/app/";
              }
              {
                name = "Twitch";
                tags = ["services"];
                keyword = "twitch";
                url = "https://twitch.tv/";
              }
              {
                name = "Docker";
                tags = ["services"];
                keyword = "docker";
                url = "https://hub.docker.com/";
              }
              {
                name = "ChatGPT";
                tags = ["services"];
                keyword = "gpt";
                url = "https://chat.openai.com/";
              }
              {
                name = "GitHub";
                tags = ["services"];
                keyword = "gh";
                url = "https://github.com/";
              }
              {
                name = "Wire";
                tags = ["services"];
                keyword = "wire";
                url = "https://app.wire.com/";
              }
              {
                name = "NPM";
                tags = ["services"];
                keyword = "npm";
                url = "https://npmjs.com/";
              }
              {
                name = "Proton";
                tags = ["services"];
                keyword = "pmail";
                url = "https://mail.proton.me/";
              }
              {
                name = "Gmail";
                tags = ["services"];
                keyword = "mail";
                url = "https://mail.google.com/";
              }
              {
                name = "Cloudflare";
                tags = ["services"];
                keyword = "cf";
                url = "https://dash.cloudflare.com/";
              }
              {
                name = "Figma";
                tags = ["services"];
                keyword = "figma";
                url = "https://figma.com/files/";
              }
              {
                name = "Chess";
                tags = ["services"];
                keyword = "chess";
                url = "https://chess.com/";
              }
              {
                name = "Lichess";
                tags = ["services"];
                keyword = "lichess";
                url = "https://lichess.org/";
              }
              {
                name = "Spotify";
                tags = ["services"];
                keyword = "spotify";
                url = "https://open.spotify.com/";
              }
              {
                name = "Languagetool";
                tags = ["services"];
                keyword = "languagetool";
                url = "https://languagetool.org/";
              }
              {
                name = "Shodan";
                tags = ["services"];
                keyword = "shodan";
                url = "https://shodan.io/";
              }
              {
                name = "Greynoise";
                tags = ["services"];
                keyword = "greynoise";
                url = "https://greynoise.io/";
              }
              {
                name = "DNS Leak Test";
                tags = ["services"];
                keyword = "dnsleak";
                url = "https://dnsleaktest.com/";
              }
              {
                name = "Reddit";
                tags = ["services"];
                keyword = "reddit";
                url = "https://reddit.com/";
              }
              {
                name = "Google";
                tags = ["services"];
                keyword = "google";
                url = "https://google.com/";
              }
              {
                name = "YouTube";
                tags = ["services"];
                keyword = "yt";
                url = "https://youtube.com/";
              }
              {
                name = "DuckDuckGo";
                tags = ["services"];
                keyword = "ddg";
                url = "https://duckduckgo.com/";
              }
              {
                name = "Notion";
                tags = ["services"];
                keyword = "notion";
                url = "https://notion.so/";
              }
              {
                name = "Twitter";
                tags = ["services"];
                keyword = "x";
                url = "https://twitter.com/";
              }
            ];
          }
        ];
      };

      settings = {
        "app.shield.optoutstudies.enabled" = false;
        "browser.bookmarks.addedImportButton" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.disableResetPrompt" = true;
        "browser.discovery.enabled" = false;
        "browser.download.panel.shown" = true;
        "browser.download.useDownloadDir" = false;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "about:home";
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.tabs.inTitlebar" = 0;
        "browser.uitour.enabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "dom.security.https_only_mode" = true;
        "extensions.autoDisableScopes" = 0;
        "extensions.update.autoUpdateDefault" = false;
        "extensions.update.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "sidebar.main.tools" = ["history" "bookmarks"];
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = false;
        "signon.rememberSignons" = false;
        "startup.homepage_override_url" = "";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "ui.systemUsesDarkTheme" = true;
        "layout.css.prefers-color-scheme.content-override" = true;
        "browser.display.force_dark_mode" = true;
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };

  # home.persistence = {
  #   "/persist/".directories = [".mozilla/firefox"];
  # };
}
